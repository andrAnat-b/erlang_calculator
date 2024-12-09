-module(calculator).
-behaviour(application).
-export([start/2, compute/1, get_history/0, stop/1]).

start(_,_) ->
    compute_server:start_link(),
    history_server:start_link().
    
compute({Op, A, B}) -> %% варто було би зробити щоби компут сервер сам звертався до серверу історії при обчисленнях - тоді це спростить архітектуру
    case gen_server:call(compute_server, {calculate,Op, {A, B}}) of
        {ok, Result} ->
            gen_server:cast(history_server, {add_entry, {Op, A, B}, Result}),
            {{Op, A, B}, Result};
        {error, Reason} ->
            {error, Reason}
    end.

get_history() ->
    gen_server:call(history_server, get_history).

stop(_) ->
    compute_server:stop(),
    history_server:stop().
