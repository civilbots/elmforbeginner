module Main exposing (..)
import Html exposing (Html, text, h1, div)



main : Html msg
main =
    text "Hello World"



-- MODEL

type alias Model =
    Int



-- MESSAGE

type Msg =
    Message



-- UPDATE

update : Msg -> Model -> Model
update msg model =
    model - 1



--VIEW

view : Model -> Html.Html Msg
view model =
    div [] [ h1 [] [ text ( "" ++ toString model) ] ]
