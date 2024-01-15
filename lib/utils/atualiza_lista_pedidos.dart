import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/lista_pedido.dart';

Future<void> atualizarListaPedidos(BuildContext context) async {
  return Provider.of<ListaPedido>(
    context,
    listen: false,
  ).carregarPedidos();
}
