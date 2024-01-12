import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../data/dados_ficticios.dart';
import '../models/produto.dart';

class ListaProduto with ChangeNotifier {
  final List<Produto> _itens = produtosFicticios;
  // final _urlBase = 'https://aulas-fluter1-default-rtdb.firebaseio.com/';
  final _urlBase = 'https://aulas-flutter-shop-default-rtdb.firebaseio.com';

  List<Produto> get itens => [..._itens];

  List<Produto> get itensFavorito => _itens
      .where(
        (element) => element.eFavorito,
      )
      .toList();

  Future<void> salvarProduto(Map<String, Object> dados) async {
    bool temId = dados['id'] != null;

    final produto = Produto(
      id: temId ? dados['id'] as String : Random().nextDouble().toString(),
      nome: dados['nome'] as String,
      descricao: dados['descricao'] as String,
      preco: dados['preco'] as double,
      imagemUrl: dados['imagemUrl'] as String,
    );

    if (temId) {
      await atualizarProduto(produto);
    } else {
      await adicionarProduto(produto);
    }

    notifyListeners();
  }

  Future<void> adicionarProduto(Produto produto) async {
    Response resposta = await post(
      Uri.parse('$_urlBase/produtosTeste.json'),
      body: jsonEncode(
        {
          "nome": produto.nome,
          "descricao": produto.descricao,
          "preco": produto.preco,
          "imagemUrl": produto.imagemUrl,
          "eFavorito": produto.eFavorito,
        },
      ),
    );

    final id = jsonDecode(resposta.body)['name'];

    _itens.add(
      Produto(
        id: id,
        nome: produto.nome,
        descricao: produto.descricao,
        preco: produto.preco,
        imagemUrl: produto.imagemUrl,
      ),
    );
  }

  Future<void> atualizarProduto(Produto produto) {
    int index = _itens.indexWhere(
      (element) => element.id == produto.id,
    );

    if (index >= 0) {
      _itens[index] = produto;
    }

    return Future.value();
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
