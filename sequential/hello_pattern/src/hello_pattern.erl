-module(hello_pattern).

-export([hello/1]).

hello({morning, _Person}) ->
    morning;
hello({night, _Person}) ->
    night;
hello({evening, Person}) ->
    {good, evening, Person};
hello({math_class, Number, _Subject}) when Number < 0 -> none;
hello({math_class, _Number, Subject}) ->
        {math_class, Subject};
hello({_Time, _Person}) ->
  ok.
