-module(lazy).
-export([ints/0, ints_from/1,take/2, drop/2, add/2, fibgen/2]).


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

drop(N,Lazy) ->
    if 
        N == 0 -> Lazy;
        true -> drop(N-1,tl(Lazy()))
    end.

add([], _) -> [];
add(_, []) -> [];
add(Lazy1, Lazy2) -> 
    fun() ->
        [hd(Lazy1()) + hd(Lazy2()) | add(tl(Lazy1()), tl(Lazy2()))]
    end.
