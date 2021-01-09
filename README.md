# A faster `List.map` for Elm

There's an old LISP trick from the 70's called ["tail recursion modulo cons"](https://en.wikipedia.org/wiki/Tail_call#Tail_recursion_modulo_cons) that allows you to optimise some linked-list functions that are "not quite" tail recursive. "Not quite" in this case means they do a "cons" before the tail call. The trick allows you to eliminate the tail call anyway.

[jreusch mentioned this](https://discourse.elm-lang.org/t/elm-core-libs-in-webassembly/4443/11) to me once in the comments of a post about [my Elm in WebAssembly project](https://github.com/brian-carroll/elm_c_wasm/) over a year ago now.

Recently I was writing a function a bit like `List.map` as part of my project, remembered the comment, and tried out the technique. Then I got curious and decided to benchmark it against the [core List.map](https://package.elm-lang.org/packages/elm/core/latest/List#map) and see what happened. Well... good things happened!

I'll raise a PR for this and see what happens.

![](./docs/chart.png)
