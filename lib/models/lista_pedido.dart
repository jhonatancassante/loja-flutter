import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loja_flutter/constants/url_base_db.dart';
import 'package:loja_flutter/models/carrinho.dart';
import 'package:loja_flutter/models/pedido.dart';

class ListaPedido with ChangeNotifier {
  final List<Pedido> _itens = [];

  List<Pedido> get itens {
    return [..._itens];
  }

  int get contagemItens {
    return _itens.length;
  }

  Future<void> adicionaPedido(Carrinho carrinho) async {
    final data = DateTime.now();
    final resposta = await http.post(
      Uri.parse('$urlBaseDb/pedidos.json'),
      body: jsonEncode(
        {
          'total': carrinho.total,
          'data': data.toIso8601String(),
          'produtos': carrinho.itens.values
              .map(
                (item) => {
                  'id': item.id,
                  'idProduto': item.idProduto,
                  'nomeProduto': item.nomeProduto,
                  'quantidade': item.quantidade,
                  'preco': item.preco,
                },
              )
              .toList(),
        },
      ),
    );
    final id = jsonDecode(resposta.body)['name'];
    _itens.insert(
      0,
      Pedido(
        id: id,
        total: carrinho.total,
        data: data,
        produtos: carrinho.itens.values.toList(),
      ),
    );

    notifyListeners();
  }
}
