-module(mql).

-export([shell/0]).

-ignore_xref([shell/0]).

-spec shell() -> no_return().
shell() ->
    io:fwrite("Welcome to the Mnesia Query Language shell.~n"),
    Config = undefined,
    shell(Config).

-spec shell(undefined) -> no_return().
shell(Config) ->
    Query = io:get_line("MQL> "),
    case mql_scanner:string(Query) of
        {ok, Tokens, _} ->
            case mql_parser:parse(Tokens) of
                {ok, [{quit, quit}]} ->
                    quit;
                Other ->
                    io:fwrite("Other ~p~n", [Other]),
                    shell(Config)
            end;
        Unhandle ->
            io:fwrite("Unhandle ~p~n", [Unhandle]),
            shell(Config)
    end.
