import 'package:flutter/material.dart';
import 'package:loja_flutter/components/confirmacao.dart';
import 'package:loja_flutter/models/lista_produto.dart';
import 'package:loja_flutter/models/produto.dart';
import 'package:loja_flutter/utils/rotas.dart';
import 'package:provider/provider.dart';

class ItemProduto extends StatelessWidget {
  final Produto produto;
  const ItemProduto(
    this.produto, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final msg = ScaffoldMessenger.of(context);
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(produto.imagemUrl),
      ),
      title: Text(produto.nome),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              color: Theme.of(context).colorScheme.primary,
              onPressed: () {
                Navigator.of(context).pushNamed(
                  Rotas.formularioProduto,
                  arguments: produto,
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              color: Theme.of(context).colorScheme.error,
              onPressed: () {
                confirmacao<bool>(
                  context: context,
                  title: 'Confirmar exclusão!',
                  content: 'Vocês realmente deseja excluir o produto?',
                ).then((value) async {
                  if (value ?? false) {
                    try {
                      await Provider.of<ListaProduto>(
                        context,
                        listen: false,
                      ).removerProduto(produto);
                    } catch (error) {
                      msg.showSnackBar(
                        SnackBar(
                          content: Text(
                            error.toString(),
                          ),
                        ),
                      );
                    }
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
