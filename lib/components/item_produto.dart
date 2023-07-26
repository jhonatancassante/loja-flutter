import 'package:flutter/material.dart';
import '../utils/rotas.dart';
import '../models/produto.dart';

class ItemProduto extends StatelessWidget {
  const ItemProduto({required this.produto, super.key});

  final Produto produto;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.favorite),
            color: Theme.of(context).colorScheme.secondary,
          ),
          title: Text(
            produto.nome,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.shopping_cart),
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        child: GestureDetector(
          onTap: () => Navigator.of(context).pushNamed(
            Rotas.detalheProduto,
            arguments: produto,
          ),
          child: Image.network(
            produto.imagemUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
