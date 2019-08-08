# String.Interpolate
[![Build Status](https://travis-ci.org/lukewestby/elm-string-interpolate.svg)](https://travis-ci.org/lukewestby/elm-string-interpolate)

Inject values from a list into a template. Useful for i18n and templated copy.

## Documentation

`String.Interpolate` exports two functions `interpolate : String -> List String
-> String` and `interpolateWithDict : String -> Dict String String -> String`. The array based input string should use the format `"first arg: {0}, second
arg: {1}"` and so on. The dict based input string should use the format `"first arg: {first_arg}, second arg: {second arg}"`, spaces and alphanumeric characters
as well as underscores.

**Example:**
```elm
import String.Interpolate exposing(interpolate, interpolateWithDict)

output : String
output =
  interpolate "My name is {0} {1}" ["Luke", "Westby"] --"My name is Luke Westby"


dictOutput : String
dictOutput =
    let
        dict =
            Dict.empty
                |> Dict.insert "firstName" "Luke"
                |> Dict.insert "lastName" "Westby"
    in
        interpolateWithDict "My name is {firstName} {lastName}" dict --"My name is Luke Westby"
```

