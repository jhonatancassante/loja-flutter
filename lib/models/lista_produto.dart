import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../constants/url_base_db.dart';
import '../models/produto.dart';

class ListaProduto with ChangeNotifier {
  final List<Produto> _itens = [];
  final _urlProduto = '$urlBaseDb/produtos.json';

  List<Produto> get itens => [..._itens];

  List<Produto> get itensFavorito => _itens
      .where(
        (element) => element.eFavorito,
      )
      .toList();

  Future<void> carregarProdutos() async {
    final resposta = await http.get(Uri.parse(_urlProduto));

    if (resposta.body == 'null') return;

    Map<String, dynamic> dados = jsonDecode(resposta.body);

    dados.forEach(
      (idProduto, dadosProduto) {
        _itens.add(
          Produto(
            id: idProduto,
            nome: dadosProduto['nome'],
            descricao: dadosProduto['descricao'],
            preco: dadosProduto['preco'].toDouble(),
            imagemUrl: dadosProduto['imagemUrl'],
          ),
        );
      },
    );
    notifyListeners();
  }

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
    final resposta = await http.post(
      Uri.parse(_urlProduto),
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
