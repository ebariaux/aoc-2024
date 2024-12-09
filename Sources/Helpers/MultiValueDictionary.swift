struct MultiValueDictionary<K: Hashable, V> {
  var dict: [K: [V]] = [:]

  subscript(key: K) -> [V]? {
    get {
      return dict[key]
    }
  }

  subscript(key: K) -> V? {
    get {
      return dict[key]?.first
    }
    set {
      if let v = newValue {
        if dict[key] != nil {
          dict[key]!.append(v)
        } else {
          dict[key] = [v]
        }
      } else {
        if dict[key] != nil {
          dict.removeValue(forKey: key)
        }
      }
    }
  }
}
