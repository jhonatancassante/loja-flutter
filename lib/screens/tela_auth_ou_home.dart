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

    return autenticacao.estaAutenticado
        ? const TelaGridProdutos()
        : const TelaAutenticacao();
  }
}
