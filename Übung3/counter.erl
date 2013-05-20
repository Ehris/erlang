-module(counter).
-export([test/0,start/1, stop/1, increment/1, decrement/1, show/2, go/1]).


go(X)->
	receive
				increment -> go(X+1);
				decrement	-> go(X-1);
				{show,Pid} 	->	Pid ! X,
								go(X);
				
				stop -> exit(ok)
		end.


start(X)-> spawn(counter,go,[X]).
			
increment(Pid) ->
	Pid ! increment.

decrement(Pid) ->
	Pid ! decrement.

stop(Pid) ->
	Pid ! stop.

show(Pid, To) ->
	Pid ! {show, To}.

show(Pid) ->
	show(Pid, self()),
	receive
		Value -> io:format("value: ~w~n", [Value])
	end.
			
			
		
test() ->
	Pid = start(15),
	increment(Pid),
	increment(Pid),
	increment(Pid),
	show(Pid),
	decrement(Pid),
	show(Pid),
	decrement(Pid),
	show(Pid),
	stop(Pid).
	
