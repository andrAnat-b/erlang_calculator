-module(compute_server).
-behaviour(gen_server).

-export([start_link/0]).
-export([handle_call/3]).
-export([init/1]).
-export([handle_cast/2]).


start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

init(_) ->
    {ok, []}.

handle_cast(_, State) ->
    {noreply, State}.

handle_call({calculate, plus, {A, B}}, _From, State) ->
    {reply, {ok, A + B}, State};
handle_call({calculate, mul, {A, B}}, _From, State) ->
    {reply, {ok, A * B}, State};
handle_call({calculate, sub, {A, B}}, _From, State) ->
    {reply, {ok, A - B}, State};
handle_call({calculate, divv, {A, B}}, _From, State) when B =/= 0 ->
    {reply, {ok, A div B}, State};
handle_call({calculate, divv, {_, 0}}, _From, State) ->
    {reply, {error, division_by_zero}, State};
handle_call(_, _From, State) ->
    {reply, {error, invalid_operation}, State}.
