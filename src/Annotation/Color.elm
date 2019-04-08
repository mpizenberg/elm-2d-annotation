module Annotation.Color exposing
    ( Color, rgb, rgba
    , beige, green, turquoise, blue, darkBlue
    , Palette, defaultPalette
    , toString
    )

{-| Helper Color module.


# Build a color

@docs Color, rgb, rgba


# Predefined colors

@docs beige, green, turquoise, blue, darkBlue


# Color palettes

@docs Palette, defaultPalette


# String representation

@docs toString

-}


{-| A simple color type.
`red`, `green` and `blue` fields are integer values in 0-255.
`alpha` is the opacity, a float between 0.0 (transparent) and 1.0 (opaque).
-}
type alias Color =
    { red : Int
    , green : Int
    , blue : Int
    , alpha : Float
    }


{-| Build color from red, green, blue values.
Alpha is set to 1.0 by default.
-}
rgb : Int -> Int -> Int -> Color
rgb r g b =
    { red = r
    , green = g
    , blue = b
    , alpha = 1.0
    }


{-| Build color from red, green, blue and alpha values.
-}
rgba : Int -> Int -> Int -> Float -> Color
rgba =
    Color


{-| Convert a color to its string representation.
Useful for CSS and SVG attributes.
-}
toString : Color -> String
toString color =
    String.concat
        [ "rgba("
        , String.fromInt color.red
        , ","
        , String.fromInt color.green
        , ","
        , String.fromInt color.blue
        , ","
        , String.fromFloat color.alpha
        , ")"
        ]



-- PREDEFINED COLORS #################################################


{-| Beige.
-}
beige : Color
beige =
    rgb 255 255 204


{-| Green.
-}
green : Color
green =
    rgb 161 218 180


{-| Turquoise.
-}
turquoise : Color
turquoise =
    rgb 65 182 196


{-| Blue.
-}
blue : Color
blue =
    rgb 44 127 184


{-| Dark blue.
-}
darkBlue : Color
darkBlue =
    rgb 37 52 148



-- COLOR PALETTES ####################################################


{-| A color palette type containing 5 colors.
-}
type alias Palette =
    { one : Color
    , two : Color
    , three : Color
    , four : Color
    , five : Color
    }


{-| A color palette print and color-blind friendly.

( beige, green, turquoise, blue, dark blue )

-}
defaultPalette : Palette
defaultPalette =
    Palette beige green turquoise blue darkBlue
