import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myfinance/services/db_const.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'color_scheme.dart';

part 'themes.g.dart';

@riverpod
class AppThemeMode extends _$AppThemeMode {
  @override
  ThemeMode build() {
    bool isDark = loadTheme();
    return isDark ? ThemeMode.dark : ThemeMode.light;
  }

  void toggleTheme() {
    (state == ThemeMode.light)
        ? state = ThemeMode.dark
        : state = ThemeMode.light;
    saveTheme();
  }

  bool loadTheme() {
    var themeBox = Hive.box(DBConst.themeMode);
    bool isDark = themeBox.get("isDark", defaultValue: true);
    return isDark;
  }

  void saveTheme() {
    var themeBox = Hive.box(DBConst.themeMode);
    (state == ThemeMode.dark)
        ? themeBox.put("isDark", true)
        : themeBox.put("isDark", false);
  }
}

class AppThemes {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: lightColorScheme,
    useMaterial3: true,
    pageTransitionsTheme: pageAnimation,
    drawerTheme: drawerTheme(lightColorScheme),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: darkColorScheme,
    useMaterial3: true,
    pageTransitionsTheme: pageAnimation,
    drawerTheme: drawerTheme(darkColorScheme),
  );

  static drawerTheme(ColorScheme c) => DrawerThemeData(
        scrimColor: c.primaryContainer.withOpacity(.8),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      );

  static const pageAnimation = PageTransitionsTheme(
    builders: <TargetPlatform, PageTransitionsBuilder>{
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    },
  );
}
