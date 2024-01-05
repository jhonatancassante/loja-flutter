import 'dart:math';

import 'package:flutter/material.dart';
import 'package:loja_flutter/models/carrinho.dart';
import 'package:loja_flutter/models/pedido.dart';

class ListaPedido with ChangeNotifier {
  List<Pedido> _itens = [];

  List<Pedido> get itens {
    return [..._itens];
  }

  int get contagemItens {
    return _itens.length;
  }

  void adicionaPedido(Carrinho carrinho) {
    _itens.insert(
      0,
      Pedido(
        id: Random().nextDouble().toString(),
        total: carrinho.total,
        data: DateTime.now(),
        produtos: carrinho.itens.values.toList(),
      ),
    );

    notifyListeners();
  }
}
