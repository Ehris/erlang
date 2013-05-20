-module(filter).
-export([ints/0, take/2, filter/2, takeOdds/1]).


next(Pred,Lazy)->
	P=Pred(hd(Lazy())),
	if
		%if odd
		P -> Lazy();
		true -> next(Pred,tl(Lazy()))
	end.



filter(Pred,Lazy) -> 
	fun()->
			X= next(Pred,Lazy),
			[hd(Lazy()) | filter(Pred , tl(X))]
	end.
	



takeOdds(N) -> take(N,filter(fun(X)->(X rem 2)==0 end,ints())).





ints() -> ints_from(0).

ints_from(N) ->
    fun() ->
        [N|ints_from(N+1)]
    end.

take(N,Lazy) ->
    if 
        N == 0 -> [];
        true -> [hd(Lazy()) | take(N-1,tl(Lazy()))]
    end.
