import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iscope_downloader/constants.dart';
import 'package:xml/xml.dart';

class XmlProvider extends StateNotifier<bool> {
  XmlProvider() : super(false);

  Future<bool> createAndSaveXmlProvider({
    required Map<String, String> xmlValues,
    required String filePath,
    required Function(String message) log,
  }) async {
    try {
      final file = File(filePath);

      if (await file.exists()) {
        log('$logSeparator\n$filePath already exists');
        return true;
      }

      final XmlBuilder builder = XmlBuilder();

      xmlValues.forEach((key, value) async {
        builder.element(key, nest: () {
          if (value != null && value.isNotEmpty) {
            builder.text(value);
          }
        });
      });
      final XmlDocument xmlFile = builder.buildDocument();
      final xmlString = xmlFile.toXmlString(pretty: true);
      file.writeAsStringSync(
          "<?xml version='1.0' encoding='utf-8'?>\n<data>\n<row>$xmlString\n</row>\n</data>");
      log('$logSeparator\n$filePath Done');
      return true;
    } catch (e) {
      debugPrint(e.toString());
      log('$logSeparator\nFailed to create $filePath');
      return false;
    }
  }
}

final xmlProvider =
    StateNotifierProvider<XmlProvider, bool>((ref) => XmlProvider());
