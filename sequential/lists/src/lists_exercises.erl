-module(lists_exercises).

-export([reverse/1,
         rmconsecutive/1,
         even_fib_numbers/0,
         foldl/3,
         foldl/2,
         rotate/2,
         run_length_encode/1,
         list_any/2]).

reverse(List) ->
    foldl(fun(Acc, L) -> [L | Acc] end, [], List).

rmconsecutive(List) ->
    {_, Res} = foldl(
                 fun({Prev, Acc}, L) ->
                         case Prev == L of
                             true -> {L, Acc};
                             false -> {L, [L | Acc]}
                         end
                 end, {none, []}, List),
    reverse(Res).


fib_list([H| T], N )when N < 4000000 ->
    fib_list([N | [H | T]], H + N);
fib_list(List, N)  ->
    [N | List].
fib_list()->
    fib_list([1], 2).

even_fib_numbers() ->
    foldl(fun(Acc, N) ->
                  case N rem 2 == 0 of
                      true -> Acc + N;
                      false -> Acc
                  end
          end, 0, fib_list()).

foldl(Fun, Acc, [H | T]) ->
    foldl(Fun, Fun(Acc, H), T);
foldl(_Fun, Acc, []) -> Acc.

foldl(Fun, [H | T]) ->
    foldl(Fun, H, T);
foldl(_Fun, []) -> [].

rotate(List, {left, N}) ->
    {Left, Right} = lists:split(N, List),
    lists:append(Right, Left);
rotate(List, {right, N}) ->
    {Left, Right} = lists:split(length(List) - N, List),
    lists:append(Right, Left).

run_length_encode(List) ->
    {Prev, Count, Acc} = foldl(fun({Prev, Count, Acc}, L) ->
                                       case Prev == L of
                                           true -> {L, Count + 1, Acc};
                                           false ->
                                               case Prev of
                                                   none -> {L, 1, Acc};
                                                   _ -> {L, 1, [[Count, Prev] | Acc]}
                                               end
                                       end
                               end, {none, 0, []}, List),
    reverse([[Count, Prev] | Acc]).

list_any(Pred, List) ->
    foldl(fun(Res, L) -> Res or Pred(L) end, false, List ).
