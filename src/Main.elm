module Main exposing (..)

import Benchmark exposing (Benchmark, describe)
import Benchmark.Runner exposing (BenchmarkProgram)
import List
import Tuple


main : BenchmarkProgram
main =
    Benchmark.Runner.program suite


map : (a -> b) -> List a -> List b
map f xs =
    List.map f xs


map2 =
    List.map2


indexedMap =
    List.indexedMap


filter =
    List.filter


append =
    List.append


concat =
    List.concat


intersperse =
    List.intersperse


partition =
    List.partition


unzip =
    List.unzip


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
            Debug.log "map is correct" (map f list == List.map f list)
    in
    Benchmark.compare ("list of " ++ String.fromInt n ++ " integers")
        "map modulo-cons"
        (\_ -> map f list)
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
                (map2 f list list == List.map2 f list list)
    in
    Benchmark.compare ("list of " ++ String.fromInt n ++ " integers")
        "map2 modulo-cons"
        (\_ -> map2 f list)
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
                (indexedMap f list == List.indexedMap f list)
    in
    Benchmark.compare ("list of " ++ String.fromInt n ++ " integers")
        "indexedMap modulo-cons"
        (\_ -> indexedMap f list)
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
            Debug.log "filter is correct" (filter f list == List.filter f list)
    in
    Benchmark.compare ("list of " ++ String.fromInt n ++ " integers")
        "filter modulo-cons"
        (\_ -> filter f list)
        "filter core"
        (\_ -> List.filter f list)


appendBenchmark : Int -> Benchmark
appendBenchmark n =
    let
        list =
            listOfSize n

        _ =
            Debug.log "append is correct"
                (append list list == List.append list list)
    in
    Benchmark.compare ("list of " ++ String.fromInt n ++ " integers")
        "append modulo-cons"
        (\_ -> append list list)
        "append core"
        (\_ -> List.append list list)


concatBenchmark : Int -> Benchmark
concatBenchmark n =
    let
        list1 =
            listOfSize n

        list2 =
            List.map ((+) n) list1

        _ =
            Debug.log "concat is correct"
                (concat [ list1, list2 ] == List.concat [ list1, list2 ])
    in
    Benchmark.compare ("list of " ++ String.fromInt n ++ " integers")
        "concat modulo-cons"
        (\_ -> concat [ list1, list2 ])
        "concat core"
        (\_ -> List.concat [ list1, list2 ])


intersperseBenchmark : Int -> Benchmark
intersperseBenchmark n =
    let
        list =
            listOfSize n

        sep =
            -1

        _ =
            Debug.log "intersperse is correct"
                (intersperse sep list == List.intersperse sep list)
    in
    Benchmark.compare ("list of " ++ String.fromInt n ++ " integers")
        "intersperse modulo-cons"
        (\_ -> intersperse sep list)
        "intersperse core"
        (\_ -> List.intersperse sep list)


partitionBenchmark : Int -> Benchmark
partitionBenchmark n =
    let
        list =
            listOfSize n

        f x =
            remainderBy 2 x == 0

        _ =
            Debug.log "partition is correct"
                (partition f list == List.partition f list)
    in
    Benchmark.compare ("list of " ++ String.fromInt n ++ " integers")
        "partition modulo-cons"
        (\_ -> partition f list)
        "partition core"
        (\_ -> List.partition f list)


unzipBenchmark : Int -> Benchmark
unzipBenchmark n =
    let
        list =
            listOfSize n
                |> List.map (\x -> ( x, n + x ))

        _ =
            Debug.log "unzip is correct"
                (unzip list == List.unzip list)
    in
    Benchmark.compare ("list of " ++ String.fromInt n ++ " integers")
        "unzip modulo-cons"
        (\_ -> unzip list)
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
