module View.Day exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, style)
import Html.Events exposing (..)
import Util.Time exposing (Date, formatDate)


{-| Don't modify
-}
type alias DailyData =
    { date : Date
    , highTemp : Maybe Float
    , lowTemp : Maybe Float
    , totalPrecipitaion : Float
    }


{-| Generates Html based on `DailyData`

Some relevant functions:

  - `Util.Time.formatDate`

-}
view : DailyData -> Html msg
view daily =
    let 
      date = 
            h1 [class "day-date"][text (formatDate daily.date)]
      
      highTemp = 
            case daily.highTemp of
              Just float -> h1 [class "day-hightemp"][text (String.fromFloat float)]
              Nothing -> h1 [class "day-hightemp"][text "unavailable"]

      lowTemp = 
            case daily.lowTemp of
              Just float -> h1 [class "day-lowtemp"][text (String.fromFloat float)]
              Nothing -> h1 [class "day-lowtemp"][text "unavailable"]

      totalPrecipitaion =
            p[class "day-precipitation"][text "2"]
    in
    div [class "day"]
      [
        date,
        highTemp,
        lowTemp,
        totalPrecipitaion
      ]
    -- div [] []
    --Debug.todo "Implement View.Day.view"
