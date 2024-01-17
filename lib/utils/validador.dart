import 'package:flutter/material.dart';

class Validador {
  static String? campoString(String? s, int minChar) {
    final sTemp = s ?? '';

    if (sTemp.trim().isEmpty) return "Campo obrigatório.";
    if (sTemp.trim().length < minChar) {
      return "Campo deve ter no mínimo $minChar caracteres.";
    }
    return null;
  }

  static String? campoNumerico(String? num) {
    final numTemp = double.tryParse(num ?? '') ?? -1;

    if (numTemp <= 0) return "Valor inválido.";
    return null;
  }

  static String? campoUrlImagem(String? url) {
    final urlTemp = url ?? '';
    if (urlTemp.trim().isEmpty) return "Imagem é obrigatória.";

    final bool eValida = Uri.tryParse(urlTemp)?.hasAbsolutePath ?? false;
    final bool terminaComArquivo = urlTemp.toLowerCase().endsWith('jpg') ||
        urlTemp.toLowerCase().endsWith('jpeg') ||
        urlTemp.toLowerCase().endsWith('png') ||
        urlTemp.toLowerCase().endsWith('gif') ||
        urlTemp.toLowerCase().endsWith('webp');

    if (!eValida) return "A URL não é válida!";
    if (!terminaComArquivo) return "O tipo de arquivo informado não é válido.";
    return null;
  }

  static String? campoEmail(String? email) {
    final emailTemp = email ?? '';
    String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regExp = RegExp(pattern);

    if (emailTemp.trim().isEmpty) {
      return 'Campo de email vazio.';
    }

    if (!regExp.hasMatch(emailTemp)) {
      return 'E-mail inválido.';
    }

    return null;
  }

  static String? campoSenha(String? senha) {
    final senhaTemp = senha ?? '';
    String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[_%$#@])$';
    RegExp regExp = RegExp(pattern);

    if (senhaTemp.trim().isEmpty) {
      return 'Campo de senha vazio.';
    }

    if (senhaTemp.length < 8) {
      return 'Senha muito curta. Deve conter ao menos 8 dígitos.';
    }

    if (!regExp.hasMatch(senhaTemp)) {
      return '''Sua senha deve ter:
      • Pelo menos uma letra maiúscula ([A-Z])
      • Pelo menos uma letra minúscula ([a-z])
      • Pelo menos um dígito ([0-9])
      • Pelo menos um caractere especial (_%\$#@)''';
    }

    return null;
  }

  static String? campoConfirmaSenha(
    String? senha,
    TextEditingController controlador,
  ) {
    final confirmaSenha = senha ?? '';
    if (confirmaSenha != controlador.text) {
      return 'A confirmação de senha não coincide.';
    }
    return null;
  }
}
