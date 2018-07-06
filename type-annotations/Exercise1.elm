module Exercise1 exposing (..)
import Html exposing (text)

type alias Item =
    {
        name : String
    ,   qty : Int
    ,   freeQty : Int
    }

cart : List Item
cart =
    [ { name = "Lemon", qty = 1, freeQty = 0}
    , { name = "Apple", qty = 5, freeQty = 0}
    , { name = "Pear", qty = 10, freeQty = 0}
    ]

getDiscount : Int -> Int -> Item -> Item
getDiscount minQty freeQty item =
    if item.freeQty ==0 && item.qty >= minQty then
        {item | freeQty = freeQty}
    else
        item

newCart : List Item
newCart =
    List.map ((getDiscount 10 3) >> (getDiscount 5 1)) cart

main : Html.Html msg
main =
    toString newCart
    |> text
