module Field exposing (..)

import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)


-- main =
--     Html.beginnerProgram
--         { model = initialModel
--         , view = view
--         , update = update
--         }


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



-- initialModel : Field
-- initialModel =
--     Field "Präteritum" "ging" "gugu" None


type Msg
    = SetField String
    | Check



-- VIEW


view : Field -> Html Msg
view field =
    div [ class "form-group label-floating", (getStatusClass field.status) ]
        [ label [ class "control-label" ] [ text field.label ]
        , input [ class "form-control", type' "text", onInput SetField, value field.entered ] []
        , geStatusIcon field.status
          -- , button [ onClick Check ] [ text "Check bre" ]
          -- , div [] [ text (toString field) ]
        ]


geStatusIcon : ValidationStatus -> Html Msg
geStatusIcon status =
    case status of
        None ->
            span [] []

        Success ->
            span [ class "form-control-feedback" ]
                [ i [ class "material-icons" ]
                    [ text "done" ]
                ]

        Error ->
            span [ class "form-control-feedback" ]
                [ i [ class "material-icons" ]
                    [ text "clear" ]
                ]


getStatusClass : ValidationStatus -> Html.Attribute Msg
getStatusClass status =
    case status of
        None ->
            class ""

        Success ->
            class "has-success"

        Error ->
            class "has-error"



-- UPDATE


update : Msg -> Field -> Field
update msg field =
    case msg of
        SetField value ->
            { field | entered = value, status = None }

        Check ->
            { field | status = checkStatus field }


checkStatus : Field -> ValidationStatus
checkStatus field =
    if field.entered == field.expected then
        Success
    else
        Error
