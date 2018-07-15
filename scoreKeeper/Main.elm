module Main exposing (..)

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


type alias Play =
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
                save model
        Cancel ->
            { model
                | playerName = ""
                , playerId = Nothing
            }
        Score scorer score ->
            let
                newPlayers =
                    List.map
                        (\player ->
                            if player.id == scorer.id then
                                { player
                                    | points = scorer.points + score
                                }
                            else
                                player
                        )
                        model.players
                newPlays =
                    Play (List.length model.plays) scorer.id scorer.name score :: model.plays
            in { model
                | players = newPlayers
                , plays = newPlays
            }


        _ ->
            model


save : Model -> Model
save model =
    case model.playerId of
        Just id ->
            edit model id
        Nothing ->
            add model


edit : Model -> Int -> Model
edit model id =
    let
        newPlayers =
            List.map
                (\player ->
                    if player.id == id then
                        { player
                            |   name = model.playerName
                        }
                    else
                        player
                )
           model.players
        newPlays =
            List.map
                (\play ->
                    if play.playerId == id then
                        { play
                            |   name = model.playerName
                        }
                    else
                        play
                )
           model.plays
    in { model
            |   players = newPlayers
            ,   plays = newPlays
            ,   playerName = ""
    }


add : Model -> Model
add model =
    let
        player =
            Player model.playerName (List.length model.players) 0
        newPlayers =
            player :: model.players
    in  { model
            |   players = newPlayers
            ,   playerName = ""
        }


-- view


view : Model -> Html Msg
view model =
    div [ class "scoreboard" ]
        [ h1
            []
            [ text "Score Keeper" ]
        , playerListView model
        , playerForm model
        ]


playerListView : Model -> Html Msg
playerListView model =
    div []
        [
            playerListHeader
        ,   playerList model
        ,   playerListTotal model
        ]


playerListHeader : Html Msg
playerListHeader =
    header []
        [   div [] [text "Name"]
        ,   div [] [text "Points"]
        ]


playerList : Model -> Html Msg
playerList model =
    model.players
        |> List.sortBy .name
        |> List.map player
        |> ul []


player : Player -> Html Msg
player player =
    li []
        [   i
                [   class "edit"
                ,   onClick (Edit player)
                ]
                []
        ,   div []
            [text player.name]
        ,   button
            [   type_ "button"
            ,   onClick (Score player 2)
            ]
            [ text "2pt" ]
        ,   button
            [   type_ "button"
            ,   onClick (Score player 3)
            ]
            [ text "3pt" ]
        ,   div []
            [ text (toString player.points) ]
        ]


playerListTotal : Model -> Html Msg
playerListTotal model =
    let
        total =
            List.map .points model.players
                |>  List.sum
    in
        footer []
            [   div [] [text "Total"]
            ,   div [] [text (toString total)]
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
