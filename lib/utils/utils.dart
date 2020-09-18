import 'dart:convert';

class Utils {
  static String chartConfigToBase64(Map config) {
    var b64codec = Base64Codec();
    return b64codec.encode(
      json.encode(config).codeUnits,
    );
  }

  static Map chartConfigFromBase64(String config) {
    var b64codec = Base64Codec();
    return json.decode(String.fromCharCodes(
      b64codec.decode(config),
    ));
  }
}