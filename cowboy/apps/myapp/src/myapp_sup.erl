-module({{name}}_sup).
-behaviour(supervisor).

%% API
-export([start_link/0]).

%% supervisor callbacks
-export([init/1]).

-define(SERVER, ?MODULE).

%%
%% API
%%

-spec start_link() -> {ok, pid()} | ignore | {error, any()}.
start_link() ->
    supervisor:start_link({local, ?SERVER}, ?MODULE, []).

%%
%% supervisor callbacks
%%

-spec init(Args :: any()) -> {ok, {supervisor:sup_flags(), [supervisor:child_spec()]}} | ignore.
init([]) ->
    Mods = [],
    ChildSpecs = [Mod:child_spec() || Mod <- Mods],
    SupervisorFlags =
        #{strategy => one_for_all,
          intensity => 5,
          period => 1},
    {ok, {SupervisorFlags, ChildSpecs}}.
