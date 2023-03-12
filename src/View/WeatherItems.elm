module View.WeatherItems exposing (view)

import Html exposing (..)
import Html.Attributes as HA exposing (class, style)
import Html.Events exposing (..)
import Model.WeatherItems exposing (SelectedWeatherItems, WeatherItem(..))
import View.WeatherChart exposing (ShownItems)
import View.WeatherChart exposing (showAllItems)


checkbox : String -> Bool -> (WeatherItem -> Bool -> msg) -> WeatherItem -> Html msg
checkbox name state msg category =
    div [ style "display" "inline", class "checkbox" ]
        [ input [ HA.type_ "checkbox", onCheck (msg category), HA.checked state ] []
        , text name
        ]


type alias MsgMap msg =
    { onChangeSelection : WeatherItem -> Bool -> msg }


view : MsgMap msg -> SelectedWeatherItems -> Html msg
view msgMap isItemSelected =
    div []  [
        checkbox ( "Temperature" ) ( Model.WeatherItems.isItemSelected Model.WeatherItems.Temperature isItemSelected ) ( msgMap.onChangeSelection ) ( Model.WeatherItems.Temperature )
        , checkbox ( "Precipitation" ) ( Model.WeatherItems.isItemSelected Model.WeatherItems.Precipitation isItemSelected ) ( msgMap.onChangeSelection ) ( Model.WeatherItems.Precipitation )
        , checkbox ( "MinMax" ) ( Model.WeatherItems.isItemSelected Model.WeatherItems.MinMax isItemSelected ) ( msgMap.onChangeSelection ) ( Model.WeatherItems.MinMax )
        , checkbox ( "CurrentTime" ) ( Model.WeatherItems.isItemSelected Model.WeatherItems.CurrentTime isItemSelected ) ( msgMap.onChangeSelection ) ( Model.WeatherItems.CurrentTime )
    ]
    -- Debug.todo "view"

