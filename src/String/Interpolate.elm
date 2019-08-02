module String.Interpolate exposing (interpolate)

{-| String.Interpolate provides a convenient method `interpolate` for injecting
values into a string. This can be useful for i18n of apps and construction of
complex strings in views.

@docs interpolate

-}

import Array exposing (Array, fromList, get)
import Maybe exposing (andThen, withDefault)
import Regex exposing (Match, Regex, fromString, never, replace)
import String exposing (dropLeft, dropRight, toInt)


{-| Inject other strings into a string. Elements in a list can be referenced
by index to be inserted into the base string:

```elm
interpolate "{0} {2} {1}" ["hello", "!!", "world"]
-- "hello world !!"
```

Occassionally it is nicer to use the function infix:

```elm
"{0} {2} {1}" `interpolate` ["hello", "!!", "world"]
-- "hello world !!"
```

In cases where the supplied list is too short, an empty string is interpolated
instead:

```elm
interpolate "{0} {2} {1}" ["hello", "world"]
-- "hello  world"
```

In cases where the supplied list is *longer* than necessary, unused elements are
simply ignored.
-}
interpolate : String -> List String -> String
interpolate string args =
    let
        asArray =
            fromList args
    in
    replace interpolationRegex (applyInterpolation asArray) string


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
