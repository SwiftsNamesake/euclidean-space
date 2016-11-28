
-- API -------------------------------------------------------------------------------------------------------------------------------------

module Euclid.Vector exposing (..)
{-| Defines a polymorphic Vector type

# Types
@docs Vector

# Construction
@docs vec

# Arithmetic
@docs add, subtract, negate, conjugate

# Transform
@docs map, map2, dotwise, fold, x, y

-}

-- Types -----------------------------------------------------------------------------------------------------------------------------------

{-| A 2D vector -}
type alias Vector n = { x : n, y : n }

-- Definitions  ----------------------------------------------------------------------------------------------------------------------------

{-| Construct a vector from an X and a Y value  -}
vec : n -> n -> Vector n
vec x y = { x = x, y = y }


{-| Add two vectors component-wise -}
add : Vector number -> Vector number -> Vector number
add a b = vec (a.x + b.x) (a.y + b.y)


{-| Subtract two vectors component-wise -}
subtract : Vector number -> Vector number -> Vector number
subtract a b = vec (a.x - b.x) (a.y - b.y)


{-| Negate both components -}
negate : Vector number -> Vector number
negate = map (\n -> -n)


{-| The complex conjugate (Y component is negated) -}
conjugate : Vector number -> Vector number
conjugate = y (\n -> -n)


{-| Apply some function to each component -}
map : (a -> b) -> Vector a -> Vector b
map f v = vec (f v.x) (f v.y)


{-| See 'dotwise' -}
map2 : (a -> a -> b) -> Vector a -> Vector a -> Vector b
map2 = dotwise


{-| Apply some function to two vectors component-wise (like map for two vectors)  -}
dotwise : (a -> a -> b) -> Vector a -> Vector a -> Vector b
dotwise f a b = vec (f a.x b.x) (f a.y b.y)


{-| Reduce a Vector to a single value by applying some function to its components -}
fold : (a -> a -> b) -> Vector a -> b
fold f v = f (v.x) (v.y)


{-| Apply some function to the X component -}
x : (a -> a) -> Vector a -> Vector a
x f v = vec (f v.x) v.y

{-| Apply some function to the y component -}
y : (a -> a) -> Vector a -> Vector a
y f v = vec v.x (f v.y)
