module Main exposing (..)

import Html exposing (input, div, h3, button, text, br)
import Html.Attributes exposing (placeholder, value)
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
    , error : Maybe String
    }

initModel : Model
initModel =
    Model 0 0 Nothing

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
                    { model
                        | input = calories
                        , error = Nothing
                    }
                Err err ->
                    { model
                        | input = 0
                        , error = Just err
                    }
        Clear ->
            { model |
                calories = 0
            ,   input = 0
            ,   error = Nothing
            }


--VIEW


view : Model -> Html.Html Msg
view model =
    div []
     [
       h3 []
         [
            text ("Total Calories = " ++ toString model.calories )
         ]
     , input
        [
          placeholder "Enter calories here"
        , onInput Input
        , value
            ( if model.input == 0 then
                ""
              else
                toString model.input
            )
        ]
        []
     , div  [] [ text (Maybe.withDefault "" model.error)]
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
