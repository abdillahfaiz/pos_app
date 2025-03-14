import 'package:intl/intl.dart';

class CurrencyFormatter {
  static String formatIDR(int value) {
    //Template untuk format yang mau kita format
    var formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    );

    //Tampung hasil format
    var result = formatter.format(value);

    return result;
  }

  static String formatUSD(int value) {
    //Template untuk format yang mau kita format
    var formatter = NumberFormat.currency(
      locale: 'en_US',
      symbol: '\$',
      decimalDigits: 0,
    );

    //Tampung hasil format
    var result = formatter.format(value);

    return result;
  }
}
