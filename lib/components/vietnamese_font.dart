import 'dart:convert';

class Font{
  String vFont(String str) {
    String str1 = str ?? '';

    return utf8.decode(str1.runes.toList());
  }
}