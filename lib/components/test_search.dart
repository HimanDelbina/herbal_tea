class Search {
  static dynamic search(var list, String s, [search_based_on = "plant"]) {
    var list2 = [];

    if (search_based_on == "eeee") {
      list = list.where((e) {
        if (e.task.contains(s)) {
          print("1");
          list2.add(e);
          return true;
        } else {
          print("1");
          return false;
        }
      }).toList();
    } else if (search_based_on == "nazer") {
      list = list.where((e) {
        if (e.nazer.contains(s)) {
          print("1");
          list2.add(e);
          return true;
        } else {
          print("1");
          return false;
        }
      }).toList();
    } else if (search_based_on ==
        "task_and_nazer_and_masool_and_tarifkonandaTask") {
      list2 = [];
      print('x');
      for (var i = 0; i < list.length; i++) {
        var roles = list[i].roles;

        for (var j = 0; j < roles.length; j++) {
          var x = roles[j].user;
          if (x.contains(s) && s != "") {
            list2.add(list[i]);
          }
        }
      }
    } else if (search_based_on == "plant") {
      list = list.where((e) {
        if (e.name.contains(s)) {
          // print("1");
          list2.add(e);
          return true;
        } else {
          // print("1");
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
