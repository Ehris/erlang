-module(flip).
-export([flip/1, flipc/1,test/2]).


flip(Foo2)->fun(X,Y)->Foo2(Y,X) end.

flipc(Foo2)-> fun(X)->(fun(Y)->Foo2(Y,X) end) end.

test(A,B)->[A|B].
