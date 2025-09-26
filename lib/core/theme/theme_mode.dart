import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData getDarkMode() =>
    ThemeData(
        extensions: <ThemeExtension>[
          AngledCardTheme(
            color1: Color(0xFF0A1931),//light dark blue
            color2: Color(0xFF185ADB),//light blue
            color3: Colors.red,
          ),
        ],
        cardTheme: CardThemeData(color: Color(0xFF185ADB)),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF185ADB),
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
          actionsIconTheme: IconThemeData(color: Colors.white, size: 30.0),
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.black,
            statusBarIconBrightness: Brightness.light,
          ),

        ),
        scaffoldBackgroundColor: Colors.black,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF185ADB),
          selectedItemColor: Color(0xFF0A1931),
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
        ),
        textTheme: TextTheme(
          headlineLarge: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          headlineMedium: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          headlineSmall: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          titleLarge: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          titleMedium: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          bodyMedium: TextStyle(
            color: Colors.white,
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.red,
        ),
        progressIndicatorTheme: ProgressIndicatorThemeData(
            color: Color(0xFF185ADB)
        )
    );

ThemeData getLightMode() =>
    ThemeData(
        extensions: <ThemeExtension>[
          AngledCardTheme(
            color1: Colors.orange.shade700,
            color2: Colors.amber.shade600,
            color3: Colors.brown,
            //color4: Colors.blue.shade700,
          ),
        ],
        cardTheme: CardThemeData(color: Colors.amber.shade600),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.orange,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
          actionsIconTheme: IconThemeData(color: Colors.black, size: 30.0),
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
          ),
        ),
        scaffoldBackgroundColor: Colors.white,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.orange,
          selectedItemColor: Colors.orange,
          unselectedItemColor: Colors.white.withOpacity(0.8),
          type: BottomNavigationBarType.fixed,
        ),
        textTheme: TextTheme(
          headlineLarge: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          headlineMedium: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          headlineSmall: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          titleLarge: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          titleMedium: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          bodyMedium: TextStyle(
            color: Colors.black,
            fontFamily: 'Jannah',
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.blue,
        ),
        progressIndicatorTheme: ProgressIndicatorThemeData(
            color: Colors.orange
        )
    );

class AngledCardTheme extends ThemeExtension<AngledCardTheme> {
  final Color color1;
  final Color color2;
  final Color color3;
  //final Color color4;

  const AngledCardTheme({
    required this.color1,
    required this.color2,
    required this.color3,
   // required this.color4,
  });

  @override
  ThemeExtension<AngledCardTheme> copyWith({
    Color? color1,
    Color? color2,
    Color? color3,
    //Color? color4,
  }) {
    return AngledCardTheme(
        color1: color1 ?? this.color1,
        color2: color2 ?? this.color2,
        color3: color3 ?? this.color3,
       // color4: color4 ?? this.color4,
    );
  }

  @override
  ThemeExtension<AngledCardTheme> lerp(covariant ThemeExtension<AngledCardTheme>? other, double t) {
    if (other is! AngledCardTheme) {
      return this;
    }
    return AngledCardTheme(
        color1: Color.lerp(color1, other.color1, t)!,
        color2: Color.lerp(color2, other.color2, t)!,
        color3: Color.lerp(color3, other.color3, t)!,
       // color4: Color.lerp(color4, other.color4, t)!,
    );
  }

}