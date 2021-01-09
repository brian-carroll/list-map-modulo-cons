module Main exposing (..)

import Benchmark exposing (..)
import Benchmark.Runner exposing (BenchmarkProgram)
import Char


main : BenchmarkProgram
main =
    Benchmark.Runner.program suite


coreMap : (a -> b) -> List a -> List b
coreMap f xs =
    List.map f xs


moduloConsMap : (a -> b) -> List a -> List b
moduloConsMap f xs =
    List.foldl (\x acc -> f x :: acc) [] xs


ints : List Int
ints =
    List.range 1 2000


strings : List String
strings =
    List.range 1 5
        |> List.map (Char.fromCode >> String.fromChar)


suite : Benchmark
suite =
    describe "map with moduloCons vs core"
        [ Benchmark.compare "list with 2000 integers"
            "moduloCons"
            (\_ -> moduloConsMap ((+) 5) ints)
            "core"
            (\_ -> coreMap ((+) 5) ints)
        , Benchmark.compare "list with 5 strings"
            "moduloCons"
            (\_ -> moduloConsMap String.reverse strings)
            "core"
            (\_ -> coreMap String.reverse strings)
        ]


type alias DurationStats =
    { average : Float
    , durations : Int
    }


addDuration : Int -> DurationStats -> DurationStats
addDuration duration stats =
    { average =
        ((stats.average * toFloat stats.durations) + toFloat duration)
            / (toFloat stats.durations + 1)
    , durations = stats.durations + 1
    }
