import 'package:flutter/material.dart';
import 'package:loja_flutter/models/autenticacao.dart';
import 'package:loja_flutter/screens/tela_autenticacao.dart';
import 'package:loja_flutter/screens/tela_grid_produtos.dart';
import 'package:provider/provider.dart';

class TelaAuthOuHome extends StatelessWidget {
  const TelaAuthOuHome({super.key});

  @override
  Widget build(BuildContext context) {
    Autenticacao autenticacao = Provider.of(context);

    return FutureBuilder(
      future: autenticacao.autoLogin(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.error != null) {
          return const Center(
            child: Text("Erro ao carregar dados"),
          );
        } else {
          return autenticacao.estaAutenticado
              ? const TelaGridProdutos()
              : const TelaAutenticacao();
        }
      },
    );
  }
}
