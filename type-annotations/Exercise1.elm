module Exercise1 exposing (..)
import Html exposing (text)

type alias ITEM =
    {
        name : String
    ,   qty : Int
    ,   freeQty : Int
    }

cart : List ITEM
cart =
    [ { name = "Lemon", qty = 1, freeQty = 0}
    , { name = "Apple", qty = 5, freeQty = 0}
    , { name = "Pear", qty = 10, freeQty = 0}
    ]

getDiscount : Int -> Int -> ITEM -> ITEM
getDiscount minQty freeQty item =
    if item.freeQty ==0 && item.qty >= minQty then
        {item | freeQty = freeQty}
    else
        item

newCart : List ITEM
newCart =
    List.map ((getDiscount 10 3) >> (getDiscount 5 1)) cart

main : Html.Html msg
main =
    toString newCart
    |> text
