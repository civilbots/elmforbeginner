# Planning Basketball Scorekeeper App

## Model


TODO: Model's shape

```
Model =
    { players : List Player
    , playerName : String
    , playerId : Maybe Int
    , plays : Lisst Play
    }
```


TODO: Player's shape

```
Player =
    { id : Int
    , name : Int
    , points : Int
    }
```

TODO: Play's shape

```
Play =
    { id : Int
    , playerId : Int
    , name : Int
    , points : Int
    }
```

TODO: Initial model

## Update

What things can be done in our app?

* Edit
* Score
* Input
* Save
* Cancel
* DeletePlay

TODO: Create message union type

TODO: Create update functions

## View

What are the logical sections/groupings of our UI?

* main view (outermost function)
    * player section
        * player list header
        * player list
            * player
        * point total
    * player form
    * play section
        * play list header
        * play list
            * play
            
TODO: Create functions for each of the above



