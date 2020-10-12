-module({{name}}_server).

-include_lib("kernel/include/logger.hrl").

%% public API
-export([start/0, stop/0]).

%%
%% public API
%%

-spec start() -> {ok, pid()} | {error, any()}.
start() ->
    ?LOG_INFO(?MODULE_STRING " starting on ~p", [node()]),

    ListenIpOpts = case {{name}}_app:listen_ip() of
                       undefined      -> [];
                       {ok, ListenIp} -> [{listen_ip, ListenIp}]
                   end,
    Port = {{name}}_app:listen_port(),
    SocketOpts = ListenIpOpts ++
        [{port, Port}],
    TransportOpts = #{connection_type => supervisor,
                      socket_opts => SocketOpts},

    ApiRoute = {"/api/v1/[...]", {{name}}_api_handler, {}},
    WebrootRoutes = case {{name}}_app:webroot() of
                        undefined     -> [{"/[index.html]", cowboy_static, {priv_file, {{name}}_app:application(), "default_index.html"}}];
                        {ok, Webroot} -> [{"/", cowboy_static, {file, filename:join(Webroot, "index.html")}},
                                          {"/[...]", cowboy_static, {dir, Webroot}}]
                   end,
    Routes = [ApiRoute] ++ WebrootRoutes,
    Dispatch = cowboy_router:compile([{'_', Routes}]),

    ProtocolOpts = #{env => #{dispatch => Dispatch},
                     idle_timeout => infinity,
                     inactivity_timeout => infinity},

    cowboy:start_clear(?MODULE, TransportOpts, ProtocolOpts).

-spec stop() -> ok | {error, any()}.
stop() ->
    ?LOG_INFO(?MODULE_STRING " stopping on ~p", [node()]),
    ranch:stop_listener(?MODULE).
