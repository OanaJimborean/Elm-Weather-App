module VerifyExamples.Util.MaybeToList0 exposing (..)

-- This file got generated by [elm-verify-examples](https://github.com/stoeffel/elm-verify-examples).
-- Please don't modify this file by hand!

import Test
import Expect

import Util exposing (..)







spec0 : Test.Test
spec0 =
    Test.test "#maybeToList: \n\n    maybeToList Nothing\n    --> []" <|
        \() ->
            Expect.equal
                (
                maybeToList Nothing
                )
                (
                []
                )