import 'package:flutter/material.dart';
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
          ),
          title: Text(
            produto.nome,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.shopping_cart),
          ),
        ),
        child: Image.network(
          produto.imagemUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
