# String.Interpolate
[![Build Status](https://travis-ci.org/lukewestby/elm-string-interpolate.svg)](https://travis-ci.org/lukewestby/elm-string-interpolate)

Inject values from a list into a template. Useful for i18n and templated copy.

## Documentation

`String.Interpolate` exports one function `interpolate : String -> List String
-> String`. The input string should use the format `"first arg: {0}, second
arg: {1}"` and so on.

**Example:**
```elm
import String.Interpolate exposing(interpolate)

output : String
output =
  interpolate "My name is {0} {1}" ["Luke", "Westby"]

main = show output {- "My name is Luke Westby" -}
```
