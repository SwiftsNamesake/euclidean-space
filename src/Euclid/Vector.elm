
-- API -------------------------------------------------------------------------------------------------------------------------------------

module Euclid.Vector exposing (..)
{-| Defines a polymorphic Vector type. Due to limits of Elm's type system and also due to my own requirements, many functions will
   only work with 2D vectors.

# Types
@docs V1, V2, V3, HasX, HasY, HasZ, HasXY, HasXYZ, Vector

# Construction
@docs vec

# Arithmetic
@docs add, subtract, negate, conjugate

# Transform
@docs map, map2, dotwise, scale

# Focus
@docs x, y, z

# Polar coordinates
@docs fromPolar, arg, abs

# Polymorphic stuff
@docs foldX, foldXY, foldXYZ, apX, apXY, apXYZ

-}

-- Types -----------------------------------------------------------------------------------------------------------------------------------

{-| A 1D vector (for completeness' sake) -}
type alias V1 n = { x : n }

{-| A 2D vector -}
type alias V2 n = { x : n, y : n }

{-| A 3D vector -}
type alias V3 n = { x : n, y : n, z : n }

{-| A type that has an x field -}
type alias HasX v n = {v| x : n}

{-| A type that has an y field -}
type alias HasY v n = {v| y : n}

{-| A type that has an z field -}
type alias HasZ v n = {v| z : n}

{-| A type that has an x and a y field -}
type alias HasXY v n = {v| x : n, y : n}

{-| A type that has an x, a y and a z field -}
type alias HasXYZ v n = {v| x : n, y : n, z : n}

-- type alias Foldable    t a b = {t|fold : (a -> b -> b) -> t -> b }
-- type alias Applicative t a   = {t|pure : a -> (t a), ap : (a -> ) }

-- Definitions  ----------------------------------------------------------------------------------------------------------------------------

{-| Construct a vector from an X and a Y value  -}
vec : n -> n -> V2 n
vec x y = { x = x, y = y }


{-| Add two vectors component-wise -}
add : V2 number -> V2 number -> V2 number
add a b = vec (a.x + b.x) (a.y + b.y)


{-| Subtract two vectors component-wise -}
subtract : V2 number -> V2 number -> V2 number
subtract a b = vec (a.x - b.x) (a.y - b.y)


{-| Negate both components -}
negate : V2 number -> V2 number
negate = map (\n -> -n)


{-| The complex conjugate (Y component is negated) -}
conjugate : V2 number -> V2 number
conjugate = y (\n -> -n)


{-| Multiply the vector by a scalar -}
scale : number -> V2 number -> V2 number
scale sc v = vec (sc * v.x) (sc * v.y)


{-| Apply some function to each component -}
map : (a -> b) -> V2 a -> V2 b
map f v = vec (f v.x) (f v.y)


{-| See 'dotwise' -}
map2 : (a -> b -> c) -> V2 a -> V2 b -> V2 c
map2 = dotwise


{-| Apply some function to two vectors component-wise (like map for two vectors)  -}
dotwise : (a -> b -> c) -> V2 a -> V2 b -> V2 c
dotwise f a b = vec (f a.x b.x) (f a.y b.y)


{-| Apply some function to the X component -}
x : (n -> m) -> HasX v n -> HasX v m
x f v = {v|x = f v.x}


{-| Apply some function to the y component -}
y : (n -> m) -> HasY v n -> HasY v m
y f v = {v|y = f v.y}


{-| Apply some function to the z component -}
z : (n -> m) -> HasZ v n -> HasZ v m
z f v = {v|z = f v.z}


{-| Construct a V2 from an angle (in radians) and a magnitude -}
fromPolar : Float -> Float -> V2 Float
fromPolar angle mag = vec (mag * cos angle) (mag * sin angle)


{-| Finds the 'argument' (in radians) of a vector (the angle between the vector and the positive X axis) -}
arg : V2 Float -> Float
arg v = atan2 v.y v.x


{-| Finds the absolute value (also known as the magnitude) of a vector -}
abs : V2 number -> number
abs v = sqrt <| v.x^2 + v.y^2

-- Let's pretend Elm has type classes ------------------------------------------------------------------------------------------------------

{-| ... -}
type alias Vector v w x n b = {v| methods : { fold : (n -> b -> b), pure : n -> v, ap : v -> w -> x } }


{-| Folds the components from the left -}
foldX : (a -> b -> b) -> b -> HasX v a -> b
foldX f b v = f v.x b


{-| Folds the components from the left -}
foldXY : (a -> b -> b) -> b -> HasXY v a -> b
foldXY f b v = f v.x (f v.y b)


{-| Folds the components from the left -}
foldXYZ : (a -> b -> b) -> b -> HasXYZ v a -> b
foldXYZ f b v = f v.x (f v.y (f v.z b))


{-| Apply a 1D vector of functions to a 1d vector of arguments -}
apX : HasX v (a -> b) -> HasX v a -> HasX v b
apX fs v = {v|x = fs.x v.x}


{-| Apply a 2D vector of functions to a 2d vector of arguments -}
apXY : HasXY v (a -> b) -> HasXY v a -> HasXY v b
apXY fs v = {v|x = fs.x v.x, y = fs.y v.y}


{-| Apply a 3d vector of functions to a 3d vector of arguments -}
apXYZ : HasXYZ v (a -> b) -> HasXYZ v a -> HasXYZ v b
apXYZ fs v = {v|x = fs.x v.x, y = fs.y v.y, z = fs.z v.z}
