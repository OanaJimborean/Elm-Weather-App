module VerifyExamples.Util.MaximumBy2 exposing (..)

-- This file got generated by [elm-verify-examples](https://github.com/stoeffel/elm-verify-examples).
-- Please don't modify this file by hand!

import Test
import Expect

import Util exposing (..)







spec2 : Test.Test
spec2 =
    Test.test "#maximumBy: \n\n    maximumBy .x [ { x = 1, y = 2 } ]\n    --> Just {x = 1, y = 2}" <|
        \() ->
            Expect.equal
                (
                maximumBy .x [ { x = 1, y = 2 } ]
                )
                (
                Just {x = 1, y = 2}
                )