module Main exposing (main)

import Html exposing (Html, div, input, node, pre, text)
import Html.Events exposing (onInput)
import Html.Attributes exposing (placeholder, style)
import Http
import Regex


main : Program Never Model Msg
main =
    Html.program
        { init = Model "" "" [] ! [loadWordbook]
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }


--------------------------------------------------------------------------------
-- MODEL --
-----------

type alias Model =
    { query : String
    , content : String
    , wordbook : List String
    }

loadWordbook : Cmd Msg
loadWordbook =
    let url = "./vortaro.text"
        request = Http.getString url
    in Http.send Load request


--------------------------------------------------------------------------------
-- UPDATE --
------------

type Msg
    = Query String
    | Load (Result Http.Error String)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Query query ->
            {model | query = query, content = find query model.wordbook} ! []

        Load (Ok data) ->
            {model | wordbook = String.split "\n" data} ! []

        Load (Err _) ->
            {model | content = "ocorreu um erro"} ! []

find : String -> List String -> String
find query wordbook =
    if String.length query > 1
    then
        let rquery = Regex.regex query
            filter_ = Regex.contains rquery
        in
            wordbook
            |> List.filter filter_
            |> String.join "\n\n"
            |> Regex.replace Regex.All (Regex.regex "\\t::") (\_ -> "\n")

    else ""


--------------------------------------------------------------------------------
-- VIEW --
----------

view : Model -> Html Msg
view model =
    div []
        [ input [placeholder "Serĉu", onInput Query] []
        , display model.content
        ]

display : String -> Html msg
display content =
    let preStyle =
        style
            [ ("background-color", "white")
            , ("word-break", "break-word")
            , ("word-wrap", "break-word")
            , ("white-space", "pre-wrap")
            , ("white-space", "-moz-pre-wrap")
            , ("white-space", "-o-pre-wrap")
            , ("white-space", "-pre-wrap")
            , ("overflow-x", "hidden")
            , ("overflow-y", "scroll")
            , ("border-style", "inset")
            , ("border-width", "medium")
            , ("height", "25em")
            , ("width", "128ex")
            ]
    in [text content] |> pre [preStyle]
