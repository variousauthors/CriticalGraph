var Bar, Foo;

Foo = (function() {
  function Foo() {}

  Foo.prototype.bar = function() {
    return false;
  };

  return Foo;

})();

Bar = (function() {
  function Bar() {}

  Bar.prototype.foo = function() {
    return false;
  };

  return Bar;

})();

describe("Foo", function() {
  return it("it is not bar", function() {
    var v;
    v = new Foo();
    return expect(v.bar()).toEqual(false);
  });
});

describe("Bar", function() {
  return it("it is not foo", function() {
    var v;
    v = new Bar();
    return expect(v.foo()).toEqual(false);
  });
});
