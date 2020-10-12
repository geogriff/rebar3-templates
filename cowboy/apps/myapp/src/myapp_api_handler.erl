-module({{name}}_api_handler).

%% cowboy handler callbacks
-export([init/2]).

%%
%% cowboy handler callbacks
%%

init(Request, {}) ->
    {ok, cowboy_req:reply(404, [], <<>>, Request), nostate}.

%%
%% private functions
%%
