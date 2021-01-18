module FuzzTests exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, intRange, list)
import Main
import Test exposing (Test, describe, fuzz)


listListIntFuzzer : Fuzzer (List (List Int))
listListIntFuzzer =
    list <| list <| intRange 0 10


suite : Test
suite =
    describe "Modulo cons fuzz tests"
        [ fuzz listListIntFuzzer "initialize" <|
            \lists -> Expect.equal (Main.concat lists) (List.concat lists)
        ]
