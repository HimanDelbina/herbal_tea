import 'package:flutter/cupertino.dart';

class MyAnimationController extends ChangeNotifier {
  int selectedBottomNavBar = 0;
  bool is_theme = false;
  bool is_plant_fav = false;
  void onButtomNavigationBarTabChange(int index) {
    selectedBottomNavBar = index;
    notifyListeners();
  }

  void updateTheme() {
    is_theme = !is_theme;
    notifyListeners();
  }

  void updateIsPlantFaviorate() {
    is_plant_fav = !is_plant_fav;
    notifyListeners();
  }
}
