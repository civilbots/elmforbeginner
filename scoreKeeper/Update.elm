module Update exposing (..)


import Model exposing (..)


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
        Edit player ->
            { model
              | playerName = player.name
            , playerId = Just player.id
            }
        DeletePlay play ->
            let newPlays =
                    model.plays
                        |> List.filter
                            ( \p -> p.id /= play.id )
                newPlayers =
                    model.players
                        |> List.map
                            (\player ->
                                if player.id == play.playerId then
                                    { player
                                        | points = player.points - play.points
                                    }
                                 else
                                    player
                                )
            in { model | players = newPlayers , plays = newPlays }


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
            ,   playerId = Nothing
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
