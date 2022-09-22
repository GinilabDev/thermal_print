import 'package:esc_pos_printer/esc_pos_printer.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/material.dart';
import 'package:thermal_print/prints/print_api.dart';
import 'package:thermal_print/prints/print_model.dart';
import 'package:thermal_print/prints/thermal_print_documents.dart';
import '../models/printer_model.dart';
import '../models/receipt_model.dart';

class ThermalPrint with ThermalPrintDocuments implements PrintApi {
  NetworkPrinter? _printer;

  @override
  Future<void> initialize() async {
    const PaperSize paper = PaperSize.mm80;
    final profile = await CapabilityProfile.load();
    _printer = NetworkPrinter(paper, profile);
  }

  Future<bool> _connectPrinter(PrinterModel printerModel) async {
    if (_printer == null) return false;
    final PosPrintResult res =
        await _printer!.connect(printerModel.ip, port: printerModel.port);
    return res == PosPrintResult.success;
  }

  @override
  Future<bool> printDirectText({
    required PrinterModel printerModel,
    required PrintModel print,
  }) async {
    bool isConnected = await _connectPrinter(printerModel);
    if (isConnected == false) return false;

    if (print.runtimeType == ReceiptModel) {
      await printRecipt(_printer!, print as ReceiptModel);
    }

    // Dispose printer
    await _disconnectPrinter();
    return true;
  }

  @override
  void printWidgetScreenshot(Widget widget) {
    print("Printer is  ${_printer != null}");
  }

  Future<void> _disconnectPrinter() async {
    await Future.delayed(const Duration(seconds: 2), () {
      _printer!.disconnect();
    });
  }
}
