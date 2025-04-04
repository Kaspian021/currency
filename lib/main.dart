
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';


import 'package:teravell_app/view/home.dart';

void main() {
  runApp(const Currencyapp());
}

class Currencyapp extends StatelessWidget {
  const Currencyapp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      locale: const Locale('fa'),
      theme: ThemeData(
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontFamily: 'dana',
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
          headlineSmall: TextStyle(
            fontFamily: 'dana',
            fontSize: 14,
            fontWeight: FontWeight.w400,
            
          ),
          bodyLarge: TextStyle(
            fontFamily: 'dana',
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
          bodySmall: TextStyle(
            fontFamily: 'dana',
            fontSize: 13,
            fontWeight: FontWeight.w300,
            
          ),
          titleLarge: TextStyle(
            fontFamily: 'dana',
            fontSize: 16,
            fontWeight: FontWeight.w300,
          ),
          titleSmall: TextStyle(
            fontFamily: 'dana',
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: Colors.red,
          ),
        ),
      ),

      home: Home(),
    );
  }
}



