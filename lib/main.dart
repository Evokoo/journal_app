import 'package:flutter/material.dart';
import 'package:journal/pages/form_page.dart';
import 'package:journal/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Journal App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: MyTheme.appBar,
          cardTheme: MyTheme.card,
          floatingActionButtonTheme: MyTheme.floatingBtn),
      // home: const HomePage());
      home: const InputFormPage(),
    );
  }
}

class MyTheme {
  static Color primary = Colors.teal.shade600;

  MyTheme();

  static AppBarTheme get appBar {
    return AppBarTheme(
        centerTitle: true,
        backgroundColor: MyTheme.primary,
        foregroundColor: Colors.white,
        titleTextStyle:
            const TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
        iconTheme: const IconThemeData(color: Colors.white, size: 35));
  }

  static CardTheme get card {
    return const CardTheme(margin: EdgeInsets.all(5), elevation: 0);
  }

  static FloatingActionButtonThemeData get floatingBtn {
    return FloatingActionButtonThemeData(
        backgroundColor: MyTheme.primary,
        foregroundColor: Colors.white,
        elevation: 5,
        shape: const CircleBorder(),
        iconSize: 35);
  }
}
