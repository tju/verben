module App exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Html.App as App
import Html.Attributes exposing (type', action, class, method, href)
import DataStore exposing (..)
import Form exposing (..)
import Data exposing (..)


main =
    App.beginnerProgram
        { model = initialAppModel
        , view = view
        , update = update
        }


type alias AppModel =
    { dataStore : List Data
    , form : Form.Form
    , isFormVisible : Bool
    }


emptyForm =
    Form.initialForm (Data "" "" "" "" 0)


initialAppModel : AppModel
initialAppModel =
    { dataStore = getDataStore
    , form = emptyForm
    , isFormVisible = True
    }


type Msg
    = FormMsg Form.Msg
    | Next



-- UPDATE


update msg app =
    case msg of
        FormMsg fMsg ->
            { app | form = Form.update fMsg app.form }

        Next ->
            let
                ( newForm, ds ) =
                    getNextForm app
            in
                { app
                    | form = newForm
                    , dataStore = ds
                    , isFormVisible = False
                }


getNextForm : AppModel -> ( Form.Form, List Data )
getNextForm app =
    case app.dataStore of
        [] ->
            ( emptyForm, [] )

        h :: t ->
            if app.isFormVisible then
                ( initialForm h, t )
            else
                ( initialForm h, List.append t [ (Form.getData app.form) ] )



-- VIEW


view model =
    div []
        [ div [] [ App.map FormMsg (Form.view model.form) ]
        , div
            [ class "footer text-center"
            , type' "button"
            , onClick Next
            ]
            [ a [ class "btn btn-primary btn-lg", href "#pablo" ]
                [ text "NEXT" ]
            ]
        ]
