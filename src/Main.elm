module Main exposing (..)

import Benchmark exposing (Benchmark, describe)
import Benchmark.Runner exposing (BenchmarkProgram)
import List


main : BenchmarkProgram
main =
    Benchmark.Runner.program suite


moduloConsMap : (a -> b) -> List a -> List b
moduloConsMap f xs =
    -- Just a dummy Elm placeholder!
    -- After compiling, copy compiled.html to modified.html and edit it.
    -- Find the JS definition for `var $author$project$Main$moduloConsMap`
    -- and replace it with the code in modulo-cons-map.js
    -- Save modified.html and open it in a browser
    List.map f xs


moduloConsMap2 =
    -- Just a dummy Elm placeholder!
    List.map2


moduloConsIndexedMap =
    -- Just a dummy Elm placeholder!
    List.indexedMap


moduloConsFilter =
    -- Just a dummy Elm placeholder!
    List.filter


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
            Debug.log "map is correct" (moduloConsMap f list == List.map f list)
    in
    Benchmark.compare ("list of " ++ String.fromInt n ++ " integers")
        "map modulo-cons"
        (\_ -> moduloConsMap f list)
        "map core"
        (\_ -> List.map f list)


map2Benchmark : Int -> Benchmark
map2Benchmark n =
    let
        list =
            listOfSize n

        f x y =
            x + y

        _ =
            Debug.log "map2 is correct"
                (moduloConsMap2 f list list == List.map2 f list list)
    in
    Benchmark.compare ("list of " ++ String.fromInt n ++ " integers")
        "map2 modulo-cons"
        (\_ -> moduloConsMap2 f list)
        "map2 core"
        (\_ -> List.map2 f list)


indexedMapBenchmark : Int -> Benchmark
indexedMapBenchmark n =
    let
        list =
            listOfSize n

        f =
            (+)

        _ =
            Debug.log "indexedMap is correct"
                (moduloConsIndexedMap f list == List.indexedMap f list)
    in
    Benchmark.compare ("list of " ++ String.fromInt n ++ " integers")
        "indexedMap modulo-cons"
        (\_ -> moduloConsIndexedMap f list)
        "indexedMap core"
        (\_ -> List.indexedMap f list)


filterBenchmark : Int -> Benchmark
filterBenchmark n =
    let
        list =
            listOfSize n

        f x =
            remainderBy 2 x == 0

        _ =
            Debug.log "filter is correct" (moduloConsFilter f list == List.filter f list)
    in
    Benchmark.compare ("list of " ++ String.fromInt n ++ " integers")
        "filter modulo-cons"
        (\_ -> moduloConsFilter f list)
        "filter core"
        (\_ -> List.filter f list)


suite : Benchmark
suite =
    let
        n =
            1000
    in
    describe "modulo-cons vs core"
        [ map2Benchmark n ]



-- [ mapBenchmark n
-- , map2Benchmark n
-- , indexedMapBenchmark n
-- , filterBenchmark n
-- ]
