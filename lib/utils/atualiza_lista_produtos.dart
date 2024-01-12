import 'package:flutter/material.dart';
import 'package:loja_flutter/models/lista_produto.dart';
import 'package:provider/provider.dart';

Future<void> atualizarListaProdutos(BuildContext context) async {
  return Provider.of<ListaProduto>(
    context,
    listen: false,
  ).carregarProdutos();
}
