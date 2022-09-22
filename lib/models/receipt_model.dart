import 'package:thermal_print/models/PrintItemText.dart';
import 'package:thermal_print/models/printFooter.dart';
import 'package:thermal_print/prints/print_model.dart';

class ReceiptModel extends PrintModel {
  String restaurantName;
  String? address;
  String? mobile;
  String? orderType;
  String? deliveryTime;
  String printTime;
  List<PrintItemText> items;
  List<PrintReciptFooter> footer;
  double totalAmount;
  String? customerName;
  String? deliveryAddress;
  String? note;
  String? paymentMethod;

  ReceiptModel({
    required this.restaurantName,
    this.address,
    this.mobile,
    this.orderType,
    this.deliveryTime,
    required this.printTime,
    this.customerName,
    this.deliveryAddress,
    this.note,
    this.paymentMethod,
    List<PrintItemText>? items,
    List<PrintReciptFooter>? footer,
    required this.totalAmount,
  })  : items = items ?? [],
        footer = footer ?? [];

  static ReceiptModel demo() => ReceiptModel(
        restaurantName: "Rio Pizza",
        totalAmount: 65.65,
        address: "1 Saint Marks Road, SR4 7ED",
        mobile: "01915671010",
        printTime: "07:51 PM",
        orderType: "delivery",
        deliveryTime: "ASAP",
        customerName: "Milon",
        note: "Please make chicken spicy and hot",
        paymentMethod: "Card",
        deliveryAddress:
            "North char majlish pur, sonagazi, feni, bangladesh, SR58 S3K Tel: 01301675750",
        items: [
          PrintItemText(quantity: 1, name: "Chips + G/S", amount: 3),
          PrintItemText(quantity: 3, name: "Chips + C/S", amount: 5),
          PrintItemText(
            quantity: 1,
            name: "Chips Butty + Pizza + Pop + Garlic Sauce",
            amount: 15.65,
          ),
          PrintItemText(quantity: 2, name: "Chips", amount: 8),
        ],
        footer: [
          PrintReciptFooter(text: "Discount", amount: 7.25),
          PrintReciptFooter(text: "VAT", amount: 1.5),
        ],
      );
}
