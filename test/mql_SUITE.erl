-module(mql_SUITE).

-behaviour(ct_suite).

-include_lib("common_test/include/ct.hrl").
-include_lib("stdlib/include/assert.hrl"). % Assertion macros for convenience

-export([all/0, groups/0, init_per_testcase/2, end_per_testcase/2]).
-export([parse_quit/1]).

-spec all() -> [ct_suite:ct_test_def(), ...].
all() ->
    [{group, parser_scanner}].

-spec groups() -> [ct_suite:ct_group_def(), ...].
groups() ->
    [{parser_scanner, [sequence], [parse_quit]}].

-spec init_per_testcase(ct_suite:ct_testname(), ct_suite:ct_config()) ->
                           ct_suite:ct_config() | {fail, term()} | {skip, term()}.
init_per_testcase(_Name, Config) ->
    Config.

-spec end_per_testcase(ct_suite:ct_testname(), ct_suite:ct_config()) ->
                          term() | {fail, term()} | {save_config, ct_suite:ct_config()}.
end_per_testcase(_Name, _Config) ->
    ok.

-spec parse_quit(ct_suite:ct_config()) -> ok | no_return().
parse_quit(_Config) ->
    {ok, Tokens1, _} = mql_scanner:string("q"),
    {ok, Tokens2, _} = mql_scanner:string("quit"),
    {ok, Tokens3, _} = mql_scanner:string("QUIT"),
    {ok, Tokens4, _} = mql_scanner:string("exit"),
    {ok, Tokens5, _} = mql_scanner:string("exit"),
    Quit = {ok, [{quit, quit}]},
    ?assertEqual(Quit, mql_parser:parse(Tokens1)),
    ?assertEqual(Quit, mql_parser:parse(Tokens2)),
    ?assertEqual(Quit, mql_parser:parse(Tokens3)),
    ?assertEqual(Quit, mql_parser:parse(Tokens4)),
    ?assertEqual(Quit, mql_parser:parse(Tokens5)).
