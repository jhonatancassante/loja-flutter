import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loja_flutter/models/pedido.dart';
import 'package:loja_flutter/utils/formatar.dart';
import 'package:loja_flutter/utils/tamanho_linha.dart';

class PedidoWidget extends StatefulWidget {
  final Pedido pedido;
  const PedidoWidget({
    super.key,
    required this.pedido,
  });

  @override
  State<PedidoWidget> createState() => _PedidoWidgetState();
}

class _PedidoWidgetState extends State<PedidoWidget> {
  bool _expandido = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
      alignment: Alignment.topCenter,
      child: Card(
        child: Column(
          children: [
            ListTile(
              title: Text('R\$ ${Formatar.moedaCompacta(widget.pedido.total)}'),
              subtitle: Text(
                DateFormat(
                  'dd/MM/yyyy hh:mm',
                ).format(widget.pedido.data),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.expand_more),
                onPressed: () {
                  setState(() {
                    _expandido = !_expandido;
                  });
                },
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeIn,
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 4,
              ),
              height: _expandido
                  ? (tamanhoLinha(widget.pedido.produtos) + 30.0)
                  : 0,
              child: ListView(
                children: widget.pedido.produtos.map(
                  (produto) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                produto.nomeProduto,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                              ),
                            ),
                            Text(
                              '${produto.quantidade}x R\$ ${Formatar.moeda(produto.preco)}',
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                              ),
                            )
                          ],
                        ),
                        const Divider(),
                      ],
                    );
                  },
                ).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
