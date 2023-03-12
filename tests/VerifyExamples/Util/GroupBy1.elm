module VerifyExamples.Util.GroupBy1 exposing (..)

-- This file got generated by [elm-verify-examples](https://github.com/stoeffel/elm-verify-examples).
-- Please don't modify this file by hand!

import Test
import Expect

import Util exposing (..)







spec1 : Test.Test
spec1 =
    Test.test "#groupBy: \n\n    groupBy (modBy 10) [ 11, 12, 21, 22 ]\n    --> [(1, [11, 21]), (2, [12, 22])]" <|
        \() ->
            Expect.equal
                (
                groupBy (modBy 10) [ 11, 12, 21, 22 ]
                )
                (
                [(1, [11, 21]), (2, [12, 22])]
                )