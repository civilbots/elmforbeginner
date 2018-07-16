module Model exposing (..)


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
