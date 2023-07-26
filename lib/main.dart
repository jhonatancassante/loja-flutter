import 'package:flutter/material.dart';
import 'package:loja_flutter/screens/tela_grid_produtos.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData tema = ThemeData(
      fontFamily: 'Lato',
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
    );

    return MaterialApp(
      title: 'Flutter Demo',
      theme: tema.copyWith(
        colorScheme: tema.colorScheme.copyWith(
          primary: Colors.deepPurpleAccent[400],
          secondary: Colors.lightGreenAccent[400],
        ),
        appBarTheme: tema.appBarTheme.copyWith(
          backgroundColor: Colors.deepPurpleAccent[400],
          foregroundColor: Colors.white,
          titleTextStyle: const TextStyle(
            fontFamily: 'Anton',
            fontSize: 24,
          ),
        ),
      ),
      home: TelaGridProdutos(),
      debugShowCheckedModeBanner: false,
    );
  }
}
