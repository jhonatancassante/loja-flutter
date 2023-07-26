import 'package:flutter/material.dart';
import '../components/item_produto.dart';
import '../data/dados_ficticios.dart';
import '../models/produto.dart';

class TelaGridProdutos extends StatelessWidget {
  TelaGridProdutos({super.key});

  final List<Produto> produtosCarregados = produtosFicticios;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha Loja'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemBuilder: (ctx, i) => ItemProduto(produto: produtosCarregados[i]),
        itemCount: produtosCarregados.length,
      ),
    );
  }
}
