import 'package:flutter/material.dart';
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
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemBuilder: (ctx, i) => Text(produtosCarregados[i].nome),
          itemCount: produtosCarregados.length,
        ),
      ),
    );
  }
}
