import 'package:flutter/material.dart';
import 'package:loja_flutter/components/confirmacao.dart';
import 'package:loja_flutter/models/carrinho.dart';
import 'package:loja_flutter/models/item_carrinho.dart';
import 'package:loja_flutter/utils/formatar.dart';
import 'package:provider/provider.dart';

class ItemCarrinhoWidget extends StatelessWidget {
  const ItemCarrinhoWidget(this.itemCarrinho, {super.key});

  final ItemCarrinho itemCarrinho;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(itemCarrinho.id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Theme.of(context).colorScheme.error,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      confirmDismiss: (_) {
        return confirmacao(
          context: context,
          title: 'Tem certeza?',
          content: 'Quer realmente remover o item do carrinho?',
        );
      },
      onDismissed: (_) => Provider.of<Carrinho>(
        context,
        listen: false,
      ).removerItem(itemCarrinho.idProduto),
      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: FittedBox(
                  child: Text(
                    '${Formatar.moedaCompacta(
                      itemCarrinho.preco,
                    )}',
                  ),
                ),
              ),
            ),
            title: Text(itemCarrinho.nomeProduto),
            subtitle: Text(
              'Total: R\$ ${Formatar.moeda(
                itemCarrinho.preco * itemCarrinho.quantidade,
              )}',
            ),
            trailing: Text("${itemCarrinho.quantidade}x"),
          ),
        ),
      ),
    );
  }
}
