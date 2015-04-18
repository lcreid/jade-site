window.namespace = (namespace) ->
  target = top = this
  target = target[item] or= {} for item in namespace.split(".")
  # the parent is now constructed with empty namespaces and can be used.
  # we return the outermost namespace
  return top
