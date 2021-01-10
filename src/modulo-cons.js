// https://en.wikipedia.org/wiki/Tail_call#Tail_recursion_modulo_cons
var $author$project$Main$moduloConsMap = F2(function (f, xs) {
  var tmp = _List_Cons(undefined, _List_Nil);
  var end = tmp;
  while (xs.b) {
    end.b = _List_Cons(f(xs.a), _List_Nil);
    xs = xs.b;
    end = end.b;
  }
  return tmp.b;
});

var $author$project$Main$moduloConsFilter = F2(function (f, xs) {
  var tmp = _List_Cons(undefined, _List_Nil);
  var end = tmp;
  while (xs.b) {
    if (f(xs.a)) {
      end.b = _List_Cons(xs.a, _List_Nil);
      end = end.b;  
    }
    xs = xs.b;
  }
  return tmp.b;
});
