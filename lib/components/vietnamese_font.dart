import 'dart:convert';

class Font{
  String vifont(String str) {
    String str1 = str ?? '';

    return utf8.decode(str1.runes.toList());
  }
}