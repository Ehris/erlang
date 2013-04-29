-module(pyTriple).
-export([pyTriple/1, ppT/1]).

pyTriple(N) -> [{X, Y, Z} || 
	X <- take(N,ints_from(2)), 
	Y <- take(N,ints_from(X+1)),
	Z <-take(N,ints_from(Y+1)),
	X*X+Y*Y==Z*Z].

%b)
%Es gilt x²+y² = z² -> wenn alles mit dem gleichen Faktor multipliziert wird, wird diese Gleichung nicht
%verletzt und somit ist dies wieder ein pythagoräisches Tripel
%
ints_from(N) ->

    fun() ->

        [N|ints_from(N+1)]

    end.



take(N,Lazy) ->

    if 

        N == 0 -> [];

        true -> [hd(Lazy()) | take(N-1,tl(Lazy()))]

    end.
