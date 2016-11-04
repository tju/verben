module Profile exposing (..)

import Html exposing (..)
import Html.Attributes exposing (type', action, class, method, href, src)


type alias Model =
    { name : String
    , picUrl : String
    , level : Int
    }


initialProfile =
    Model "ninja123" "http://www.ninjasoftware.net/images/NinjaSoftware.png" 0


view profile =
    div []
        [ div [ class "row" ]
            [ div [ class "column col-center" ]
                [ img [ class "profilePic", src profile.picUrl ] [] ]
            , div [ class "column" ]
                [ h5 []
                    [ text profile.name ]
                , h3 []
                    [ text <| "Level" ++ (toString profile.level) ]
                ]
            ]
        ]
