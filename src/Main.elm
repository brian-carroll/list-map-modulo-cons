module Main exposing (..)

import Benchmark exposing (Benchmark, describe)
import Benchmark.Runner exposing (BenchmarkProgram)
import List


main : BenchmarkProgram
main =
    Benchmark.Runner.program suite


coreMap : (a -> b) -> List a -> List b
coreMap f xs =
    List.map f xs


moduloConsMap : (a -> b) -> List a -> List b
moduloConsMap f xs =
    -- Just a dummy Elm placeholder!
    -- After compiling, copy compiled.html to modified.html and edit it.
    -- Find the JS definition for `var $author$project$Main$moduloConsMap`
    -- and replace it with the code in modulo-cons-map.js
    -- Save modified.html and open it in a browser
    List.map f xs


listOfSize : Int -> List Int
listOfSize n =
    List.range 1 n


compareBenchmark : Int -> Benchmark
compareBenchmark n =
    let
        list =
            listOfSize n
    in
    Benchmark.compare ("list of " ++ String.fromInt n ++ " integers")
        "modulo-cons"
        (\_ -> moduloConsMap ((+) 5) list)
        "core"
        (\_ -> coreMap ((+) 5) list)


compareScale : List Benchmark
compareScale =
    List.range 1 4
        |> List.map ((^) 10)
        |> List.map compareBenchmark


suite : Benchmark
suite =
    describe "map modulo-cons vs core"
        compareScale
