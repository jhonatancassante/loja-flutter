import 'package:intl/intl.dart';

class Formatar {
  static Function moeda = (valor) => NumberFormat.currency(
        locale: "pt_br",
        symbol: "",
        decimalDigits: 2,
      ).format(valor);

  static Function moedaCompacta = (valor) => NumberFormat.compactCurrency(
        locale: "pt_br",
        symbol: "",
        decimalDigits: 2,
      ).format(valor);

  static Function numeroCompacto = (valor) => NumberFormat.compact(
        locale: "pt_br",
      ).format(valor);
}
