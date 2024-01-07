import 'package:flutter/material.dart';
import 'package:loja_flutter/components/app_drawer.dart';
import 'package:loja_flutter/models/lista_produto.dart';
import 'package:provider/provider.dart';

class TelaProdutos extends StatelessWidget {
  const TelaProdutos({super.key});

  @override
  Widget build(BuildContext context) {
    final ListaProduto produtos = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciar produtos.'),
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: produtos.contagemItens,
          itemBuilder: (ctx, i) => Text(produtos.itens[i].nome),
        ),
      ),
    );
  }
}
