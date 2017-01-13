module Tests exposing (..)

import Test exposing (..)
import Expect
import Fuzz exposing (list, int, tuple, string)
import String
import String.Interpolate exposing (interpolate)

all : Test
all =
    describe "Sample Test Suite"
        [ describe "Unit test examples"
            [ test "Addition" <|
                \() ->
                  let interpolated = interpolate "{0} {2} {1}" ["hello", "!!", "world"]
                  in
                    Expect.equal interpolated "hello world !!"
            ]
        ]
