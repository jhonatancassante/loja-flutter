import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loja_flutter/configs/api_key.dart';
import 'package:loja_flutter/constants/url_base_autenticacao.dart';
import 'package:loja_flutter/errors/autenticacao_excecao.dart';

class Autenticacao with ChangeNotifier {
  Future<void> _autenticar(String email, String senha, String tipoUrl) async {
    final resposta = await http.post(
      Uri.parse('$urlBaseAutenticacao:$tipoUrl?key=$apiKey'),
      body: jsonEncode({
        'email': email,
        'password': senha,
        'returnSecureToken': true,
      }),
    );

    final body = jsonDecode(resposta.body);

    if (body['error'] != null) {
      throw AutenticacaoExcecao(body['error']['message']);
    }
  }

  Future<void> signUp(String email, String senha) async {
    return _autenticar(email, senha, 'signUp');
  }

  Future<void> signIn(String email, String senha) async {
    return _autenticar(email, senha, 'signInWithPassword');
  }
}
