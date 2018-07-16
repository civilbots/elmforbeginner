module Main exposing (..)


import Model exposing (..)
import Update exposing (..)
import View exposing (..)


import Html exposing (Html,text, div, form, h1, input, button, ul, li, i, header, footer)
import Html.Attributes exposing (class, placeholder, value, type_)
import Html.Events exposing (onSubmit, onInput, onClick)


main: Program Never Model Msg
main =
    Html.beginnerProgram
    { model = initModel
    , update = update
    , view = view
    }
