-module(ham).
-export([hamming/0]).



%sortieren und einordnen der Elemente mit Hilfe von usort( doppelte Elemente heraus filtern) und mergeStream()
%hammin()->
 % fun()->
 %   	lists:usort([N ,mergeStream(  mergeStream(  scaleStream(2,hamming(), scaleStream(3,hamming()),  scaleStream(3,hamming()))  | hamming_from(N+1)])
 % end.
 


scaleStream(N,Lazy)->map(fun(Y) -> Y*N end ,Lazy()).

mergeStream(Lazy1,Lazy2)->[lists:merge(hd(Lazy1()),hd(Lazy2()))|mergeStream(tl(Lazy1),tl(Lazy2))].
                         

ints() -> ints_from(1).

ints_from(N) ->
    fun() ->
        [N|ints_from(N+1)]
    end.

take(N,Lazy) ->
    if 
        N == 0 -> [];
        true -> [hd(Lazy()) | take(N-1,tl(Lazy()))]
    end.

map(F, Lazy) ->
    fun() ->
        [ F(hd(Lazy())) | map(F, tl(Lazy())) ]
    end.

