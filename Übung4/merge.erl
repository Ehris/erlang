-module(merge).
-export([msort/1,msort/3]).

split(Lst) ->
	split(Lst, Lst, []).

split([], L1, L2) ->
	{lists:reverse(L2), L1};
split([_], L1, L2) ->
	{lists:reverse(L2), L1};
split([_,_|TT], [H1|T1], L2) ->
	split(TT, T1, [H1|L2]).

merge(_, [], L2) -> L2;
merge(_, L1, []) -> L1;
merge(Rel, [H1|T1], [H2|T2]) ->
	case Rel(H1, H2) of
		true ->
			[H1 | merge(Rel, T1, [H2|T2])];
		false ->
			[H2 | merge(Rel, [H1|T1], T2)]
	end.

msort(Parent, _, []) -> Parent ! [];
msort(Parent, _, [H]) -> Parent ! [H];
msort(Parent, Rel, Lst) ->
	{H1, H2} = split(Lst),
	spawn(merge, msort, [self(), Rel, H1]),
	spawn(merge, msort, [self(), Rel, H2]),
	receive
		R1 ->
			receive
				R2 -> Parent ! merge(Rel, R1, R2)
			end
	end.

msort(Lst) ->
	msort(self(), fun(X,Y) -> (X == Y) or (X < Y) end, Lst),
	receive
		R ->
			R
	end.
