import 'package:loja_flutter/models/item_carrinho.dart';

class Pedido {
  final String id;
  final double total;
  final List<ItemCarrinho> produtos;
  final DateTime data;

  Pedido({
    required this.id,
    required this.total,
    required this.produtos,
    required this.data,
  });
}
