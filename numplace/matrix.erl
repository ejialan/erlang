-module(matrix).
-export([]).
-compile(export_all).

toBlockIndex(R, C) ->
    ((R-1) div 3 )*3 + ((C-1) div 3) + 1.

toBlockInnerIndex(R, C) ->
    ((R-1) rem 3 )*3 + ((C-1) rem 3) + 1.

square(N, M) ->
    lists:nth(N, M).

square(R, C, M) ->
    lists:nth(toBlockIndex(R,C), M).

element(R, C, M) ->
    lists:nth(toBlockInnerIndex(R,C), square(R,C,M)).

row(R, M) ->
    lists:map(fun(C) -> element(R,C,M) end, lists:seq(1,9)).

column(C, M) ->
    lists:map(fun(R) -> element(R,C,M) end, lists:seq(1,9)).

validateBlock([]) ->
    true;
validateBlock([H|Rest]) ->
    case validateNumber(H) and not lists:member(H, Rest) of
        true ->
            validateBlock(Rest);
        false ->
            false
    end.

validateNumber(X) ->
    if (X > 0) and (X < 10) -> 
            true;
        true ->
            false
    end.

validate(M) ->
    lists:foldl(fun(X, Result) -> Result and validateBlock(square(X,M)) end, true, lists:seq(1,9))
    and 
    lists:foldl(fun(X, Result) -> Result and validateBlock(row(X,M)) end, true, lists:seq(1,9))
    and
    lists:foldl(fun(X, Result) -> Result and validateBlock(column(X,M)) end, true, lists:seq(1,9)).

replace(1, V, [_|T]) ->
    [V|T];
replace(N, V, [H|T]) ->
    [H|replace(N-1,V,T)].

replace(R, C, V, M) ->
    {Bn, Bin} = {toBlockIndex(R,C), toBlockInnerIndex(R,C)},
    %%io:format("Block index is ~w~n", [{Bn, Bin}]),
    replace(Bn, replace(Bin, V, square(Bn, M)), M).

