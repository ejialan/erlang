-module(numplace).
-export([deduce/1]).

-compile(export_all).


deduce(M) ->
    deduce(M, self()),
    receive 
        {ok, Done} ->
            io:format("Finish to deduce ~p to ~p~n", [M, Done]);
        nok ->
            io:format("Failed to deduce ~p~n", [M])
    end.


deduce(M, Master) ->
    D = spawn(fun() -> deduce() end),
    D ! {deduce, Master, M}.


deduce() ->
    receive 
        {deduce, Master, M} ->
            fulfill(M, Master)
    end.


fulfill(M, Master) ->
    Candidates = lists:keysort(1, allCandidates(M)),
    if 
        length(Candidates) > 0 ->
            [{N, R, C, Can}|_] = Candidates,
            if 
                N > 0 ->
                    lists:foreach(fun(X) -> deduce(matrix:replace(R,C,X,M),Master) end, Can)
            end;
        true ->
            Master ! {ok, M}
    end.



allCandidates(M) ->
    allCandidates(1, 1, M, []).

allCandidates(R, 10, M, Result) ->
    allCandidates(R+1, 1, M, Result);
allCandidates(10, _, _, Result) ->
    Result;
allCandidates(R, C, M, Result) ->
    X = matrix:element(R, C, M),
    case X of
        x ->
            AllHad = matrix:row(R,M) ++ matrix:column(C,M) ++ matrix:square(R,C,M),
            Candidates = candidates(AllHad),
            allCandidates(R, C+1, M, [{length(Candidates), R, C, Candidates}|Result]);
        _ ->
            allCandidates(R, C+1, M, Result)
    end.

candidates(B) ->
    lists:filter(fun(X) -> not lists:member(X,B) end, lists:seq(1,9)).

