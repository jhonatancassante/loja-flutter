import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/carrinho.dart';
import '../models/lista_pedido.dart';

class BotaoCarrinho extends StatefulWidget {
  const BotaoCarrinho({
    super.key,
    required this.carrinho,
  });

  final Carrinho carrinho;

  @override
  State<BotaoCarrinho> createState() => _BotaoCarrinhoState();
}

class _BotaoCarrinhoState extends State<BotaoCarrinho> {
  bool _estaCarregando = false;
  @override
  Widget build(BuildContext context) {
    return _estaCarregando
        ? const CircularProgressIndicator()
        : TextButton(
            onPressed: widget.carrinho.contadorItens == 0
                ? null
                : () async {
                    setState(() => _estaCarregando = true);
                    await Provider.of<ListaPedido>(
                      context,
                      listen: false,
                    ).adicionaPedido(widget.carrinho);
                    widget.carrinho.limpar();
                    setState(() => _estaCarregando = false);
                  },
            style: TextButton.styleFrom(
              textStyle: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            child: const Text('COMPRAR'),
          );
  }
}
