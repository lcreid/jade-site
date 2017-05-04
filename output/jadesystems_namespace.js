(function() {
  window.namespace = function(namespace) {
    var i, item, len, ref, target, top;
    target = top = this;
    ref = namespace.split(".");
    for (i = 0, len = ref.length; i < len; i++) {
      item = ref[i];
      target = target[item] || (target[item] = {});
    }
    return top;
  };

}).call(this);
