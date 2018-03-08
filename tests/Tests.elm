module Tests exposing (..)

import Expect exposing (Expectation)
import String.Interpolate exposing (interpolate)
import Test exposing (..)


suite : Test
suite =
    test "interpolation" <|
        \() ->
            [ "hello", "!!", "world" ]
                |> interpolate "{0} {2} {1}"
                |> Expect.equal "hello world !!"
