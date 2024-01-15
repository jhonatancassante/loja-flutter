import 'package:flutter/material.dart';
import 'package:loja_flutter/components/app_drawer.dart';
import 'package:loja_flutter/components/pedido.dart';
import 'package:loja_flutter/models/lista_pedido.dart';
import 'package:provider/provider.dart';

import '../utils/atualiza_lista_pedidos.dart';

class TelaPedidos extends StatefulWidget {
  const TelaPedidos({super.key});

  @override
  State<TelaPedidos> createState() => _TelaPedidosState();
}

class _TelaPedidosState extends State<TelaPedidos> {
  bool _estaCarregando = true;

  @override
  void initState() {
    super.initState();
    Provider.of<ListaPedido>(
      context,
      listen: false,
    ).carregarPedidos().then((_) {
      setState(() => _estaCarregando = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final ListaPedido pedidos = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Pedidos'),
      ),
      drawer: const AppDrawer(),
      body: _estaCarregando
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () => atualizarListaPedidos(context),
              child: ListView.builder(
                itemCount: pedidos.contagemItens,
                itemBuilder: (ctx, i) => PedidoWidget(
                  pedido: pedidos.itens[i],
                ),
              ),
            ),
    );
  }
}
