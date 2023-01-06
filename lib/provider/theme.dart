import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeBloc extends ChangeNotifier {
  String? _selectedTheme = "white";
  String get selectedTheme => _selectedTheme!;

  Color _backgroundColorSplash = const Color(0xff03A760);
  Color _backgroundColor = const Color(0xfffafafa);
  Color _iconNavbarSelect = Colors.black;
  Color _iconNavbarUnSelect = Colors.grey;
  Color _iconDrawer = Colors.black;
  Color _iconItem = Colors.grey;
  Color _deleteIcon = Colors.redAccent;
  Color _text = Colors.black;
  Color _appbatTextUnselect = Colors.black;
  Color _appbatTextSelect = Colors.black;
  Color _titleText = Colors.green;
  Color _conImageItem = Colors.white;
  Color _unselectItem = Colors.grey;
  Color _selectItem = const Color(0xff03A760);
  Color _items = Colors.white;
  Color _animatedContainerToturial = const Color(0xFFA2E274);
  Color _nextBackButton = Colors.grey.withOpacity(0.1);
  Color _focusBorderSearch = Colors.blueGrey;
  Color _enableBorderSearch = Colors.black;
  Color _cursorSearch = Colors.black;

  Color get backgroundColorSplash => _backgroundColorSplash;
  Color get backgroundColor => _backgroundColor;
  Color get iconNavbarSelect => _iconNavbarSelect;
  Color get iconNavbarUnSelect => _iconNavbarUnSelect;
  Color get iconDrawer => _iconDrawer;
  Color get iconItem => _iconItem;
  Color get deleteIcon => _deleteIcon;
  Color get text => _text;
  Color get appbatTextUnselect => _appbatTextUnselect;
  Color get appbatTextSelect => _appbatTextSelect;
  Color get titleText => _titleText;
  Color get conImageItem => _conImageItem;
  Color get unselectItem => _unselectItem;
  Color get selectItem => _selectItem;
  Color get items => _items;
  Color get animatedContainerToturial => _animatedContainerToturial;
  Color get nextBackButton => _nextBackButton;
  Color get focusBorderSearch => _focusBorderSearch;
  Color get enableBorderSearch => _enableBorderSearch;
  Color get cursorSearch => _cursorSearch;

  ////////////////////////////////////////////size
  double _allPadding = 16.0;

  double get allPadding => _allPadding;

  Future<void> setTheme() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('theme_code', selectedTheme);
  }

  set counterSelected(String val) {
    _selectedTheme = val;
    notifyListeners();
  }

  defaltTheme() {
    _backgroundColorSplash = const Color(0xff03A760);
    _backgroundColor = const Color(0xfffafafa);
    _iconNavbarSelect = Colors.black;
    _iconNavbarUnSelect = Colors.grey;
    _iconDrawer = Colors.black;
    _iconItem = Colors.grey;
    _deleteIcon = Colors.redAccent;
    _text = Colors.black;
    _appbatTextUnselect = Colors.grey;
    _appbatTextSelect = Colors.black;
    _titleText = Colors.green;
    _conImageItem = Colors.white;
    _unselectItem = Colors.grey;
    _selectItem = const Color(0xff03A760);
    _items = Colors.white;
    _animatedContainerToturial = const Color(0xFFA2E274);
    _nextBackButton = Colors.grey.withOpacity(0.1);
    _focusBorderSearch = Colors.blueGrey;
    _enableBorderSearch = Colors.black;
    _cursorSearch = Colors.black;

    _selectedTheme = "white";
    setTheme();
    notifyListeners();
    change_theme_code("white");
  }

  blackTheme() {
    _backgroundColorSplash = const Color(0xff03A760);
    _backgroundColor = const Color(0xff171717);
    _iconNavbarSelect = const Color(0xff0F4C75);
    _iconNavbarUnSelect = Colors.grey;
    _iconDrawer = Colors.grey;
    _iconItem = Colors.grey;
    _deleteIcon = const Color(0xff0F4C75);
    _text = Colors.grey;
    _appbatTextUnselect = Colors.grey;
    _appbatTextSelect = const Color(0xff0F4C75);
    _titleText = Colors.green;
    _conImageItem = Colors.white;
    _unselectItem = Colors.grey;
    _selectItem = const Color(0xff03A760);
    _items = Colors.grey.withOpacity(0.1);
    _animatedContainerToturial = Colors.grey;
    _nextBackButton = const Color(0xff0F4C75);
    _focusBorderSearch = Colors.blueGrey;
    _enableBorderSearch = Colors.grey;
    _cursorSearch = Colors.grey;

    _selectedTheme = "black";
    setTheme();
    notifyListeners();
    change_theme_code("black");
  }

  paading() {
    _allPadding = 16.0;
    notifyListeners();
  }

  change_theme_code(String code) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    _pref.setString("theme_code", code);
  }
}
