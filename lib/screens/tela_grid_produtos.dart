import 'package:flutter/material.dart';

import '../components/grid_produto.dart';

class TelaGridProdutos extends StatelessWidget {
  const TelaGridProdutos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha Loja'),
      ),
      body: const GridProduto(),
    );
  }
}
