-module(fib).
-export([fib/1]).

fib(1) -> 1;
fib(0) -> 0;
fib (N) when N>1 -> fib(N-2) + fib(N-1).


%Laufzeit ist n², da immer zwei Funktionen berechnet werden müssen% 
