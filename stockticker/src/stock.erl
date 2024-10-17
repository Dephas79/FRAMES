-module(stock).
-export([lookup/1]).
-include_lib("nitrogen_core/include/wf.hrl").

-define(VA_API_KEY, "YY4UHATVVYAOTR12").

lookup(Symbol) ->
    BaseURL = "https://www.alphavantage.co/query?",
    QS = wf:to_qs([
        {function, "GLOBAL_QUOTE"},
        {apikey, ?VA_API_KEY},
        {symbol, Symbol}
]),
URL = BaseURL ++ QS,
{ok, {_, _, Body}} = httpc:request(URL),
%%----------------------------------------------------------------------------------------
%% Decoding the JSON and extract the price
Quote = wf:json_decode(Body),
GlobalQuote = proplists:get_value(<<"Global Quote">>, Quote),
proplists:get_value(<<"05. price">>, GlobalQuote).

