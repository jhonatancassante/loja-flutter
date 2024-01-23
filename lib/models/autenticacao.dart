import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loja_flutter/configs/api_key.dart';
import 'package:loja_flutter/constants/url_base_autenticacao.dart';
import 'package:loja_flutter/errors/autenticacao_excecao.dart';

class Autenticacao with ChangeNotifier {
  String? _token;
  String? _email;
  String? _idUsuario;
  DateTime? _dataExpirar;
  Timer? _signOutTimer;

  bool get estaAutenticado {
    final eValido = _dataExpirar?.isAfter(DateTime.now()) ?? false;
    return _token != null && eValido;
  }

  String? get token {
    return estaAutenticado ? _token : null;
  }

  String? get email {
    return estaAutenticado ? _email : null;
  }

  String? get idUsuario {
    return estaAutenticado ? _idUsuario : null;
  }

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
    } else {
      _token = body['idToken'];
      _email = body['email'];
      _idUsuario = body['localId'];
      _dataExpirar = DateTime.now().add(
        Duration(
          seconds: int.parse(body['expiresIn']),
        ),
      );
      _autoSignOut();
      notifyListeners();
    }
  }

  Future<void> signUp(String email, String senha) async {
    return _autenticar(email, senha, 'signUp');
  }

  Future<void> signIn(String email, String senha) async {
    return _autenticar(email, senha, 'signInWithPassword');
  }

  void signOut() {
    _token = null;
    _email = null;
    _idUsuario = null;
    _dataExpirar = null;
    _limparSignOutTimer();
    notifyListeners();
  }

  void _limparSignOutTimer() {
    _signOutTimer?.cancel();
    _signOutTimer = null;
  }

  void _autoSignOut() {
    _limparSignOutTimer();
    final tempoSingOut = _dataExpirar?.difference(DateTime.now()).inSeconds;
    _signOutTimer = Timer(
      Duration(seconds: tempoSingOut ?? 0),
      signOut,
    );
  }
}
