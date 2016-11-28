-- A rectangle

module Euclid.Rectangle exposing (..)
{-| Defines a Rectangle type

# Types
@docs Rectangle

# Properties
@docs width, height, left, right, top, bottom, opposite

-}


import Euclid.Vector as Vec
import Euclid.Vector exposing (Vector)


-- Types -----------------------------------------------------------------------------------------------------------------------------------

{-| A polymorphic rectangle defined by its top left corner and its size -}
type alias Rectangle n = { corner : Vector n, size : Vector n }

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
right : Rectangle number -> number
right = opposite >> .x


{-| Top side of a rectangle -}
top : Rectangle number -> number
top = .corner >> .y


{-| Bottom side of a rectangle -}
bottom : Rectangle number -> number
bottom = opposite >> .y


{-| Opposite corner of a rectangle (bottom right) -}
opposite : Rectangle number -> Vector number
opposite rec = Vec.add rec.corner rec.size
