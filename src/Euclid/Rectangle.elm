-- A rectangle

module Euclid.Vector exposing (..)
{-| -}


import Euclid.Vector as Vec
import Euclid.Vector exposing (Vector)


-- Types -----------------------------------------------------------------------------------------------------------------------------------

type alias Rectangle n = { corner : Vector n,  }

-- Definitions -----------------------------------------------------------------------------------------------------------------------------

{-| Width of a rectangle -}
width : Rectangle n -> n
width = (.size) >> (.x)


{-| Height of a rectangle -}
height : Rectangle n -> n
height = (.size) >> (.y)


{-| Left side of a rectangle -}
left : Rectangle n -> n
left = .corner >> .x


{-| Right side of a rectangle -}
right : Rectangle n -> n
right = opposite >> .x


{-| Bottom side of a rectangle -}
bottom : Rectangle n -> n
bottom = opposite >> .y


{-| Opposite corner of a rectangle (bottom right) -}
opposite : Rectangle n -> Vector n
opposite rec = addVectors rec.corner rec.size
