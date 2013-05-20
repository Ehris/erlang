-module(chat).
-export([server/0, echo_client/1, test/0]).

server() ->
	receive
		{SenderPid, ReceiverPid, Msg} ->
			ReceiverPid ! {SenderPid, Msg},
			server();
		stop ->
			exit(ok);
		_ ->
			server()
	end.

echo_client(ServerPid) ->
	receive
		{SenderPid, Msg} ->
			io:format("incoming: ~s~n", [Msg]),
			ServerPid ! {self(), SenderPid, Msg},
			echo_client(ServerPid);
		stop ->
			exit(ok)
	end.

test() ->
	Server = spawn(chat, server, []),
	Client = spawn(chat, echo_client, [Server]),
	Server ! {self(), Client, "hallo"},
	receive
		{_, Msg} ->
			io:format("answer: ~s~n", [Msg])
	end.
