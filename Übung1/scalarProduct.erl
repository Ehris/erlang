-module(scalarProduct).
-export([scalarProduct/2]).

%wenn in den Listen keine Parameter stehen
scalarProduct([],[])-> 0;
scalarProduct([],List)->List;
scalarProduct(List,[])->List;
%sonst heads der Listen multiplizieren und dann rekursiv weiter
scalarProduct([H1|T1],[H2|T2])-> H1*H2+scalarProduct(T1,T2).
