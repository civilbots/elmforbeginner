module Exercise1 exposing (..)

import Html

(~=): String -> String -> Bool
(~=) first second =
     String.left 1 first == String.left 1 second


main =
    "Ganesh"
     ~= "Games"
     |> toString
     |> Html.text