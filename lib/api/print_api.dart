library thermal_print;

import 'package:flutter/cupertino.dart';
import 'package:thermal_print/models/print_model.dart';
import '../models/printer_model.dart';

abstract class PrintApi {
  // Initialize printer basic settings.
  Future<void> initialize();

  void printWidgetScreenshot(Widget widget);

  Future<bool> printDirectText({
    required PrinterModel printerModel,
    required PrintModel print,
  });
}
