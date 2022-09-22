import '../enums/print_font_size.dart';
import '../enums/print_style.dart';

class PrinterModel {
  String name;
  String ip;
  int port;
  PrintStyle printStyle;
  PrintFontSize fontSize;

  PrinterModel({
    required this.name,
    required this.ip,
    this.port = 9100,
    this.printStyle = PrintStyle.receipt,
    this.fontSize = PrintFontSize.four,
  });
}
