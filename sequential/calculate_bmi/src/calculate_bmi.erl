-module(calculate_bmi).

-export([bmi/1, classify/1]).

-include("../src/person_record.hrl").

bmi(#person{weight=W, height=H}) ->
    W / ( H * H).



classify(_, Bmi) when Bmi < 18.5 ->
    underweight;
classify(_, Bmi) when (Bmi > 18.5) and (Bmi < 25) ->
    normal;
classify(_, Bmi) when (Bmi > 25) and (Bmi < 30) ->
    overweight;
classify(_, Bmi) when Bmi > 30 ->
    obese.

classify(Person) ->
  classify(Person, bmi(Person)).
