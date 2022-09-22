import 'package:esc_pos_utils/esc_pos_utils.dart';

class PrintColumn {
  int width;
  String text;
  PosAlign align;

  PrintColumn(
      {required this.width, required this.text, this.align = PosAlign.left});
}
