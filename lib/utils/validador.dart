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
}
