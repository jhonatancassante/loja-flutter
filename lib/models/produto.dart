import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loja_flutter/constants/url_base_db.dart';
import 'package:loja_flutter/errors/http_excecao.dart';

class Produto with ChangeNotifier {
  final String id;
  final String nome;
  final String descricao;
  final double preco;
  final String imagemUrl;
  bool eFavorito;

  Produto({
    required this.id,
    required this.nome,
    required this.descricao,
    required this.preco,
    required this.imagemUrl,
    this.eFavorito = false,
  });

  void _alternarFavorito() {
    eFavorito = !eFavorito;
    notifyListeners();
  }

  Future<void> alternarFavorito() async {
    _alternarFavorito();

    final resposta = await http.patch(
      Uri.parse('$urlBaseDb/produtos/$id.json'),
      body: jsonEncode({"eFavorito": eFavorito}),
    );

    if (resposta.statusCode >= 400) {
      _alternarFavorito();
      throw HttpException(
        msg: 'Não foi possível favoritar o produto.',
        statusCode: resposta.statusCode,
      );
    }
  }
}
