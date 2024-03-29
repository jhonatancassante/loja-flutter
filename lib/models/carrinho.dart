import 'dart:math';

import 'package:flutter/material.dart';
import 'produto.dart';
import 'item_carrinho.dart';

class Carrinho with ChangeNotifier {
  Map<String, ItemCarrinho> _itens = {};

  Map<String, ItemCarrinho> get itens {
    return {..._itens};
  }

  int get contadorItens => _itens.length;

  int get contadorItensTotal {
    int contador = 0;
    _itens.forEach((key, value) {
      contador += value.quantidade;
    });
    return contador;
  }

  double get total {
    double total = 0.0;

    _itens.forEach((key, value) {
      total += value.preco * value.quantidade;
    });

    return total;
  }

  void adicionarItem(Produto produto) {
    if (_itens.containsKey(produto.id)) {
      _itens.update(
        produto.id,
        (itemExistente) => ItemCarrinho(
          id: itemExistente.id,
          idProduto: itemExistente.idProduto,
          nomeProduto: itemExistente.nomeProduto,
          quantidade: itemExistente.quantidade + 1,
          preco: itemExistente.preco,
        ),
      );
    } else {
      _itens.putIfAbsent(
        produto.id,
        () => ItemCarrinho(
          id: Random().nextDouble().toString(),
          idProduto: produto.id,
          nomeProduto: produto.nome,
          quantidade: 1,
          preco: produto.preco,
        ),
      );
    }
    notifyListeners();
  }

  void removerItem(String idProduto) {
    _itens.remove(idProduto);

    notifyListeners();
  }

  void removerUmItem(String idProduto) {
    if (!_itens.containsKey(idProduto)) return;

    if (_itens[idProduto]?.quantidade == 1) {
      _itens.remove(idProduto);
    } else {
      _itens.update(
        idProduto,
        (itemExistente) => ItemCarrinho(
          id: itemExistente.id,
          idProduto: itemExistente.idProduto,
          nomeProduto: itemExistente.nomeProduto,
          quantidade: itemExistente.quantidade - 1,
          preco: itemExistente.preco,
        ),
      );
    }
    notifyListeners();
  }

  void limpar() {
    _itens = {};

    notifyListeners();
  }
}
