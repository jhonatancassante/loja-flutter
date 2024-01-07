import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/rotas.dart';
import '../models/produto.dart';
import '../models/carrinho.dart';

class GridItemProduto extends StatelessWidget {
  const GridItemProduto({super.key});

  @override
  Widget build(BuildContext context) {
    final produto = Provider.of<Produto>(
      context,
      listen: false,
    );
    final carrinho = Provider.of<Carrinho>(
      context,
      listen: false,
    );

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Produto>(
            builder: (ctx, produto, child) => IconButton(
              onPressed: produto.alternarFavorito,
              icon: produto.eFavorito
                  ? const Icon(Icons.favorite)
                  : const Icon(Icons.favorite_border),
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          title: Text(
            produto.nome,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Produto adicionado com sucesso...'),
                  duration: const Duration(seconds: 2),
                  action: SnackBarAction(
                    label: 'DESFAZER',
                    onPressed: () {
                      carrinho.removerUmItem(produto.id);
                    },
                  ),
                ),
              );
              carrinho.adicionarItem(produto);
            },
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
