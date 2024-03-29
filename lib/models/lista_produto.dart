import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loja_flutter/errors/http_excecao.dart';
import '../constants/url_base_db.dart';
import '../models/produto.dart';

class ListaProduto with ChangeNotifier {
  final String _token;
  final String _idUsuario;
  final List<Produto> _itens;
  final _urlProduto = '$urlBaseDb/produtos';

  List<Produto> get itens => [..._itens];

  List<Produto> get itensFavorito =>
      _itens.where((element) => element.eFavorito).toList();

  ListaProduto([
    this._token = '',
    this._idUsuario = '',
    this._itens = const [],
  ]);

  Future<void> carregarProdutos() async {
    _itens.clear();
    final resposta =
        await http.get(Uri.parse('$_urlProduto.json?auth=$_token'));

    if (resposta.body == 'null') return;

    final favResposta = await http.get(
      Uri.parse(
        '$urlBaseDb/favoritos/$_idUsuario.json?auth=$_token',
      ),
    );

    Map<String, dynamic> dadosFav =
        favResposta.body == 'null' ? {} : jsonDecode(favResposta.body);

    Map<String, dynamic> dados = jsonDecode(resposta.body);

    dados.forEach(
      (idProduto, dadosProduto) {
        final eFavorito = dadosFav[idProduto] ?? false;
        _itens.add(
          Produto(
            id: idProduto,
            nome: dadosProduto['nome'],
            descricao: dadosProduto['descricao'],
            preco: dadosProduto['preco'].toDouble(),
            imagemUrl: dadosProduto['imagemUrl'],
            eFavorito: eFavorito,
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
      Uri.parse('$_urlProduto.json?auth=$_token'),
      body: jsonEncode(
        {
          "nome": produto.nome,
          "descricao": produto.descricao,
          "preco": produto.preco,
          "imagemUrl": produto.imagemUrl,
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

  Future<void> atualizarProduto(Produto produto) async {
    int index = _itens.indexWhere(
      (element) => element.id == produto.id,
    );

    if (index >= 0) {
      await http.patch(
        Uri.parse('$_urlProduto/${produto.id}.json?auth=$_token'),
        body: jsonEncode(
          {
            "nome": produto.nome,
            "descricao": produto.descricao,
            "preco": produto.preco,
            "imagemUrl": produto.imagemUrl,
          },
        ),
      );

      _itens[index] = produto;
    }
  }

  Future<void> removerProduto(Produto produto) async {
    int index = _itens.indexWhere(
      (element) => element.id == produto.id,
    );

    if (index >= 0) {
      final produto = _itens[index];
      _itens.remove(produto);
      notifyListeners();

      final resposta = await http.delete(
        Uri.parse('$_urlProduto/${produto.id}.json?auth=$_token'),
      );

      if (resposta.statusCode >= 400) {
        _itens.insert(index, produto);
        notifyListeners();
        throw HttpException(
          msg: 'Não foi possível excluir o produto.',
          statusCode: resposta.statusCode,
        );
      }
    }
  }

  int get contagemItens {
    return _itens.length;
  }
}
