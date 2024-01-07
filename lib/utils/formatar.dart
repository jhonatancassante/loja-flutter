import 'package:intl/intl.dart';

class Formatar {
  static Function moeda = (valor) => NumberFormat.currency(
        locale: "pt_br",
        symbol: "",
        decimalDigits: 2,
      ).format(valor);

  static Function moedaCompacta = (valor) => valor >= 10000
      ? NumberFormat.compactCurrency(
          locale: "pt_br",
          symbol: "",
          decimalDigits: 2,
        ).format(valor)
      : moeda(valor);

  static Function numeroCompacto = (valor) => NumberFormat.compact(
        locale: "pt_br",
      ).format(valor);
}
