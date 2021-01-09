module Main exposing (..)

import Benchmark exposing (..)
import Benchmark.Runner exposing (BenchmarkProgram)
import Char


main : BenchmarkProgram
main =
    Benchmark.Runner.program suite


foldrMap : (a -> b) -> List a -> List b
foldrMap f xs =
    List.foldr (\x acc -> f x :: acc) [] xs


foldlMap : (a -> b) -> List a -> List b
foldlMap f xs =
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
    describe "map with foldl vs foldr"
        [ Benchmark.compare "list with 2000 integers"
            "foldl"
            (\_ -> foldlMap ((+) 5) ints)
            "foldr"
            (\_ -> foldrMap ((+) 5) ints)
        , Benchmark.compare "list with 5 strings"
            "foldl"
            (\_ -> foldlMap String.reverse strings)
            "foldr"
            (\_ -> foldrMap String.reverse strings)
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
