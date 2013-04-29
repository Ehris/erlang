-module(redump).
-export([remdup/1]).

remdup(List) -> remdup(List,[]). 

remdup([H|T],List2) -> remdup(T,[H|List2]--T);
remdup([],List2)->List2.


