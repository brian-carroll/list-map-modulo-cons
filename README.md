# A faster `List.map` for Elm

There's an old LISP trick from the 70's called ["tail recursion modulo cons"](https://en.wikipedia.org/wiki/Tail_call#Tail_recursion_modulo_cons) that allows you to optimise some linked-list functions that are "not quite" tail recursive. "Not quite" in this case means they do a "cons" before the tail call. The trick allows you to get around that and turn it into a while loop as the compiler does for proper tail recursive functions.

[jreusch mentioned this](https://discourse.elm-lang.org/t/elm-core-libs-in-webassembly/4443/11) to me once in the comments of a post about [my Elm in WebAssembly project](https://github.com/brian-carroll/elm_c_wasm/) over a year ago now.

Recently I was writing a function a bit like `List.map` as part of my project, remembered the comment, and tried out the technique. Then I got curious and decided to benchmark it against the [core List.map](https://package.elm-lang.org/packages/elm/core/latest/List#map) and see what happened. Well... good things happened!

| length | Core ns/cell | Modulo Cons ns/cell |
| ------ | ------------ | ------------------- |
| 10     | 74.5         | 11.3                |
| 100    | 63.3         | 8.5                 |
| 1000   | 65.1         | 8.4                 |
| 10000  | 75.2         | 9.8                 |
| 20000  | 85.0         | 11.4                |
| 50000  | 100.0        | 16.5                |

![Chart of benchmark results](./docs/chart.png)

## Generality

Rhe optimisation works for all of the core List functions that are currently based on `foldr`, which is quite a few of them:

- `List.map`
- `List.indexedMap`
- `List.filter`
- `List.append`
- `List.concat`
- `List.intersperse`
- `List.partition`
- `List.unzip`

However the `foldr` function itself seems to be too general. This optimisation relies on knowing the constructor for the return type.

`List.partition` and `List.unzip` each return a tuple of lists rather than a single list, but it should be easy to extend the optimisation to cover that case.

## Running the benchmarks

Edit with the [Elm Benchmark](https://package.elm-lang.org/packages/elm-explorations/benchmark/latest) code till you're happy with it. Then do this:

```bash
elm make src/Benchmarks.elm --output dist/benchmarks.html
``` 

Now open benchmarks.html in an editor and find this variable definition
```js
var $author$project$Main$main = $elm_explorations$benchmark$Benchmark$Runner$program($author$project$Main$suite);
```

Just _before_ this line, paste in the the code from src/modulo-cons.js

Load benchmarks.html in a browser

## Other List functions

![Benchmark results for several functions](./docs/benchmarks.png)


## Running the fuzz tests

I wrote [fuzz tests](./src/HtmlTests.elm) to find and fix bugs.

Since I had to manually edit the JavaScript, it was tricky to get the normal [elm-test](https://www.npmjs.com/package/elm-test) working. It writes the compiled files to a temporary folder and immediately runs them using Node.js. So there's no time to hack the JS.

But luckily I found a library to run Elm tests in the browser, [jgrenat/elm-html-test-runner](https://package.elm-lang.org/packages/jgrenat/elm-html-test-runner/latest/). It's not recommended due to how the files are organised, but that was fine for my case and it allowed me to easily access the JavaScript and hack away.
