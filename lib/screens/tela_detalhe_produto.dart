import 'package:flutter/material.dart';
import 'package:loja_flutter/models/produto.dart';

class TelaDetalheProduto extends StatelessWidget {
  const TelaDetalheProduto({super.key});

  @override
  Widget build(BuildContext context) {
    final Produto produto =
        ModalRoute.of(context)!.settings.arguments as Produto;
    return Scaffold(
      appBar: AppBar(
        title: Text(produto.nome),
      ),
    );
  }
}
