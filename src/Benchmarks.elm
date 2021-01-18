module Benchmarks exposing (..)

import Benchmark exposing (Benchmark, describe)
import Benchmark.Runner exposing (BenchmarkProgram)
import List
import ModuloCons


main : BenchmarkProgram
main =
    Benchmark.Runner.program suite


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
    in
    Benchmark.compare ("list of " ++ String.fromInt n ++ " integers")
        "map modulo-cons"
        (\_ -> ModuloCons.map f list)
        "map core"
        (\_ -> List.map f list)


map2Benchmark : Int -> Benchmark
map2Benchmark n =
    let
        list =
            listOfSize n

        f x y =
            x + y
    in
    Benchmark.compare ("list of " ++ String.fromInt n ++ " integers")
        "map2 modulo-cons"
        (\_ -> ModuloCons.map2 f list)
        "map2 core"
        (\_ -> List.map2 f list)


indexedMapBenchmark : Int -> Benchmark
indexedMapBenchmark n =
    let
        list =
            listOfSize n

        f =
            (+)
    in
    Benchmark.compare ("list of " ++ String.fromInt n ++ " integers")
        "indexedMap modulo-cons"
        (\_ -> ModuloCons.indexedMap f list)
        "indexedMap core"
        (\_ -> List.indexedMap f list)


filterBenchmark : Int -> Benchmark
filterBenchmark n =
    let
        list =
            listOfSize n

        f x =
            remainderBy 2 x == 0
    in
    Benchmark.compare ("list of " ++ String.fromInt n ++ " integers")
        "filter modulo-cons"
        (\_ -> ModuloCons.filter f list)
        "filter core"
        (\_ -> List.filter f list)


appendBenchmark : Int -> Benchmark
appendBenchmark n =
    let
        list =
            listOfSize n
    in
    Benchmark.compare ("list of " ++ String.fromInt n ++ " integers")
        "append modulo-cons"
        (\_ -> ModuloCons.append list list)
        "append core"
        (\_ -> List.append list list)


concatBenchmark : Int -> Benchmark
concatBenchmark n =
    let
        list1 =
            listOfSize n

        list2 =
            List.map ((+) n) list1
    in
    Benchmark.compare ("list of " ++ String.fromInt n ++ " integers")
        "concat modulo-cons"
        (\_ -> ModuloCons.concat [ list1, list2 ])
        "concat core"
        (\_ -> List.concat [ list1, list2 ])


intersperseBenchmark : Int -> Benchmark
intersperseBenchmark n =
    let
        list =
            listOfSize n

        sep =
            -1
    in
    Benchmark.compare ("list of " ++ String.fromInt n ++ " integers")
        "intersperse modulo-cons"
        (\_ -> ModuloCons.intersperse sep list)
        "intersperse core"
        (\_ -> List.intersperse sep list)


partitionBenchmark : Int -> Benchmark
partitionBenchmark n =
    let
        list =
            listOfSize n

        f x =
            remainderBy 2 x == 0
    in
    Benchmark.compare ("list of " ++ String.fromInt n ++ " integers")
        "partition modulo-cons"
        (\_ -> ModuloCons.partition f list)
        "partition core"
        (\_ -> List.partition f list)


unzipBenchmark : Int -> Benchmark
unzipBenchmark n =
    let
        list =
            listOfSize n
                |> List.map (\x -> ( x, n + x ))
    in
    Benchmark.compare ("list of " ++ String.fromInt n ++ " integers")
        "unzip modulo-cons"
        (\_ -> ModuloCons.unzip list)
        "unzip core"
        (\_ -> List.unzip list)


suite : Benchmark
suite =
    let
        n =
            1000
    in
    describe "modulo-cons vs core"
        [ mapBenchmark n
        , map2Benchmark n
        , indexedMapBenchmark n
        , filterBenchmark n
        , appendBenchmark n
        , concatBenchmark n
        , intersperseBenchmark n
        , partitionBenchmark n
        , unzipBenchmark n
        ]
