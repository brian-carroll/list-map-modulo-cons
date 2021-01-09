module Main exposing (..)

import Benchmark exposing (Benchmark, describe)
import Benchmark.Runner exposing (BenchmarkProgram)
import Char
import List


main : BenchmarkProgram
main =
    Benchmark.Runner.program suite


coreMap : (a -> b) -> List a -> List b
coreMap f xs =
    List.map f xs


moduloConsMap : (a -> b) -> List a -> List b
moduloConsMap f xs =
    List.foldl (\x acc -> f x :: acc) [] xs


listOfSize : Int -> List Int
listOfSize n =
    List.range 1 n


scaleBenchmarkInt : String -> (List Int -> List Int) -> Benchmark
scaleBenchmarkInt name intMapper =
    List.range 0 3
        |> List.map ((^) 10)
        |> List.map (\size -> ( size, listOfSize size ))
        |> List.map (\( size, target ) -> ( String.fromInt size, \_ -> intMapper target ))
        |> Benchmark.scale name


compareBenchmark : Benchmark
compareBenchmark =
    Benchmark.compare "list with 2000 integers"
        "modulo-cons"
        (\_ -> moduloConsMap ((+) 5) (listOfSize 2000))
        "core"
        (\_ -> coreMap ((+) 5) (listOfSize 2000))


suite : Benchmark
suite =
    describe "map modulo-cons vs core"
        [ scaleBenchmarkInt "modulo-cons" (moduloConsMap ((+) 5))
        , scaleBenchmarkInt "core" (coreMap ((+) 5))
        ]
