-module(fun_rev).
-export([reverse/1]).
reverse(List) -> reverse(List, []).
reverse([Head | Rest], Reversed_List) -> reverse(Rest, [Head | Reversed_List]);
reverse([], Reversed_List) ->Reversed_List.


-module(fib).
-export([fib/1]).

fib(1) -> 1;
fib(0) -> 0;
fib (N) when N>1 -> fib(N-2) + fib(N-1).


%Laufzeit ist n², da immer zwei Funktionen berechnet werden müssen% 


-module(redump).
-export([remdup/1]).

remdup(List) -> remdup(List,[]). 

remdup([H|T],List2) -> remdup(T,[H|List2]--T);
remdup([],List2)->List2.


-module(removeOdd).
-export([remOdd/1]).

remOdd(List)->[X || X <- List, X rem 2 ==0].



-module(scalarProduct).
-export([scalarProduct/2]).

%wenn in den Listen keine Parameter stehen
scalarProduct([],[])-> 0;
scalarProduct([],List)->List;
scalarProduct(List,[])->List;
%sonst heads der Listen multiplizieren und dann rekursiv weiter
scalarProduct([H1|T1],[H2|T2])-> H1*H2+scalarProduct(T1,T2).


-module(ackermann).
-export([ackermann/2]).

ackermann(0,Y) -> Y+1;
ackermann(X,0) -> ackermann(X-1,1);
ackermann(X,Y) -> ackermann(X-1,ackermann(X,Y-1)).


% (3,11) ca. 6s
% (4,1) ca. 40s
% Ab x=4 wächst die Ackermann Funktion sehr schnell. Demensprechend erhöht sich auch die Laufzeit 
% ab x=4 immer mehr.
