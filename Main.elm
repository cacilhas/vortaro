module Main exposing (main)

import Html exposing (Html, div, input, node, text)
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
            { model
            | query = query
            , content =
                if String.length query > 1
                then find model.wordbook query
                else ""
            }
            ! []

        Load (Ok data) ->
            {model | wordbook = String.split "\n" data} ! []

        Load (Err _) ->
            model ! []

find : List String -> String -> String
find wordbook query =
    let rquery = Regex.regex query
        tabsub = Regex.regex "\\t::"
    in
        wordbook
        |> List.filter (\line -> Regex.contains rquery line)
        |> String.join "\n\n"
        |> Regex.replace Regex.All tabsub (\_ -> "\n")


--------------------------------------------------------------------------------
-- VIEW --
----------

view : Model -> Html Msg
view model =
    div []
        [ input [placeholder "Serĉu", onInput Query] []
        , pre model.content
        ]

pre : String -> Html msg
pre content =
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
    in [text content] |> node "pre" [preStyle]
