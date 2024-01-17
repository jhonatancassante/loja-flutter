import 'package:flutter/material.dart';
import 'package:loja_flutter/utils/validador.dart';

enum ModoAutenticacao { signup, login }

class FormularioAutenticacao extends StatefulWidget {
  const FormularioAutenticacao({super.key});

  @override
  State<FormularioAutenticacao> createState() => _FormularioAutenticacaoState();
}

class _FormularioAutenticacaoState extends State<FormularioAutenticacao> {
  final _controladorSenha = TextEditingController();
  ModoAutenticacao _modoAutenticacao = ModoAutenticacao.login;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _estaCarregando = false;
  final Map<String, String> _dadosAutenticacao = {
    'email': '',
    'senha': '',
  };

  bool _eLogin() => _modoAutenticacao == ModoAutenticacao.login;
  bool _eSignup() => _modoAutenticacao == ModoAutenticacao.signup;

  void _trocarModo() {
    setState(() {
      _modoAutenticacao =
          _eLogin() ? ModoAutenticacao.signup : ModoAutenticacao.login;
    });
  }

  void _enviar() {
    final estaValido = _formKey.currentState?.validate() ?? false;

    if (!estaValido) return;

    setState(() => _estaCarregando = true);

    _formKey.currentState?.save();

    if (_eLogin()) {
      //Login
    } else {
      //Register
    }

    setState(() => _estaCarregando = false);
  }

  @override
  Widget build(BuildContext context) {
    final tamanhoDispositivo = MediaQuery.of(context).size;
    final temaBotao = Theme.of(context).buttonTheme.colorScheme;

    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        height: _eLogin() ? 310 : 400,
        width: tamanhoDispositivo.width * 0.75,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "E-mail",
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (email) => Validador.campoEmail(email),
                onSaved: (email) => _dadosAutenticacao['email'] = email ?? '',
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Senha",
                ),
                obscureText: true,
                controller: _controladorSenha,
                validator:
                    _eLogin() ? null : (senha) => Validador.campoSenha(senha),
                onSaved: (senha) => _dadosAutenticacao['senha'] = senha ?? '',
              ),
              if (_eSignup())
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Confirmar senha",
                  ),
                  obscureText: true,
                  validator: (senha) => Validador.campoConfirmaSenha(
                    senha,
                    _controladorSenha,
                  ),
                ),
              const SizedBox(height: 20),
              _estaCarregando
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _enviar,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: temaBotao?.background,
                        foregroundColor: temaBotao?.surface,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 8,
                        ),
                      ),
                      child: Text(
                        _eLogin() ? 'ENTRAR' : 'REGISTRAR',
                      ),
                    ),
              const Spacer(),
              TextButton(
                onPressed: _trocarModo,
                child:
                    Text(_eLogin() ? 'Deseja registrar?' : 'Já possui conta?'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
