module Main exposing (main)

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Http
import Regex


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = (\model -> Sub.none)
        }


--------------------------------------------------------------------------------
-- MODEL --
-----------

type alias Model =
    { query : String
    , content : String
    , wordbook : List String
    }

init : (Model, Cmd Msg)
init =
    (
        { query = ""
        , content = ""
        , wordbook = []
        },
        loadWordbook
    )

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
            (
                { model
                | query = query
                , content =
                    if String.length query > 1
                    then find model.wordbook query
                    else ""
                },

                Cmd.none
            )

        Load (Ok data) ->
            ({model | wordbook = String.split "\n" data}, Cmd.none)

        Load (Err _) ->
            (model, Cmd.none)

find : List String -> String -> String
find wordbook query =
    wordbook
    |> List.filter (\line -> Regex.contains (Regex.regex query) line)
    |> String.join "\n\n"
    |> Regex.replace Regex.All (Regex.regex "\\t::") (\_ -> "\n")


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
            , ("overflow-y", "scroll")
            , ("border-style", "inset")
            , ("border-width", "medium")
            , ("height", "25em")
            , ("width", "128ex")
            ]
    in
        [text content] |> node "pre" [preStyle]
