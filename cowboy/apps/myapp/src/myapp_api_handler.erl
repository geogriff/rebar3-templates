-module({{name}}_api_handler).
-behaviour(cowboy_handler).

%% cowboy_handler callbacks
-export([init/2]).

%%
%% cowboy_handler callbacks
%%

-spec init(Request, State) -> {ok | Handler, Request, State} when
      Request :: cowboy_req:req(),
      Handler :: module(),
      State   :: any().
init(Request, {}) ->
    {ok, handle_request(Request), nostate}.

%%
%% private functions
%%

handle_request(Request) ->
    cowboy_req:reply(404, Request).
