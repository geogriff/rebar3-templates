-module({{name}}_app).
-behaviour(application).

%% API
-export([start/0, stop/0, restart/0, application/0]).
-export([listen_ip/0, listen_port/0, webroot/0]).

%% application callbacks
-export([start/2, stop/1]).

-define(APP, {{name}}).

%%
%% API
%%

-spec start() -> {ok, Started :: [App :: atom()]} | {error, any()}.
start() ->
    application:ensure_all_started(?APP).

-spec stop() -> ok | {error, any()}.
stop() ->
    application:stop(?APP).

-spec restart() -> {ok, Started :: [App :: atom()]} | {error, any()}.
restart() ->
    stop(),
    start().

-spec application() -> atom().
application() ->
    ?APP.

-spec listen_ip() -> {ok, any()} | undefined.
listen_ip() ->
    application:get_env(?APP, listen_ip).

-spec listen_port() -> {ok, any()} | undefined.
listen_port() ->
    application:get_env(?APP, port, 8080).

-spec webroot() -> {ok, any()} | undefined.
webroot() ->
    application:get_env(?APP, webroot).

%%
%% application callbacks
%%

-spec start(StartType, StartArgs :: any()) -> {ok, pid()} | {ok, pid(), State :: any()} | {error, any()} when
      StartType :: application:start_type().
start(_StartType, _StartArgs) ->
    {{name}}_server:start(),
    {{name}}_sup:start_link().

-spec stop(State :: any()) -> any().
stop(_State) ->
    ok.
