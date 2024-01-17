import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loja_flutter/configs/api_key.dart';
import 'package:loja_flutter/constants/url_base_autenticacao.dart';

class Autenticacao with ChangeNotifier {
  static const _url = '$urlBaseAutenticacao:signUp?key=$apiKey';

  Future<void> signup(String email, String senha) async {
    final resposta = await http.post(
      Uri.parse(_url),
      body: jsonEncode({
        'email': email,
        'password': senha,
        'returnSecureToken': true,
      }),
    );

    print(jsonDecode(resposta.body));
  }
}
