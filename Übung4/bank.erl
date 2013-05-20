-module(bank).
-export([go_bank/1, manager/1, client/1]).

manager(Kontostand) ->
	receive
		{get, Pid} ->
			Pid ! Kontostand;
		{reduce, Pid, Amount} ->
			case (Kontostand - Amount) > 0 of
				true ->
					Pid ! true,
					manager(Kontostand - Amount);
				false ->
					Pid ! false,
					manager(Kontostand)
			end;
		stop ->	exit(ok)
	end.

client(Manager) ->
	random:seed(erlang:now()),
	timer:sleep(random:uniform(5)*1000),
	X = random:uniform(100),
	Manager ! {reduce, self(), X},
	receive
		Status -> io:format("Buch ~B Euro ab -- ~p~n", [X, Status])
	end,
	client(Manager).

go_bank(Kontostand) ->
	M = spawn(bank, manager, [Kontostand]),
	spawn(bank, client, [M]),
	spawn(bank, client, [M]).