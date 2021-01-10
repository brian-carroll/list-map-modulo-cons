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


coreFilter : (a -> Bool) -> List a -> List a
coreFilter f xs =
    List.filter f xs


moduloConsFilter : (a -> Bool) -> List a -> List a
moduloConsFilter f xs =
    -- Just a dummy Elm placeholder!
    -- After compiling, copy compiled.html to modified.html and edit it.
    -- Find the JS definition for `var $author$project$Main$moduloConsMap`
    -- and replace it with the code in modulo-cons-map.js
    -- Save modified.html and open it in a browser
    List.filter f xs


listOfSize : Int -> List Int
listOfSize n =
    List.range 1 n


mapBenchmark : Int -> Benchmark
mapBenchmark n =
    let
        list =
            listOfSize n

        f =
            (+) 5

        _ =
            Debug.log "map is correct" (moduloConsMap f list == coreMap f list)
    in
    Benchmark.compare ("list of " ++ String.fromInt n ++ " integers")
        "map modulo-cons"
        (\_ -> moduloConsMap f list)
        "map core"
        (\_ -> coreMap f list)


mapScale : List Benchmark
mapScale =
    List.range 1 4
        |> List.map ((^) 10)
        |> List.map mapBenchmark


filterBenchmark : Int -> Benchmark
filterBenchmark n =
    let
        list =
            listOfSize n

        f x =
            remainderBy 2 x == 0

        _ =
            Debug.log "filter is correct" (moduloConsFilter f list == coreFilter f list)
    in
    Benchmark.compare ("list of " ++ String.fromInt n ++ " integers")
        "filter modulo-cons"
        (\_ -> moduloConsFilter f list)
        "filter core"
        (\_ -> coreFilter f list)


filterScale : List Benchmark
filterScale =
    List.range 1 4
        |> List.map ((^) 10)
        |> List.map filterBenchmark


suite : Benchmark
suite =
    describe "modulo-cons vs core"
        [ filterBenchmark 1000 ]
