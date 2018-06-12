-module(bank_account).

-export([process_operation/2]).

account(List, Nr) ->
    Rs = lists:filter(fun({N, _}) -> N == Nr end, List),
    case Rs of
        [] -> {error, account_not_found};
        [Account] -> Account
    end.

process(withdraw, {Nr, Total}, Amount) ->
    case Amount > Total of
        true -> {error, insufficient_funds};
        false -> {Nr, Total - Amount}
    end;
process(deposit, {Nr, Total}, Amount) ->
        {Nr, Total + Amount}.

process_operation(Bank, {Nr, Op, Amount}) ->
    Account = account(Bank, Nr),
    case Account  of
        {error, account_not_found} -> Account;
        _-> process(Op, Account, Amount)
    end.
