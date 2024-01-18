import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loja_flutter/configs/api_key.dart';
import 'package:loja_flutter/constants/url_base_autenticacao.dart';

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

    print(jsonDecode(resposta.body));
  }

  Future<void> signUp(String email, String senha) async {
    _autenticar(email, senha, 'signUp');
  }

  Future<void> signIn(String email, String senha) async {
    _autenticar(email, senha, 'signInWithPassword');
  }
}
