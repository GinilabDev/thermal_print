import 'package:esc_pos_printer/esc_pos_printer.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';

import '../enums/print_font_size.dart';
import '../models/PrintItemText.dart';
import '../models/printFooter.dart';
import '../models/print_column.dart';

class EscPosPrint {
  late NetworkPrinter printer;
  EscPosPrint(this.printer);

  void makeRow(
    List<PrintColumn> cols, {
    PosStyles styles = const PosStyles(),
    int linesAfter = 0,
    bool containsChinese = false,
    int? maxCharsPerLine,
  }) {
    // int totalCol = cols.length;
    int singleColLength = 4;

    int totalWidth = 48;

    String textToPrint = "";

    for (var c in cols) {
      int totalCharacter = c.width * singleColLength;
      String finalText = "";

      if (c.text.length > totalCharacter) {
        finalText = c.text.substring(0, totalCharacter);
      }

      if (finalText.isEmpty) {
        if (c.align == PosAlign.left) {
          finalText = c.text.padRight(totalCharacter, " ");
        }
        if (c.align == PosAlign.right) {
          finalText = c.text.padLeft(totalCharacter, " ");
        }
        if (c.align == PosAlign.center) {
          int side = (totalCharacter / 2).floor();
          finalText = c.text.padLeft(side, " ");
          finalText = finalText.padRight(side, " ");
        }
      }

      c.text = finalText;
      textToPrint += c.text;
    }

    printer.text(textToPrint,
        styles: styles,
        containsChinese: containsChinese,
        linesAfter: linesAfter,
        maxCharsPerLine: maxCharsPerLine);
  }

  void printItem(
    PrintItemText item, {
    PosStyles styles = const PosStyles(),
    int linesAfter = 0,
    bool containsChinese = false,
    int? maxCharsPerLine,
  }) {
    makeRow(
      [
        PrintColumn(
            width: 2, text: item.quantity.toString(), align: PosAlign.center),
        PrintColumn(width: 7, text: item.name, align: PosAlign.left),
        PrintColumn(
            width: 3,
            text: item.amount.toStringAsFixed(2),
            align: PosAlign.right),
      ],
      styles: styles,
      containsChinese: containsChinese,
      linesAfter: linesAfter,
      maxCharsPerLine: maxCharsPerLine,
    );
  }

  void printFooter(
    PrintReciptFooter footer, {
    PosStyles styles = const PosStyles(),
    int linesAfter = 0,
    bool containsChinese = false,
    int? maxCharsPerLine,
  }) {
    makeRow(
      [
        PrintColumn(width: 9, text: footer.text, align: PosAlign.left),
        PrintColumn(
            width: 3,
            text: footer.amount.toStringAsFixed(2),
            align: PosAlign.right),
      ],
      styles: styles,
      containsChinese: containsChinese,
      linesAfter: linesAfter,
      maxCharsPerLine: maxCharsPerLine,
    );
  }

  void printText(
    String? text, {
    PosStyles styles = const PosStyles(),
    int linesAfter = 0,
    bool containsChinese = false,
    int? maxCharsPerLine,
  }) {
    if (text == null || text.isEmpty) return;
    printer.text(
      text,
      styles: styles,
      linesAfter: linesAfter,
      containsChinese: containsChinese,
      maxCharsPerLine: maxCharsPerLine,
    );
  }

  final PosStyles titleStyle = const PosStyles(
    align: PosAlign.center,
    bold: true,
  );

  final PosStyles subTitleStyle = const PosStyles(
    align: PosAlign.center,
  );

  final PosStyles itemStyle = const PosStyles(
    align: PosAlign.center,
  );

  final PosStyles footerStyle = const PosStyles(
    align: PosAlign.center,
  );

  final PosStyles totalStyle = const PosStyles(
    align: PosAlign.center,
    bold: true,
  );

  final PosStyles lastFooterStyle = const PosStyles(
    align: PosAlign.center,
    bold: true,
  );

  PosStyles size(PosStyles style, PrintFontSize size) {
    switch (size) {
      case PrintFontSize.one:
        return style.copyWith(
          // height: PosTextSize.size1,
          width: PosTextSize.size1,
        );
      case PrintFontSize.two:
        return style.copyWith(
          // height: PosTextSize.size2,
          width: PosTextSize.size2,
        );
      case PrintFontSize.three:
        return style.copyWith(
          // height: PosTextSize.size3,
          width: PosTextSize.size3,
        );
      case PrintFontSize.four:
        return style.copyWith(
          // height: PosTextSize.size4,
          width: PosTextSize.size4,
        );
      case PrintFontSize.five:
        return style.copyWith(
          // height: PosTextSize.size5,
          width: PosTextSize.size5,
        );
      case PrintFontSize.six:
        return style.copyWith(
          // height: PosTextSize.size6,
          width: PosTextSize.size6,
        );
      case PrintFontSize.seven:
        return style.copyWith(
          // height: PosTextSize.size7,
          width: PosTextSize.size7,
        );
      case PrintFontSize.eight:
        return style.copyWith(
          // height: PosTextSize.size8,
          width: PosTextSize.size8,
        );
      default:
        return style.copyWith(
          // height: PosTextSize.size1,
          width: PosTextSize.size1,
        );
    }
  }
}
