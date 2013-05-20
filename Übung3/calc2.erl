-module(calc2).
-export([cal/0, test/0]).

cal()->
	receive
		{Pid,F1,F2,Arg1,Arg2}->
			Pid ! apply(F1,Arg1),
			Pid ! apply(F2,Arg2),
			Pid !
			cal()
	end.
	
test()->
	Pid = spawn(calc2,calc,[]),
	Pid ! (self(),fun(X,Y) -> X*Y end, fun(A,B)->A+B end,[2,3],[2,3]},
	receive	
		Result -> io:format("result: ~B~n", [Result])
	end.
	
