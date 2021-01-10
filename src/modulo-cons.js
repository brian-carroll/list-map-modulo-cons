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

var $author$project$Main$moduloConsMap2 = F3(function (f, xs, ys) {
  var tmp = _List_Cons(undefined, _List_Nil);
  var end = tmp;
  while (xs.b && ys.b) {
    end.b = _List_Cons(A2(f, xs.a, ys.a), _List_Nil);
    end = end.b;
    xs = xs.b;
    ys = ys.b;
  }
  return tmp.b;
});

var $author$project$Main$moduloConsIndexedMap = F2(function (f, xs) {
  var tmp = _List_Cons(undefined, _List_Nil);
  var end = tmp;
  for (var i = 0; xs.b; i++) {
    end.b = _List_Cons(A2(f, i, xs.a), _List_Nil);
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

var $author$project$Main$moduloConsAppend = F2(function (xs, ys) {
  if (!xs.b) {
    return ys;
  }
  var tmp = _List_Cons(undefined, _List_Nil);
  var end = tmp;
  while (xs.b) {
    end.b = _List_Cons(xs.a, _List_Nil);
    end = end.b;
    xs = xs.b;
  }
  end.b = ys;

  return tmp.b;
});

var $author$project$Main$moduloConsConcat = function (lists) {
  var tmp = _List_Cons(undefined, _List_Nil);
  var end = tmp;
  if (!lists.b) {
    return _List_Nil;
  }
  if (!lists.b.b) {
    return lists.a;
  }
  for (; lists.b.b; lists = lists.b) {
    var xs = lists.a;
    while (xs.b) {
      end.b = _List_Cons(xs.a, _List_Nil);
      end = end.b;
      xs = xs.b;
    }
  }
  end.b = lists;

  return tmp.b;
};

var $author$project$Main$moduloConsIntersperse = F2(function (sep, xs) {
  if (!xs.b) {
    return xs;
  }
  var tmp = _List_Cons(undefined, _List_Nil);
  var end = tmp;

  end.b = _List_Cons(xs.a, _List_Nil);
  end = end.b;
  xs = xs.b;

  while (xs.b) {
    var valNode = _List_Cons(xs.a, _List_Nil);
    var sepNode = _List_Cons(sep, valNode);
    end.b = sepNode;
    end = valNode;
    xs = xs.b;
  }

  return tmp.b;
});
