-module(db).
-export([create/0, create/1, get/2, set/3]).

% We can not assure that the user won't enter a key we don't know.
% Thus, we return false if we can't find the key.
find([], _) -> false;
find([{K,V}|T], Key) ->
	case K == Key of
		true -> V;
		false -> find(T, Key)
	end.


create(Values) ->
	receive
		{get, Pid, K} ->
			Pid ! (find(Values, K)),
			create(Values);
		{set, K, V} ->
			create([{K,V}|Values]);
		stop ->
			exit(ok)
	end.

create() ->
	spawn(db, create, [[]]).

get(DBPid, Key) ->
	DBPid ! {get, self(), Key},
	receive
		Value -> Value
	end.

set(DBPid, Key, Value) ->
	DBPid ! {set, Key, Value}.