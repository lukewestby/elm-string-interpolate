module String.Interpolate exposing
    ( interpolate
    , interpolateWithDict
    )

{-| String.Interpolate provides a couple of convenient methods `interpolate`
and `interpolateWithDict` for injecting values into a string. This can be
useful for i18n of apps and construction of complex strings in views.

@docs interpolate
@docs interpolateWithDict

-}

import Array exposing (Array, fromList, get)
import Dict exposing (Dict)
import Maybe exposing (andThen, withDefault)
import Regex exposing (Match, Regex, fromString, never, replace)
import String exposing (dropLeft, dropRight, toInt)


{-| Inject other strings into a string in the order they appear in a List.

    interpolate "{0} {2} {1}" [ "hello", "!!", "world" ] == "hello world !!"

-}
interpolate : String -> List String -> String
interpolate string args =
    let
        asArray =
            fromList args
    in
    replace interpolationRegex (applyInterpolation asArray) string


{-| Inject other strings into a string based on their name within a Dict.
Only parses strings with spaces, dashes, and / or alphanumeric characters.

    englishDict =
        Dict.fromList
            [ ("greeting", "Hello")
            , ("world", "world")
            , ("exclamation", "!!")
            ]

    drNickDict =
        Dict.fromList
            [ ("greeting", "Hello")
            , ("world", "everybody")
            , ("exclamation", "!!")
            ]

    spanishDict =
        Dict.fromList
            [ ("greeting", "Hola")
            , ("world", "todos")
            , ("exclamation", "!!")
            ]

    interpolateWithDict "{greeting} {world} {exclamation}" drNickDict

-}
interpolateWithDict : String -> Dict String String -> String
interpolateWithDict string dict =
    replace dictInterpolationRegex (applyDictInterpolation dict) string


interpolationRegex : Regex
interpolationRegex =
    fromString "\\{\\d+\\}" |> withDefault Regex.never


applyInterpolation : Array String -> Match -> String
applyInterpolation replacements { match } =
    let
        ordinalString =
            (dropLeft 1 << dropRight 1) match
    in
    ordinalString
        |> toInt
        |> andThen (\value -> get value replacements)
        |> withDefault ""


dictInterpolationRegex : Regex
dictInterpolationRegex =
    fromString "\\{[\\w+\\s]*\\}" |> withDefault never


applyDictInterpolation : Dict String String -> Match -> String
applyDictInterpolation replacements { match } =
    let
        ordinalString =
            (dropLeft 1 << dropRight 1) match
    in
    Dict.get ordinalString replacements
        |> withDefault ""
