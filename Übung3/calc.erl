-module(calc).
-export([calcu/0,test/0]).

calcu()->
	receive
		{Pid, F, Val}-> Pid ! apply(F,Val), calcu()
	end.
	
	
test()->  P = spawn(calc,calcu,[]),
           P ! {self(),fun(X,Y)->X*Y end,[5,7]},
           receive
				Result	-> io:format("result: ~w~n", [Result])
			end.
