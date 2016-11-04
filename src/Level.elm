module Level exposing (..)

import Form
import Html exposing (div, text, button)
import Html.Events exposing (onClick)
import Data exposing (..)
import Html.App
import VirtualDom
import DataStore


type alias Model =
    { level : Int
    , total : Int
    , done : Int
    , form : Form.Model
    , dataStore : List Data
    }


init : Model
init =
    Model 0 11 0 Form.emptyForm DataStore.getDataStore


type Msg
    = FormMsg Form.Msg
    | Next


update : Msg -> Model -> Model
update msg model =
    case msg of
        FormMsg fMsg ->
            { model | form = Form.update fMsg model.form }

        Next ->
            let
                ( newForm, ds ) =
                    getNextForm model
            in
                { model
                    | form = newForm
                    , dataStore = ds
                }


getNextForm : Model -> ( Form.Model, List Data )
getNextForm model =
    case model.dataStore of
        [] ->
            ( Form.emptyForm, [] )

        h :: t ->
            if model.form.score > 2 then
                ( Form.init h, t )
                -- done with
            else
                ( Form.init h, List.append t [ (Form.getData model.form) ] )


view : Model -> VirtualDom.Node Msg
view model =
    div []
        [ text ("Welcome to level: " ++ (toString model.level))
        , div [] [ Html.App.map FormMsg (Form.view model.form) ]
        , button [ onClick Next ] [ text "Next" ]
        ]
