module Main exposing (..)

import Html exposing (Html,text, div, form, h1, input, button)
import Html.Attributes exposing (class, placeholder, value, type_)
import Html.Events exposing (onSubmit, onInput, onClick)


main: Program Never Model Msg
main =
    Html.beginnerProgram
    { model = initModel
    , update = update
    , view = view
    }


-- model


type alias Model =
    {   players : List Player
    ,   playerName : String
    ,   playerId : Maybe Int
    ,   plays : List Play
    }


type alias Player =
    {   name : String
    ,   id : Int
    ,   points : Int
    }


type alias Play=
    {   id : Int
    ,   playerId : Int
    ,   name : String
    ,   points : Int
    }


initModel : Model
initModel =
    {   players = []
    ,   playerName = ""
    ,   playerId = Nothing
    ,   plays = []
    }


-- update


type Msg
    = Save
    | Edit Player
    | Cancel
    | Score Player Int
    | Input String
    | DeletePlay Play


update: Msg -> Model -> Model
update msg model =
    case msg of
        Input name ->
            { model | playerName = name }
        Save ->
            if String.isEmpty model.playerName then
                model
            else
                add model
        Cancel ->
            { model | playerName = "" }
        _ ->
            model


add : Model -> Model
add model =
    let
        player =
            Player model.playerName (List.length model.players) 0
        newPlayers =
            player :: model.players
    in  { model
            | players = newPlayers
            , playerName = ""
        }

-- view


view : Model -> Html Msg
view model =
    div [ class "scoreboard" ]
        [ h1
            []
            [ text "Score Keeper" ]
        , playerForm model
        ]


playerForm : Model -> Html Msg
playerForm model =
    Html.form [onSubmit Save]
        [   input [ placeholder "Add/Edit Player..."
                ,   onInput Input
                ,   value model.playerName
                ]
                []
        ,   button [ type_ "submit"] [ text "Save" ]
        ,   button [ type_ "button", onClick Cancel ] [ text "Cancel" ]
        ,   div [] [ text (toString model) ]
        ]


