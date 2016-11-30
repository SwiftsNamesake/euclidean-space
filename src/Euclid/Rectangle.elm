-- A rectangle

module Euclid.Rectangle exposing (..)
{-| Defines a Rectangle type

# Types
@docs Rectangle

# Properties
@docs width, height, left, right, top, bottom, opposite

# Misc
@docs hasPoint
-}


import Euclid.Vector as Vec
import Euclid.Vector exposing (V2, HasX, HasY, HasZ, HasXY, HasXYZ)


-- Types -----------------------------------------------------------------------------------------------------------------------------------

{-| A polymorphic rectangle defined by its top left corner and its size -}
type alias Rectangle v = { corner : v, size : v }

-- Definitions -----------------------------------------------------------------------------------------------------------------------------

{-| Width of a rectangle -}
width : Rectangle (HasX v n) -> n
width = .size >> (.x)


{-| Height of a rectangle -}
height : Rectangle (HasY v n) -> n
height = .size >> (.y)


{-| Left side of a rectangle -}
left : Rectangle (HasX v n) -> n
left = .corner >> .x


{-| Right side of a rectangle -}
right : Rectangle (V2 number) -> number
right = opposite >> .x


{-| Top side of a rectangle -}
top : Rectangle (V2 number) -> number
top = .corner >> .y


{-| Bottom side of a rectangle -}
bottom : Rectangle (V2 number) -> number
bottom = opposite >> .y


{-| Opposite corner of a rectangle (bottom right) -}
opposite : Rectangle (V2 number) -> V2 number
opposite rec = Vec.add rec.corner rec.size


{-| Does the rectangle contain the point? -}
hasPoint : Rectangle (V2 comparable) ->  V2 comparable -> Bool
hasPoint rec p = (left rec <= p.x) && (p.x < right rec) && (top rec <= p.y) && (p.y < bottom rec)
