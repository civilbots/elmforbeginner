module View exposing (..)


import Model exposing (..)
import Update exposing (Msg)


import Html exposing (Html,text, div, form, h1, input, button, ul, li, i, header, footer)
import Html.Attributes exposing (class, placeholder, value, type_)
import Html.Events exposing (onSubmit, onInput, onClick)


-- view


view : Model -> Html Msg
view model =
    div [ class "scoreboard" ]
        [ h1
            []
            [ text "Score Keeper" ]
        , playerListView model
        , playerForm model
        , playSection model
        ]


playSection : Model -> Html Msg
playSection model =
    div []
        [   playHeader
        ,   playList model
        ]


playList : Model -> Html Msg
playList model =
    model.plays
        |> List.map play
        |> ul []


play : Play -> Html Msg
play playEvent =
    li [] [ i
                [ class "remove"
                , onClick ( Update.DeletePlay playEvent )
                ]
                []
          , div [] [ text (toString playEvent.name) ]
          , div [] [ text (toString playEvent.points) ]
        ]


playHeader : Html Msg
playHeader =
    header []
        [   div [] [text "Plays"]
        ,   div [] [text "Points"]
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
                ,   onClick (Update.Edit player)
                ]
                []
        ,   div []
            [text player.name]
        ,   button
            [   type_ "button"
            ,   onClick (Update.Score player 2)
            ]
            [ text "2pt" ]
        ,   button
            [   type_ "button"
            ,   onClick (Update.Score player 3)
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
    Html.form [onSubmit Update.Save]
        [   input [ placeholder "Add/Edit Player..."
                ,   onInput Update.Input
                ,   value model.playerName
                ]
                []
        ,   button [ type_ "submit"] [ text "Save" ]
        ,   button [ type_ "button", onClick Update.Cancel ] [ text "Cancel" ]
        ]
