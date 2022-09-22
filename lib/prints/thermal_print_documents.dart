import 'package:esc_pos_printer/esc_pos_printer.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:thermal_print/prints/helper/esc_pos_print.dart';
import '../models/print_column.dart';
import '../models/receipt_model.dart';

mixin ThermalPrintDocuments {
  Future<void> printRecipt(NetworkPrinter printer, ReceiptModel receipt) async {
    EscPosPrint pos = EscPosPrint(printer);

    // Restaurant Info
    pos.printText(receipt.restaurantName, styles: pos.titleStyle);
    pos.printText(receipt.address, styles: pos.subTitleStyle);
    pos.printText(receipt.mobile, styles: pos.subTitleStyle);
    printer.hr();

    // Order Info
    pos.printText(receipt.orderType, styles: pos.subTitleStyle);
    pos.printText(receipt.deliveryTime,
        styles: pos.subTitleStyle.copyWith(bold: true));
    printer.hr();

    // Customer Info
    pos.printText(receipt.customerName);
    pos.printText(receipt.deliveryAddress);
    printer.hr();

    // Items
    for (var item in receipt.items) {
      pos.printItem(item, styles: pos.itemStyle);
      printer.hr();
    }
    printer.hr();

    // Footer like discount etc.
    for (var footer in receipt.footer) {
      pos.printFooter(footer, styles: pos.footerStyle);
    }
    printer.hr();
    printer.hr();

    // Total
    pos.makeRow(
      [
        PrintColumn(width: 2, text: receipt.printTime, align: PosAlign.center),
        PrintColumn(width: 7, text: "TOTAL", align: PosAlign.left),
        PrintColumn(
            width: 3,
            text: receipt.totalAmount.toStringAsFixed(2),
            align: PosAlign.right),
      ],
      styles: pos.totalStyle,
      // containsChinese: containsChinese,
      // linesAfter: linesAfter,
      // maxCharsPerLine: maxCharsPerLine,
    );
    printer.hr();

    // Last footer
    if (receipt.paymentMethod != null) {
      pos.printText("Paid by ${receipt.paymentMethod}",
          styles: pos.lastFooterStyle);
    }
    printer.hr();
    pos.printText(receipt.note, styles: pos.lastFooterStyle);
    printer.hr();
    pos.printText("Thank you", styles: pos.lastFooterStyle);
  }
}
