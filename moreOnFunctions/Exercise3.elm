module Exercise3 exposing (..)

import Html

wordCount: String -> Int
wordCount sentence =
    String.words sentence
    |> List.length

main =
    "How are you today! \n Well, I'm Good!"
    |> wordCount
    |> toString
    |> Html.text