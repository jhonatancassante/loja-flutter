import 'package:flutter/material.dart';

class TelaFormularioProduto extends StatefulWidget {
  const TelaFormularioProduto({super.key});

  @override
  State<TelaFormularioProduto> createState() => _TelaFormularioProdutoState();
}

class _TelaFormularioProdutoState extends State<TelaFormularioProduto> {
  final _focoPreco = FocusNode();
  final _focoDescricao = FocusNode();
  final _focoUrlImagem = FocusNode();
  final _controladorImagemUrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _focoUrlImagem.addListener(atualizarImagem);
  }

  @override
  void dispose() {
    super.dispose();
    _focoPreco.dispose();
    _focoDescricao.dispose();
    _focoUrlImagem.dispose();
    _focoUrlImagem.removeListener(atualizarImagem);
  }

  void atualizarImagem() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário de Produto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Nome',
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_focoPreco);
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Preço',
                ),
                textInputAction: TextInputAction.next,
                focusNode: _focoPreco,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_focoDescricao);
                },
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Descrição',
                ),
                focusNode: _focoDescricao,
                keyboardType: TextInputType.multiline,
                maxLines: 3,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'URL da Imagem',
                      ),
                      focusNode: _focoUrlImagem,
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _controladorImagemUrl,
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 100,
                    margin: const EdgeInsets.only(
                      top: 10,
                      left: 10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: _controladorImagemUrl.text.isEmpty
                        ? const Text(
                            'Informe a URL...',
                            textAlign: TextAlign.center,
                          )
                        : FittedBox(
                            fit: BoxFit.cover,
                            child: Image.network(_controladorImagemUrl.text),
                          ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
