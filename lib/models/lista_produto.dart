import 'dart:math';

import 'package:flutter/material.dart';
import '../data/dados_ficticios.dart';
import '../models/produto.dart';

class ListaProduto with ChangeNotifier {
  final List<Produto> _itens = produtosFicticios;

  List<Produto> get itens => [..._itens];

  List<Produto> get itensFavorito => _itens
      .where(
        (element) => element.eFavorito,
      )
      .toList();

  void salvarProduto(Map<String, Object> dados) {
    bool temId = dados['id'] != null;

    final produto = Produto(
      id: temId ? dados['id'] as String : Random().nextDouble().toString(),
      nome: dados['nome'] as String,
      descricao: dados['descricao'] as String,
      preco: dados['preco'] as double,
      imagemUrl: dados['imagemUrl'] as String,
    );

    if (temId) {
      atualizarProduto(produto);
    } else {
      adicionarProduto(produto);
    }

    notifyListeners();
  }

  void adicionarProduto(Produto produto) {
    _itens.add(produto);
  }

  void atualizarProduto(Produto produto) {
    int index = _itens.indexWhere(
      (element) => element.id == produto.id,
    );

    if (index >= 0) {
      _itens[index] = produto;
    }
  }

  void removerProduto(Produto produto) {
    int index = _itens.indexWhere(
      (element) => element.id == produto.id,
    );

    if (index >= 0) {
      _itens.removeWhere(
        (element) => element.id == produto.id,
      );
      notifyListeners();
    }
  }

  int get contagemItens {
    return _itens.length;
  }
}
