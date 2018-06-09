-module(filter_fibonacci_numbers).

-export([filter/1]).

is_perfect_square(X) ->
 S = round(math:sqrt(X)),
 S * S == X.


is_fib(X) ->
    Y = 5 * ( X * X),
    is_perfect_square(Y + 4) or is_perfect_square(Y - 4).

filter(List) ->
    [X || X <- List, is_fib(X) == true].
