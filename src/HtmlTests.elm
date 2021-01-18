module HtmlTests exposing (..)

import Expect
import Fuzz exposing (Fuzzer)
import Html exposing (Html, div, h1, text)
import ModuloCons
import Random
import Test exposing (Test, describe, fuzz)
import Test.Runner.Html exposing (defaultConfig, showPassedTests, viewResults, withFuzzCount)


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
                    (ModuloCons.map ((+) 5) list)
                    (List.map ((+) 5) list)
        , fuzz pairOfLists "map2" <|
            \( list1, list2 ) ->
                Expect.equal
                    (ModuloCons.map2 (+) list1 list2)
                    (List.map2 (+) list1 list2)
        , fuzz listInt "indexedMap" <|
            \list ->
                Expect.equal
                    (ModuloCons.indexedMap (+) list)
                    (List.indexedMap (+) list)
        , fuzz listInt "filter" <|
            \list ->
                Expect.equal
                    (ModuloCons.filter filterFn list)
                    (List.filter filterFn list)
        , fuzz pairOfLists "append" <|
            \( list1, list2 ) ->
                Expect.equal
                    (ModuloCons.append list1 list2)
                    (List.append list1 list2)
        , fuzz listListInt "concat" <|
            \lists ->
                Expect.equal
                    (ModuloCons.concat lists)
                    (List.concat lists)
        , fuzz listInt "intersperse" <|
            \list ->
                Expect.equal
                    (ModuloCons.intersperse -1 list)
                    (List.intersperse -1 list)
        , fuzz listInt "partition" <|
            \list ->
                Expect.equal
                    (ModuloCons.partition filterFn list)
                    (List.partition filterFn list)
        , fuzz listOfPairs "unzip" <|
            \list ->
                Expect.equal
                    (ModuloCons.unzip list)
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
