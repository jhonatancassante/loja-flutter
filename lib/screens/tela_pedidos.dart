import 'package:flutter/material.dart';
import 'package:loja_flutter/components/app_drawer.dart';
import 'package:loja_flutter/components/pedido.dart';
import 'package:loja_flutter/models/lista_pedido.dart';
import 'package:provider/provider.dart';

class TelaPedidos extends StatelessWidget {
  const TelaPedidos({super.key});

  @override
  Widget build(BuildContext context) {
    final ListaPedido pedidos = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Pedidos'),
      ),
      drawer: const AppDrawer(),
      body: ListView.builder(
        itemCount: pedidos.contagemItens,
        itemBuilder: (ctx, i) => PedidoWidget(
          pedido: pedidos.itens[i],
        ),
      ),
    );
  }
}
