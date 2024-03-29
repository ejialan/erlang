-module(test).
-export([]).

-compile(export_all).

start() ->
    M = [[3,x,x,6,1,x,x,9,x],
        [x,x,7,x,x,5,x,3,2],
        [x,x,x,2,x,x,x,x,1],
        [x,x,x,x,x,x,8,x,4],
        [9,x,6,x,x,x,x,x,x],
        [x,x,x,x,x,x,1,x,x],
        [x,x,5,x,x,x,2,4,3],
        [4,x,x,x,x,x,x,x,8],
        [x,7,x,x,6,x,x,x,x]],
    numplace:deduce(M).

validateMatrix() -> 
    [[1,2,3,4,5,6,7,8,9],
     [4,5,6,7,8,9,1,2,3],
     [7,8,9,1,2,3,4,5,6],
     [2,3,4,5,6,7,8,9,1],
     [5,6,7,8,9,1,2,3,4],
     [8,9,1,2,3,4,5,6,7],
     [3,4,5,6,7,8,9,1,2],
     [6,7,8,9,1,2,3,4,5],
     [9,1,2,3,4,5,6,7,8]].
