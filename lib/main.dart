import 'package:flutter/material.dart';
import 'package:loja_flutter/models/carrinho.dart';
import 'package:loja_flutter/models/lista_pedido.dart';
import 'package:loja_flutter/screens/tela_carrinho.dart';
import 'package:loja_flutter/screens/tela_pedidos.dart';
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
        ChangeNotifierProvider(
          create: (_) => ListaPedido(),
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
          textTheme: tema.textTheme.copyWith(
            titleLarge: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        debugShowCheckedModeBanner: false,
        routes: {
          Rotas.home: (ctx) => const TelaGridProdutos(),
          Rotas.detalheProduto: (ctx) => const TelaDetalheProduto(),
          Rotas.carrinho: (ctx) => const TelaCarrinho(),
          Rotas.pedidos: (ctx) => const TelaPedidos(),
        },
      ),
    );
  }
}
