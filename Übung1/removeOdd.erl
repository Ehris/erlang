-module(removeOdd).
-export([remOdd/1]).

remOdd(List)->[X || X <- List, X rem 2 ==0].
