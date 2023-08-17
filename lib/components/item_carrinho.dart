import 'package:flutter/material.dart';
import 'package:loja_flutter/models/item_carrinho.dart';

class ItemCarrinhoWidget extends StatelessWidget {
  const ItemCarrinhoWidget(this.itemCarrinho, {super.key});

  final ItemCarrinho itemCarrinho;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 4,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: FittedBox(
                child: Text(
                  '${itemCarrinho.preco}',
                ),
              ),
            ),
          ),
          title: Text(itemCarrinho.nomeProduto),
          subtitle: Text(
            'Total: R\$ ${itemCarrinho.preco * itemCarrinho.quantidade}',
          ),
          trailing: Text("${itemCarrinho.quantidade}x"),
        ),
      ),
    );
  }
}
