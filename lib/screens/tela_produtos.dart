import 'package:flutter/material.dart';
import 'package:loja_flutter/components/app_drawer.dart';
import 'package:loja_flutter/components/item_produto.dart';
import 'package:loja_flutter/models/lista_produto.dart';
import 'package:loja_flutter/utils/rotas.dart';
import 'package:provider/provider.dart';

class TelaProdutos extends StatelessWidget {
  const TelaProdutos({super.key});

  @override
  Widget build(BuildContext context) {
    final ListaProduto produtos = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciar Produtos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(Rotas.formularioProduto);
            },
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: produtos.contagemItens,
          itemBuilder: (ctx, i) => Column(
            children: [
              ItemProduto(produtos.itens[i]),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
