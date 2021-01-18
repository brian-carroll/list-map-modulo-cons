module HtmlTests exposing (..)

import Benchmarks
import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, intRange, list)
import Html exposing (Html, div, h1, text)
import Random
import Test exposing (Test, describe, fuzz, test)
import Test.Runner.Html exposing (defaultConfig, hidePassedTests, showPassedTests, viewResults)


listListIntFuzzer : Fuzzer (List (List Int))
listListIntFuzzer =
    list <| list <| intRange 0 10


checkConcat : List (List Int) -> Expectation
checkConcat lists =
    let
        modConsResult =
            Benchmarks.concat lists

        coreResult =
            List.concat lists

        display =
            { input = lists
            , modCons = modConsResult
            , core = coreResult
            }

        _ =
            if modConsResult /= coreResult then
                Debug.log "failed" display

            else
                display
    in
    Expect.equal coreResult modConsResult


suite : Test
suite =
    describe "Modulo cons"
        [ test "concat [[]]" <|
            \() -> checkConcat [ [] ]
        , test "concat [[], []]" <|
            \() -> checkConcat [ [], [] ]
        , test "concat []" <|
            \() -> checkConcat []

        -- , fuzz listListIntFuzzer "concat" checkConcat
        ]


config =
    Random.initialSeed 10000 |> defaultConfig |> showPassedTests


main : Html msg
main =
    div []
        [ h1 [] [ text "My Test Suite" ]
        , div [] [ viewResults config suite ]
        ]
