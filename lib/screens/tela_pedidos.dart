import 'package:flutter/material.dart';
import 'package:loja_flutter/components/app_drawer.dart';
import 'package:loja_flutter/components/pedido.dart';
import 'package:loja_flutter/models/lista_pedido.dart';
import 'package:provider/provider.dart';

import '../utils/atualiza_lista_pedidos.dart';

class TelaPedidos extends StatelessWidget {
  const TelaPedidos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Pedidos'),
      ),
      drawer: const AppDrawer(),
      body: FutureBuilder(
        future: Provider.of<ListaPedido>(
          context,
          listen: false,
        ).carregarPedidos(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.error != null) {
            return const Center(
              child: Text('Ocorreu um erro ao carregar a lista de produtos.'),
            );
          } else {
            return RefreshIndicator(
              onRefresh: () => atualizarListaPedidos(context),
              child: Consumer<ListaPedido>(
                builder: (ctx, pedidos, child) => ListView.builder(
                  itemCount: pedidos.contagemItens,
                  itemBuilder: (ctx, i) => PedidoWidget(
                    pedido: pedidos.itens[i],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
