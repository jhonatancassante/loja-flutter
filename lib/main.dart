import 'package:flutter/material.dart';
import 'package:loja_flutter/models/carrinho.dart';
import 'package:provider/provider.dart';
import 'models/lista_produto.dart';
import 'screens/tela_detalhe_produto.dart';
import 'screens/tela_grid_produtos.dart';
import 'utils/rotas.dart';

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

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ListaProduto(),
        ),
        ChangeNotifierProvider(
          create: (_) => Carrinho(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: tema.copyWith(
          colorScheme: tema.colorScheme.copyWith(
            primary: Colors.deepPurpleAccent[400],
            secondary: Colors.lightGreenAccent[400],
            tertiary: Colors.deepOrange,
          ),
          appBarTheme: tema.appBarTheme.copyWith(
            backgroundColor: Colors.deepPurpleAccent[400],
            foregroundColor: Colors.white,
          ),
        ),
        home: const TelaGridProdutos(),
        debugShowCheckedModeBanner: false,
        routes: {
          Rotas.detalheProduto: (ctx) => const TelaDetalheProduto(),
        },
      ),
    );
  }
}
