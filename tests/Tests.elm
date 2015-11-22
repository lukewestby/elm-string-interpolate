import Task
import Console
import ElmTest exposing (test, Test, suite, assertEqual, stringRunner, consoleRunner)
import String.Interpolate exposing (interpolate)

tests : Test
tests =
  suite "String.Interpolate.interpolate"
    [ test "Ordered interpolation" (assertEqual (interpolate "{0} {2} {1}" ["hello", "!!", "world"]) "hello world !!")
    ]

port runner : Signal (Task.Task x ())
port runner =
    Console.run (consoleRunner tests)
