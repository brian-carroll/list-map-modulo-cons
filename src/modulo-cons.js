// https://en.wikipedia.org/wiki/Tail_call#Tail_recursion_modulo_cons
var $author$project$Main$map = F2(function (f, xs) {
  var tmp = _List_Cons(undefined, _List_Nil);
  var end = tmp;
  while (xs.b) {
    var next = _List_Cons(f(xs.a), _List_Nil);
    end.b = next;
    end = next;
    xs = xs.b;
  }
  return tmp.b;
});

// slower than core
var $author$project$Main$map2 = F3(function (f, xs, ys) {
  var tmp = _List_Cons(undefined, _List_Nil);
  var end = tmp;
  while (xs.b && ys.b) {
    var next = _List_Cons(A2(f, xs.a, ys.a), _List_Nil);
    end.b = next;
    end = next;
    xs = xs.b;
    ys = ys.b;
  }
  return tmp.b;
});

var $author$project$Main$indexedMap = F2(function (f, xs) {
  var tmp = _List_Cons(undefined, _List_Nil);
  var end = tmp;
  for (var i = 0; xs.b; i++) {
    var next = _List_Cons(A2(f, i, xs.a), _List_Nil);
    end.b = next;
    end = next;
    xs = xs.b;
  }
  return tmp.b;
});

var $author$project$Main$filter = F2(function (f, xs) {
  var tmp = _List_Cons(undefined, _List_Nil);
  var end = tmp;
  while (xs.b) {
    if (f(xs.a)) {
      var next = _List_Cons(xs.a, _List_Nil);
      end.b = next;
      end = next;
    }
    xs = xs.b;
  }
  return tmp.b;
});

var $author$project$Main$append = F2(function (xs, ys) {
  var tmp = _List_Cons(undefined, _List_Nil);
  var end = tmp;
  while (xs.b) {
    var next = _List_Cons(xs.a, _List_Nil);
    end.b = next;
    end = next;
    xs = xs.b;
  }
  end.b = ys;

  return tmp.b;
});

var $author$project$Main$concat = function (lists) {
  var tmp = _List_Cons(undefined, _List_Nil);
  var end = tmp;
  if (!lists.b) {
    return _List_Nil;
  }
  for (; lists.b.b; lists = lists.b) {
    var xs = lists.a;
    while (xs.b) {
      var next = _List_Cons(xs.a, _List_Nil);
      end.b = next;
      end = next;
      xs = xs.b;
    }
  }
  end.b = lists;

  return tmp.b;
};

var $author$project$Main$intersperse = F2(function (sep, xs) {
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

var $author$project$Main$partition = F2(function (f, xs) {
  var truesHead = _List_Cons(undefined, _List_Nil);
  var falsesHead = _List_Cons(undefined, _List_Nil);
  var truesEnd = truesHead;
  var falsesEnd = falsesHead;
  while (xs.b) {
    var next = _List_Cons(xs.a, _List_Nil);
    if (f(xs.a)) {
      truesEnd.b = next;
      truesEnd = next;
    } else {
      falsesEnd.b = next;
      falsesEnd = next;
    }
    xs = xs.b;
  }
  return _Utils_Tuple2(truesHead.b, falsesHead.b);
});

var $author$project$Main$unzip = function (pairs) {
  var aHead = _List_Cons(undefined, _List_Nil);
  var bHead = _List_Cons(undefined, _List_Nil);
  var aEnd = aHead;
  var bEnd = bHead;
  while (pairs.b) {
    var tuple = pairs.a;

    var aNext = _List_Cons(tuple.a, _List_Nil);
    aEnd.b = aNext;
    aEnd = aNext;

    var bNext = _List_Cons(tuple.b, _List_Nil);
    bEnd.b = bNext;
    bEnd = bNext;

    pairs = pairs.b;
  }
  return _Utils_Tuple2(aHead.b, bHead.b);
};
