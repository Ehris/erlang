-module(ring).
-export([go_ring/3,child/0]).

% We have two approches here: One is to have single master process launching
% N processes and the other one is to make one process start another one.

% Here is the first one:

process_msg(To, Msg) ->
	io:format("message to ~p: ~s~n", [To, Msg]).

child(NPid) ->
	receive
		stop -> exit(ok);
		Msg ->
			process_msg(NPid, Msg),
			NPid ! Msg,
			child(NPid)
	end.

child() ->
	receive
		NPid -> io:format("I (~p) got this NPid: ~p~n" ,[self(), NPid]), child(NPid)
	end.

master(Child, 0, _) ->
	Child ! stop;
master(Child, M, Msg) ->
	process_msg(Child, Msg ++ " (master)"),
	Child ! Msg,
	receive
		Msg -> io:format("master got the message(~p), ~B remaining.~n", [Msg, M-1])
	end,
	master(Child, M-1, Msg).

go_ring(N, M, Msg) ->
	C = lists:map(fun(_) -> spawn(ring, child, []) end, lists:seq(1,N-1)),
	lists:foreach(fun({CPid, Next}) -> CPid ! Next end, lists:zip(C, tl(C ++ [self()]))),
	master(hd(C), M, Msg).
