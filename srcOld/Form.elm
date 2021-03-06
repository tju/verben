module Form exposing (..)

import Html exposing (..)
import Html.App as App
import Html.Events exposing (onInput, onClick)
import Field
import Html.Attributes exposing (type', action, class, method, href, disabled)


type alias Model =
    { f1 : Field.Field
    , f2 : Field.Field
    , f3 : Field.Field
    , infinitiv : String
    , score : Int
    , checked : Bool
    }


emptyForm : Model
emptyForm =
    init (Data "" "" "" "" 0)


init : Data -> Model
init data =
    { f1 = Field.Field "Präsens (3. Person Singular)" data.f1 "" Field.None
    , f2 = Field.Field "Präteritum (3. Person Singular)" data.f2 "" Field.None
    , f3 = Field.Field "Perfekt (3. Person Singular)" data.f3 "" Field.None
    , infinitiv = data.infinitiv
    , score = data.score
    , checked = False
    }


getData : Model -> Data
getData form =
    { f1 = form.f1.expected
    , f2 = form.f2.expected
    , f3 = form.f3.expected
    , infinitiv = form.infinitiv
    , score = form.score
    }



-- UPDATE


type Msg
    = Check
    | F1Msg Field.Msg
    | F2Msg Field.Msg
    | F3Msg Field.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Check ->
            ( checkForm model, Cmd.none )

        F1Msg msg ->
            ( { model | f1 = Field.update msg model.f1 }, Cmd.none )

        F2Msg msg ->
            ( { model | f2 = Field.update msg model.f2 }, Cmd.none )

        F3Msg (Field.Enter) ->
            ( checkForm model, Cmd.none )

        F3Msg msg ->
            ( { model | f3 = Field.update msg model.f3 }, Cmd.none )


checkForm model =
    let
        f1 =
            Field.update Field.Check model.f1

        f2 =
            Field.update Field.Check model.f2

        f3 =
            Field.update Field.Check model.f3

        score =
            if hasErrors model then
                0
            else
                model.score + 1
    in
        { model
            | f1 = f1
            , f2 = f2
            , f3 = f3
            , score = score
            , checked = True
        }


hasErrors : Model -> Bool
hasErrors form =
    if (form.f1.status == Field.Success && form.f2.status == Field.Success && form.f3.status == Field.Success) then
        False
    else
        True



-- VIEW


view model =
    case model.infinitiv of
        "" ->
            div [] []

        str ->
            form [ action "", class "form", method "" ]
                [ div [ class "header header-primary text-center" ]
                    [ h2 [] [ text str ]
                    ]
                , div [ class "content" ]
                    [ App.map F1Msg (Field.view model.f1)
                    , App.map F2Msg (Field.view model.f2)
                    , App.map F3Msg (Field.view model.f3)
                    ]
                , div [ class "row " ] [ div [ class "column" ] [ checkButton model ] ]
                ]


checkButton form =
    if form.checked then
        text ""
    else
        button
            [ type' "button"
            , disabled <| form.f1.entered == "" || form.f2.entered == "" || form.f3.entered == ""
            , class "button"
            , onClick Check
            ]
            [ text "Check" ]




type alias Data =
    { infinitiv : String
    , f1 : String
    , f2 : String
    , f3 : String
    , score : Int
    }

getDataStore : List Data
getDataStore =
    -- todo real store from DB?!
    [ { infinitiv = "gehen"
      , f1 = "geht"
      , f2 = "ging"
      , f3 = "ist gegangen"
      , score = 0
      }
    , { infinitiv = "sein"
      , f1 = "ist"
      , f2 = "war"
      , f3 = "ist gewesen"
      , score = 0
      }
    , { infinitiv = "haben"
      , f1 = "hat"
      , f2 = "hatte"
      , f3 = "hat gehabt"
      , score = 0
      }
    ]


