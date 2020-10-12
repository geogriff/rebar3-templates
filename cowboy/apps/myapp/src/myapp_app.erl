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

start() ->
    application:ensure_all_started(?APP).

stop() ->
    application:stop(?APP).

restart() ->
    stop(),
    start().

application() ->
    ?APP.

listen_ip() ->
    application:get_env(?APP, listen_ip).

listen_port() ->
    application:get_env(?APP, port, 8080).

webroot() ->
    application:get_env(?APP, webroot).

%%
%% application callbacks
%%

start(_StartType, _StartArgs) ->
    {{name}}_server:start(),
    {{name}}_sup:start_link().

stop(_State) ->
    ok.
