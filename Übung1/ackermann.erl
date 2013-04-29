-module(ackermann).
-export([ackermann/2]).

ackermann(0,Y) -> Y+1;
ackermann(X,0) -> ackermann(X-1,1);
ackermann(X,Y) -> ackermann(X-1,ackermann(X,Y-1)).


% (3,11) ca. 6s
% (4,1) ca. 40s
% Ab x=4 wächst die Ackermann Funktion sehr schnell. Demensprechend erhöht sich auch die Laufzeit 
% ab x=4 immer mehr.
