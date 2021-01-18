module HtmlTests exposing (..)

import Benchmarks
import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer)
import Html exposing (Html, div, h1, text)
import Random
import Test exposing (Test, describe, fuzz, test)
import Test.Runner.Html exposing (defaultConfig, hidePassedTests, showPassedTests, viewResults, withFuzzCount)


int : Fuzzer Int
int =
    Fuzz.intRange 0 10


listInt : Fuzzer (List Int)
listInt =
    Fuzz.list int


pairOfLists : Fuzzer ( List Int, List Int )
pairOfLists =
    Fuzz.tuple ( listInt, listInt )


listOfPairs : Fuzzer (List ( Int, Int ))
listOfPairs =
    Fuzz.list (Fuzz.tuple ( int, int ))


listListInt : Fuzzer (List (List Int))
listListInt =
    Fuzz.list listInt


filterFn : Int -> Bool
filterFn x =
    remainderBy 2 x == 0


suite : Test
suite =
    describe "Modulo cons"
        [ fuzz listInt "map" <|
            \list ->
                Expect.equal
                    (Benchmarks.map ((+) 5) list)
                    (List.map ((+) 5) list)
        , fuzz pairOfLists "map2" <|
            \( list1, list2 ) ->
                Expect.equal
                    (Benchmarks.map2 (+) list1 list2)
                    (List.map2 (+) list1 list2)
        , fuzz listInt "indexedMap" <|
            \list ->
                Expect.equal
                    (Benchmarks.indexedMap (+) list)
                    (List.indexedMap (+) list)
        , fuzz listInt "filter" <|
            \list ->
                Expect.equal
                    (Benchmarks.filter filterFn list)
                    (List.filter filterFn list)
        , fuzz pairOfLists "append" <|
            \( list1, list2 ) ->
                Expect.equal
                    (Benchmarks.append list1 list2)
                    (List.append list1 list2)
        , fuzz listListInt "concat" <|
            \lists ->
                Expect.equal
                    (Benchmarks.concat lists)
                    (List.concat lists)
        , fuzz listInt "intersperse" <|
            \list ->
                Expect.equal
                    (Benchmarks.intersperse -1 list)
                    (List.intersperse -1 list)
        , fuzz listInt "partition" <|
            \list ->
                Expect.equal
                    (Benchmarks.partition filterFn list)
                    (List.partition filterFn list)
        , fuzz listOfPairs "unzip" <|
            \list ->
                Expect.equal
                    (Benchmarks.unzip list)
                    (List.unzip list)
        ]


config =
    Random.initialSeed 10000
        |> defaultConfig
        |> withFuzzCount 1000
        |> showPassedTests


main : Html msg
main =
    div []
        [ h1 [] [ text "My Test Suite" ]
        , div [] [ viewResults config suite ]
        ]
