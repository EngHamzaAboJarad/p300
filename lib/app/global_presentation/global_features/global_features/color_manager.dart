import 'package:flutter/material.dart';

class ColorManager {
  static Color primary = HexColor.fromHex("#0C122C");
  static Color accent = HexColor.fromHex("#FFD24A");
  static Color darkGrey = HexColor.fromHex("#525252");
  static Color grey = HexColor.fromHex("#737477");
  static Color primaryOpacity70 = HexColor.fromHex("#B3ED9728");
  static Color fontColor = HexColor.fromHex("#0C122C");
  static Color shadowColor = HexColor.fromHex("#545596").withOpacity(0.2);
  static Color pink = HexColor.fromHex("#F67FB7");
  static Color yellow = HexColor.fromHex("#FFCB53");
  static Color lightYellow = HexColor.fromHex("##FFF6DB");
  static Color lightBlue = HexColor.fromHex('#CBF6FF');

  // new colors
  static Color darkPrimary = HexColor.fromHex("#d17d11");
  static Color black = HexColor.fromHex("#000000");
  static Color grey1 = HexColor.fromHex("#707070");
  static Color blue = HexColor.fromHex("#00BEE8");
  static Color grey2 = HexColor.fromHex("#797979");
  static Color white = HexColor.fromHex("#FFFFFF");
  static Color error = HexColor.fromHex("#e61f34"); //
  static Color grey3 = HexColor.fromHex('#606060');
  static Color grey4 = HexColor.fromHex('#E9E9E9');
  static Color grey5 = HexColor.fromHex('#AAAAAA');
  static Color grey6 = HexColor.fromHex('#D8D8D8');
  static Color blueAccent = HexColor.fromHex('#CBF6FF');
  static Color pinkAccent = HexColor.fromHex('#FEE4E4');
  static Color redAccent = HexColor.fromHex('#F77777');
  static Color greenAccent = HexColor.fromHex('#EBF8EE');
  static Color green = HexColor.fromHex('#00A52C');
  static Color red = HexColor.fromHex('#E60000');
  static Color gold = HexColor.fromHex('#FFF6DB');
  static Color orangeAccent = HexColor.fromHex('#FFEBDF');

  //Dark Theme
  static Color scaffoldDarkColor = HexColor.fromHex("#252525"); //
  static Color darkShadowColor = HexColor.fromHex("#1F1F1F"); //
  static Color cardDarkColor = HexColor.fromHex("#1F1F1F");
}

extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll('#', '');
    if (hexColorString.length == 6) {
      hexColorString = "FF" + hexColorString; // 8 char with opacity 100%
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}
