module DataStore exposing (..)

import Data exposing (..)


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
