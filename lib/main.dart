import 'package:flutter/material.dart';
import 'package:loja_flutter/models/autenticacao.dart';
import 'package:loja_flutter/models/carrinho.dart';
import 'package:loja_flutter/models/lista_pedido.dart';
import 'package:loja_flutter/screens/tela_auth_ou_home.dart';
import 'package:loja_flutter/screens/tela_carrinho.dart';
import 'package:loja_flutter/screens/tela_formulario_produto.dart';
import 'package:loja_flutter/screens/tela_pedidos.dart';
import 'package:loja_flutter/screens/tela_produtos.dart';
import 'package:provider/provider.dart';
import 'models/lista_produto.dart';
import 'screens/tela_detalhe_produto.dart';
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
          create: (_) => Autenticacao(),
        ),
        ChangeNotifierProxyProvider<Autenticacao, ListaProduto>(
          create: (_) => ListaProduto('', []),
          update: (ctx, autenticacao, anterior) => ListaProduto(
            autenticacao.token ?? '',
            anterior?.itens ?? [],
          ),
        ),
        ChangeNotifierProxyProvider<Autenticacao, ListaPedido>(
          create: (_) => ListaPedido('', []),
          update: (ctx, autenticacao, anterior) => ListaPedido(
            autenticacao.token ?? '',
            anterior?.itens ?? [],
          ),
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
          textTheme: tema.textTheme.copyWith(
            titleLarge: const TextStyle(
              color: Colors.white,
            ),
          ),
          buttonTheme: tema.buttonTheme.copyWith(
            colorScheme: tema.buttonTheme.colorScheme?.copyWith(
              background: Colors.deepPurpleAccent[400],
              surface: Colors.white,
            ),
          ),
        ),
        debugShowCheckedModeBanner: false,
        routes: {
          Rotas.authOuHome: (ctx) => const TelaAuthOuHome(),
          Rotas.detalheProduto: (ctx) => const TelaDetalheProduto(),
          Rotas.carrinho: (ctx) => const TelaCarrinho(),
          Rotas.pedidos: (ctx) => const TelaPedidos(),
          Rotas.produtos: (ctx) => const TelaProdutos(),
          Rotas.formularioProduto: (ctx) => const TelaFormularioProduto(),
        },
      ),
    );
  }
}
