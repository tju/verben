module Field exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick, on, keyCode)
import Json.Decode exposing (customDecoder)


type alias Field =
    { label : String
    , expected : String
    , entered : String
    , status : ValidationStatus
    }


type ValidationStatus
    = None
    | Error
    | Success


type Msg
    = SetField String
    | Check
    | Enter



-- VIEW


view : Field -> Html Msg
view field =
    div [ getStatusClass field.status ]
        [ div [ class "column" ]
            [ label [] [ text field.label ] ]
        , div [ class "column" ]
            [ fieldTemplate field ]
        ]


fieldTemplate field =
    case field.status of
        None ->
            input
                [ type' "text"
                , onEnter Enter
                , onInput SetField
                , value field.entered
                ]
                []

        Error ->
            div [ class "result" ]
                [ span [ class "expected" ] [ text field.expected ]
                , span [ class "entered" ] [ text field.entered ]
                ]

        Success ->
            div [ class "result" ]
                [ span [ class "entered" ] [ text field.entered ]
                ]


getStatusClass : ValidationStatus -> Html.Attribute Msg
getStatusClass status =
    case status of
        None ->
            class "row"

        Success ->
            class "row has-success"

        Error ->
            class "row has-error"



-- UPDATE


update : Msg -> Field -> Field
update msg field =
    case msg of
        SetField value ->
            { field | entered = value, status = None }

        Check ->
            { field | status = checkStatus field }

        Enter ->
            field


checkStatus : Field -> ValidationStatus
checkStatus field =
    if field.entered == field.expected then
        Success
    else
        Error


onEnter enter =
    onKeyUp [ ( 13, enter ) ]


onKeyUp options =
    let
        filter optionsToCheck code =
            case optionsToCheck of
                [] ->
                    Err "key code is not in the list"

                ( c, msg ) :: rest ->
                    if (c == code) then
                        Ok msg
                    else
                        filter rest code

        keyCodes =
            customDecoder keyCode (filter options)
    in
        on "keyup" keyCodes
