import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/lista_produto.dart';
import '../models/produto.dart';
import 'item_produto.dart';

class GridProduto extends StatelessWidget {
  const GridProduto(this._filtrarFavoritos, {super.key});

  final bool _filtrarFavoritos;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ListaProduto>(context);
    final List<Produto> produtosCarregados =
        _filtrarFavoritos ? provider.itensFavorito : provider.itens;

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: produtosCarregados[i],
        child: const ItemProduto(),
      ),
      itemCount: produtosCarregados.length,
    );
  }
}
