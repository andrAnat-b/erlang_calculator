-module(history_server).
-behaviour(gen_server).

-export([start_link/0]).

-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).


start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).



init(_) ->
    {ok, []}.

handle_call(get_history, _From, History) ->
    {reply, History, History};
handle_call(_, _From, State) ->
    {reply, error, State};

handle_call({add_entry, Operation, Result},_From, History) ->
    {reply, [{Operation, Result} | History], History}; %% завдання було обмежити історію 10ма записами
handle_call(_, _From,State) ->
    {noreply, State}.

handle_info(_, State) ->
    {noreply, State}.

terminate(_Reason, _State) ->
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.


handle_cast(_, History) ->
    {noreply, History}.