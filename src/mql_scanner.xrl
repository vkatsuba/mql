%% =============================================================================
%% Definitions
%% =============================================================================

Definitions.

WHITESPACE = ([\000-\s]|%.*)

%% =============================================================================
%% Rules
%% =============================================================================

Rules.

%% -----------------------------------------------------------------------------
%% Quit shell
%% -----------------------------------------------------------------------------

(q|quit|QUIT|exit|EXIT) : {token, ?QUIT_CLAUSE(TokenChars)}.

%% -----------------------------------------------------------------------------
%% Skip token with white space
%% -----------------------------------------------------------------------------

{WHITESPACE} : skip_token.

%% =============================================================================
%% Erlang Code
%% =============================================================================

Erlang code.

-include("mql.hrl").
