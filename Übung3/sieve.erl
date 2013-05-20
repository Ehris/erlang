-module(sieve).
-export([takePrims/1]).

sieve(Lazy) -> 
		fun()->
			Rest = filter(fun(X)-> (X rem hd(Lazy()))==0 end, tl(Lazy())), 
			[hd(Lazy()) | sieve(Rest)]
		end.


takePrims(N)  ->  take(N,sieve(ints_from(2))).  



next(Pred,Lazy)->
	P=Pred(hd(Lazy())),
	if
		P -> Lazy();
		true -> next(Pred,tl(Lazy()))
	end.



filter(Pred,Lazy) -> 
	fun()->
			X= next(Pred,Lazy),
			[hd(Lazy()) | filter(Pred , tl(X))]
	end.

ints_from(N) ->
    fun() ->
        [N|ints_from(N+1)]
    end.

take(N,Lazy) ->
    if 
        N == 0 -> [];
        true -> [hd(Lazy()) | take(N-1,tl(Lazy()))]
    end.
	
