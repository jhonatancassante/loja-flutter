import 'package:flutter/material.dart';
import 'package:loja_flutter/models/item_carrinho.dart';

class ItemCarrinhoWidget extends StatelessWidget {
  const ItemCarrinhoWidget(this.itemCarrinho, {super.key});

  final ItemCarrinho itemCarrinho;

  @override
  Widget build(BuildContext context) {
    return Text(itemCarrinho.nomeProduto);
  }
}
