module Annotation.Point exposing
    ( Point, fromCoordinates, coordinates, distance
    , encode, decoder
    )

{-| A simple point type and helper functions.


# Point manipulations.

@docs Point, fromCoordinates, coordinates, distance


# Point encoding and decoding.

@docs encode, decoder

-}

import Json.Decode as Decode exposing (Decoder)
import Json.Encode as Encode exposing (Value)


{-| Point type.
-}
type alias Point =
    { x : Float
    , y : Float
    }


{-| Create a point with the given coordinates tuple.
-}
fromCoordinates : ( Float, Float ) -> Point
fromCoordinates ( x, y ) =
    { x = x, y = y }


{-| Coordinates of a point as a tuple.
-}
coordinates : Point -> ( Float, Float )
coordinates { x, y } =
    ( x, y )


{-| Compute distance between two points.
-}
distance : Point -> Point -> Float
distance p1 p2 =
    let
        dx =
            p1.x - p2.x

        dy =
            p1.y - p2.y
    in
    sqrt (dx * dx + dy * dy)



-- ENCODING / DECODING ###############################################


{-| Encode a point into a JS value.
-}
encode : Point -> Value
encode { x, y } =
    Encode.list Encode.float [ x, y ]


{-| Decode a point from a JS value.
-}
decoder : Decoder Point
decoder =
    Decode.map2 Point
        (Decode.index 0 Decode.float)
        (Decode.index 1 Decode.float)
