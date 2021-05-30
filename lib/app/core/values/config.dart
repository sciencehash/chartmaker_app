import 'package:flutter/foundation.dart';

class AppConfig {
  /// Static data (JSON files) URL
  static String staticDataURL = (kIsWeb
      ? 'https://uolia-data.shash.workers.dev/?${kDebugMode ? 'debug=&' : ''}u=https://static-data.uolia.com/v2'
      : 'https://static-data.uolia.com/v2');

  // Timeout for cache of remote json data files
  static Duration get staticDataCacheTimeout => Duration(days: 1);
}
