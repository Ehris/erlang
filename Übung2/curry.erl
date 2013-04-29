-module(curry).
-export([curry3/1, replace/3, replaceLL/3]).

curry3(Foo)->
	fun(X)->
		(fun(Y)->
			(fun(Z) ->
				Foo(X,Y,Z)
			end)
		end)
	end.


%ersetzt das Element E der Liste durch das Element E, falls I==E
replace(E,N_E,List) -> lists:map(fun(I)-> 
				if 
					I==E-> N_E; 
					I/=E -> I 
					end 
				end,List).


%ersetzt das Element E in den Listen durch Aufruf von replace für die Listen in der Liste
replaceLL(E,N_E,ListList)-> lists:map(fun(A)->replace(E,N_E,A) end, ListList).
