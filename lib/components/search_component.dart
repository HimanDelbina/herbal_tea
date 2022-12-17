class SearchComponent {
  static dynamic search(var list, String s, [search_based_on = "name"]) {
    var list2 = [];

    if (search_based_on == "name") {
      list = list.where((e) {
        if (e.name.toLowerCase().contains(s) ||
            e.name.toUpperCase().contains(s)) {
          list2.add(e);
          return true;
        } else {
          return false;
        }
      }).toList();
    }
    if (s == '') {
      return list;
    }
    return list2;
  }
}
