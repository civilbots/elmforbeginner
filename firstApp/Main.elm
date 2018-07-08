module Main exposing (..)

import Html exposing (input, div, h3, button, text, br)
import Html.Attributes exposing (placeholder)
import Html.Events exposing (onClick, onInput)


main : Program Never Model Msg
main =
    Html.beginnerProgram
    {
      model = initModel
    , update = update
    , view = view
    }

--Model


type alias Model =
    {
      input : Int
    , calories : Int
    }

initModel : Model
initModel =
    Model 0 0

type Msg
    = AddCalore
    | Input String
    | Clear


--Update


update : Msg -> Model -> Model
update msg model=
    case msg of
        AddCalore ->
            { model | calories = model.calories + model.input }
        Input value ->
            case String.toInt value of
                Ok calories ->
                    { model | input = calories }
                Err err ->
                    { model | input = 0 }
        Clear ->
            { model | calories = 0 }


--VIEW


view : Model -> Html.Html Msg
view model =
    div []
     [
       h3 []
         [ text ("Total Calories = " ++ (toString model.calories)) ]
     , input
        [
          placeholder "enter calories here"
        , onInput Input
        ]
        []
     , br [] []
     , button
         [
           onClick AddCalore
         ]
         [ text "Add"]
     , button
         [
           onClick Clear
         ]
         [ text "reset"]
     ]
