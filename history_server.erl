-module(history_server).
-behaviour(gen_server).

-export([start_link/0, add_entry/3, get_history/1]).

-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).


start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

add_entry(Pid, Op, Result) ->
    gen_server:cast(Pid, {add_entry, Op, Result}).

get_history(Pid) ->
    gen_server:call(Pid, get_history).


init(_) ->
    {ok, []}.

handle_call(get_history, _From, History) ->
    {reply, History, History};
handle_call(_, _From, State) ->
    {reply, error, State}.

handle_cast({add_entry, Operation, Result}, History) ->
    {noreply, [{Operation, Result} | History]};
handle_cast(_, State) ->
    {noreply, State}.

handle_info(_, State) ->
    {noreply, State}.

terminate(_Reason, _State) ->
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.
