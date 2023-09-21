import 'package:flutter_riverpod/flutter_riverpod.dart';

// class LogMessage {
//   final String originalFile;
//   final String xmlFile;
//   final String done;
//
//   LogMessage(
//       {required this.originalFile, required this.xmlFile, required this.done});
// }

class LogNotifier extends StateNotifier<List<String>> {
  LogNotifier() : super([]);

  void addMessage(String message) {
    state = [...state, message];
  }

  void resetLog() {
    state = [];
  }
}

final logProvider =
    StateNotifierProvider<LogNotifier, List<String>>((ref) => LogNotifier());
