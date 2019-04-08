module Annotation.Line exposing
    ( Line, prependPoint
    , encode, decoder
    )

{-| A simple line type and helper functions.


# Line manipulations

@docs Line, prependPoint


# Line encoding and decoding

@docs encode, decoder

-}

import Annotation.Point as Point exposing (Point)
import Json.Decode as Decode exposing (Decoder)
import Json.Encode as Encode exposing (Value)


{-| Line type, just a list of points.
You can use all the `List` functions on it.
-}
type alias Line =
    List Point


{-| Named alias to the `(::)` operator.
-}
prependPoint : Point -> Line -> Line
prependPoint =
    (::)



-- ENCODING / DECODING ###############################################


{-| Encode a line into a JS value.
-}
encode : Line -> Value
encode line =
    Encode.list Point.encode line


{-| Decode a line from a JS value.
-}
decoder : Decoder Line
decoder =
    Decode.list Point.decoder
