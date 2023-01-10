class SearchComponent {
  static dynamic search(var data, String search, [search_based_on = "plant"]) {
    var data_final = [];

    if (search_based_on == "plant") {
      data = data.where((searching) {
        if (searching.name.toLowerCase().contains(search) ||
            searching.name.toUpperCase().contains(search)) {
          data_final.add(searching);
          return true;
        } else {
          return false;
        }
      }).toList();
    }
    if (search_based_on == "herbaltea") {
      data = data.where((searching) {
        if (searching.name.toLowerCase().contains(search) ||
            searching.name.toUpperCase().contains(search)) {
          data_final.add(searching);
          return true;
        } else {
          return false;
        }
      }).toList();
    }
    if (search_based_on == "sick") {
      data = data.where((searching) {
        if (searching.name.toLowerCase().contains(search) ||
            searching.name.toUpperCase().contains(search)) {
          data_final.add(searching);
          return true;
        } else {
          return false;
        }
      }).toList();
    }
    if (search == '') {
      return data;
    }
    return data_final;
  }
}
