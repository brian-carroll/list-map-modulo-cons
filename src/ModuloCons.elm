module ModuloCons exposing (..)

{-
   These are not the _real_ functions. Those are implemented in JavaScript!
   But I need something to stand in for them in Elm-land. Otherwise there's
   no way to compile the benchmarks and tests.
   After compiling, I can overwrite them in the JavaScript file.
   It's just a matter of finding `var`s with names like $author$project$ModuloCons$map
-}


map =
    List.map


map2 =
    List.map2


indexedMap =
    List.indexedMap


filter =
    List.filter


append =
    List.append


concat =
    List.concat


intersperse =
    List.intersperse


partition =
    List.partition


unzip =
    List.unzip
