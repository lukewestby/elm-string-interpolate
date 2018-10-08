module Tests exposing (suite)

import Dict
import Expect exposing (Expectation)
import String.Interpolate exposing (interpolate, interpolateWithDict)
import Test exposing (..)


suite : Test
suite =
    describe "Interpolation tests"
        [ test "list interpolation" <|
            \() ->
                [ "hello", "!!", "world" ]
                    |> interpolate "{0} {2} {1}"
                    |> Expect.equal "hello world !!"
        , test "dict interpolation" <|
            \() ->
                let
                    dict =
                        Dict.empty
                            |> Dict.insert "first" "hello"
                            |> Dict.insert "second" "world"
                            |> Dict.insert "exclamation" "!!"
                in
                interpolateWithDict "{first} {second} {exclamation}" dict
                    |> Expect.equal "hello world !!"
        , test "dict interpolation with spaces" <|
            \() ->
                let
                    dict =
                        Dict.empty
                            |> Dict.insert "first word" "hello"
                            |> Dict.insert "second word" "world"
                            |> Dict.insert "exclamation" "!!"
                in
                interpolateWithDict "{first word} {second word} {exclamation}" dict
                    |> Expect.equal "hello world !!"
        , test "test multiple instances of same named variable" <|
            \() ->
                let
                    dict =
                        Dict.singleton "beer" "Ninety nine"
                in
                interpolateWithDict
                    "{beer} bottles of beer on the wall. {beer} bottles of beer!"
                    dict
                    |> Expect.equal "Ninety nine bottles of beer on the wall. Ninety nine bottles of beer!"
        ]
