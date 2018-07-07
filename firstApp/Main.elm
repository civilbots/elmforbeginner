module Main exposing (..)

import Html exposing (div, h3, button, text)
import Html.Events exposing (onClick)


main =
    Html.beginnerProgram
    {
      model = initModel
    , update = update
    , view = view
    }

type alias Model = Int

initModel : Model
initModel =
    0

type Msg
    = AddCalore
    | Clear

update : Msg -> Model -> Model
update msg model=
    case msg of
        AddCalore ->
            model + 1
        Clear ->
            initModel

view : Model -> Html.Html Msg
view model =
    div []
     [
       h3 []
         [ text ("Total Calories = " ++ (toString model)) ]
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
