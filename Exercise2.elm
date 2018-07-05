module Exercise exposing (..)
import Html

getLength: String -> Int
getLength name =
    String.length name

getFormattedInput: String -> String
getFormattedInput input =
    if getLength input > 10 then
        String.toUpper input
    else
        input

getResult: String -> String
getResult input =
    getFormattedInput input ++ " - name length: " ++ toString (getLength input)


main =
    Html.text (getResult "Ganapathi")