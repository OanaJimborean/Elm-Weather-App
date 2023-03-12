module View.Week exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, style)
import Html.Events exposing (..)
import Util.Time exposing (Date, formatDate)
import View.Day exposing (DailyData)


type alias WeeklyData =
    { dailyData : List DailyData
    }


{-| Generates Html based on `WeeklyData`

Some relevant functions:

  - `Util.Time.formatDate`

-}
view : WeeklyData -> Html msg
view weekly =
    -- let 
    --   aux = List.head weekly.dailyData
    --   firstView = 
    --     case aux of
    --       Nothing -> h2[][text "No data"] 
    --       Just a -> h2[][View.Day.view a] 

    --   listTail = (List.tail(List.reverse weekly.dailyData))

    --   midView =
    --     case listTail of
    --       Nothing -> p[][text "No data"]
    --       Just l -> p[] <| List.map (View.Day.view) (List.reverse l)
      
    --   listHead = List.head (List.reverse weekly.dailyData)
    --   lastView =
    --     case listHead of
    --       Nothing -> h2[][text "No data"]
    --       Just h -> h2[][View.Day.view h]
    --   --   h2[][View.Day.view (List.head (List.reverse weekly.dailyData))]
  let 
    func = 
      case weekly.dailyData of
        [] -> h2[][text "No data"]
        x::xs -> h2[] <| List.map View.Day.view weekly.dailyData
  in
    div [class "week"] [--firstView,
                         --midView,
                         --lastView
                         func
        --h2[] <| List.map View.Day.view weekly.dailyData
        ]
    --Debug.todo "Implement View.Week.view"
