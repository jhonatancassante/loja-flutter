import 'package:flutter/material.dart';
import '../data/dados_ficticios.dart';
import '../models/produto.dart';

class ListaProduto with ChangeNotifier {
  final List<Produto> _itens = produtosFicticios;

  List<Produto> get itens => [..._itens];

  void adicionarProduto(Produto produto) {
    _itens.add(produto);

    notifyListeners();
  }
}
