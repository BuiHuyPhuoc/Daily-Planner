import 'package:daily_planner/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = lightMode; // Mặc định là light mode
  ThemeData get themeData => _themeData;
  int _colorSchemeIndex = 0; // Mặc định colorScheme index là 0
  bool _isDarkMode = false; // Mặc định là light mode

  ThemeProvider() {
    _loadTheme(); // Khi khởi tạo, load theme từ SharedPreferences
  }

  // Load `ThemeData` và `ColorSchemeIndex` từ `SharedPreferences`
  Future<void> _loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Kiểm tra trạng thái dark mode
    _isDarkMode = prefs.getBool('isDarkMode') ?? false;

    // Kiểm tra chỉ số `ColorScheme` nếu đang ở light mode
    if (!_isDarkMode) {
      _colorSchemeIndex = prefs.getInt('color_scheme_index') ?? 0;
      _updateTheme(); // Cập nhật theme cho light mode
    } else {
      _themeData = darkMode; // Áp dụng dark mode
    }

    notifyListeners(); // Thông báo cập nhật giao diện
  }

  // Cập nhật `ThemeData` cho light mode dựa trên `colorSchemeIndex`
  void _updateTheme() {
    _themeData = lightMode.copyWith(
      colorScheme: listColorScheme[_colorSchemeIndex],
    );
  }

  // Hàm thay đổi giữa `light mode` và `dark mode`
  void toggleTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_isDarkMode) {
      // Chuyển về light mode và lấy chỉ số `ColorScheme`
      _isDarkMode = false;
      _updateTheme();
    } else {
      // Chuyển sang dark mode
      _isDarkMode = true;
      _themeData = darkMode;
    }

    // Lưu trạng thái `isDarkMode`
    await prefs.setBool('isDarkMode', _isDarkMode);
    notifyListeners();
  }

  // Thay đổi `ColorScheme` cho light mode
  void changeColorScheme(int index) async {
    _colorSchemeIndex = index;
    _updateTheme();

    // Lưu chỉ số `ColorScheme` vào SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('color_scheme_index', index);

    notifyListeners();
  }
}
