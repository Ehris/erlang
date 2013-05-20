-module(printing).
-export([go/0, stop/0, print/1]).

%register associates the name "printing" with the process Pid
go()->register(printing,spawn(fun loop/0)).

stop()-> printing ! stop.

print(TXT)-> printing ! {print,TXT}.

loop()->
	receive
		{print,TXT}->io:format("~p~n",[TXT]),
		loop();
		stop->true
	end.

