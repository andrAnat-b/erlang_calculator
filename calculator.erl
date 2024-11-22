-module(calculator).
-export([start/0, compute/2, get_history/1]).

start() ->
    {ok, ComputePid} = compute_server:start_link(),
    {ok, HistoryPid} = history_server:start_link(),
    {ComputePid, HistoryPid}.

compute({Op, A, B}, {ComputePid, HistoryPid}) ->
    case compute_server:calculate(ComputePid, Op, {A, B}) of
        {ok, Result} ->
            history_server:add_entry(HistoryPid, {Op, A, B}, Result),
            {{Op, A, B}, Result};
        {error, Reason} ->
            {error, Reason}
    end.

get_history({_, HistoryPid}) ->
    history_server:get_history(HistoryPid).
