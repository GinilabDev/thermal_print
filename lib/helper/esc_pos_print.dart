import 'package:esc_pos_printer/esc_pos_printer.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';

import '../enums/print_font_size.dart';
import '../models/PrintItemText.dart';
import '../models/printFooter.dart';
import '../models/print_column.dart';

class EscPosPrint {
  late NetworkPrinter printer;
  EscPosPrint(this.printer);

  final int _totalWidth = 12;

  void makeRow(
    List<PrintColumn> cols, {
    PosStyles styles = const PosStyles(),
    int linesAfter = 0,
    bool containsChinese = false,
    int? maxCharsPerLine,
  }) {
    /*
    example:
    
      PrintItemText(
        quantity: 1,
        name: "Chips Butty + Pizza + Pop + Garlic Sauce",
        amount: 15.65,
      ),

      cols = [
        PrintColumn(width: 2, text: "One number", align: PosAlign.center), // Width: 8,  characters : 10 
        PrintColumn(width: 3, text: "Chips Butty + Pizza + Pop + Garlic Sauce", align: PosAlign.left), // Width: 12, characters: 40
        PrintColumn(width: 7, text: "15.65", align: PosAlign.right), / Width: 12, characters: 5
      ],

      = Total characters = 10+40+5 = 55
      first col overflow: 2
      second col overflow: 28
      third col overflow: 0

      need 4 rows

    */

    // int totalCol = cols.length;
    int totalCharacter = 48 - (cols.length - 1);
    int singleColLength = (totalCharacter / _totalWidth).floor(); // 4

    List<String> textList = List.filled(cols.length, "");

    // Detarmine the total row
    int totalRowToInsert = 0;
    for (int i = 0; i < cols.length; i++) {
      textList[i] = cols[i].text; // Add text to text list for mutation on text

      // Insert list of string list to textRows to know the count
      int row = (cols[i].text.length / (cols[i].width * singleColLength)).ceil();
      if (row > totalRowToInsert) {
        totalRowToInsert = row;
      }
    }

    for (int x = 0; x < totalRowToInsert; x++) {
      // We will get the width of each column by this loop
      String line = "";

      for (int i = 0; i < cols.length; i++) {
        
        // Add spaces between column
        if(i>0) {line += " ";}

        String finalText = "";
        int totalCharacter = cols[i].width * singleColLength;

        if (textList[i].length > totalCharacter) {
          finalText = textList[i].substring(0, totalCharacter);
          textList[i] = textList[i].substring(totalCharacter);
        } else {
          finalText =  textList[i];
          textList[i] = "";
        }

        if (cols[i].align == PosAlign.left) {
          finalText = finalText.padRight(totalCharacter, " ");
        }
        if (cols[i].align == PosAlign.right) {
          finalText = finalText.padLeft(totalCharacter, " ");
        }
        if (cols[i].align == PosAlign.center) {
          int side = (totalCharacter / 2).floor();
          finalText = finalText.padLeft(side, " ");
          finalText = finalText.padRight(side, " ");
        }

        if(i == cols.length - 1){
          int fullLineLength = (line + finalText).length;
          if(fullLineLength < 48){   
            finalText =   finalText.padLeft(48 - line.length, " ");
          }
        }

        line += finalText;

      }

      print(line.length);

      printer.text(line,
          styles: styles,
          containsChinese: containsChinese,
          linesAfter: linesAfter,
          maxCharsPerLine: maxCharsPerLine);
    }
  }

   printItem(
    PrintItemText item, {
    PosStyles styles = const PosStyles(),
    int linesAfter = 0,
    bool containsChinese = false,
    int? maxCharsPerLine,
  }) {
    makeRow(
      [
        PrintColumn(width: 9, text: "${item.quantity.toString()} ${item.name}" , align: PosAlign.left),
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
    width: PosTextSize.size2,
    height: PosTextSize.size2,
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
