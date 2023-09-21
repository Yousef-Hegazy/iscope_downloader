import 'dart:io';

import 'package:excel/excel.dart' show Excel, CellIndex;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:iscope_downloader/constants.dart';
import 'package:iscope_downloader/providers/file_download_provider.dart';
import 'package:iscope_downloader/providers/file_provider.dart';
import 'package:iscope_downloader/providers/log_provider.dart';
import 'package:iscope_downloader/providers/xml_provider.dart';
import 'package:iscope_downloader/widgets/download_button.dart';
import 'package:iscope_downloader/widgets/download_progress_bar.dart';
import 'package:iscope_downloader/widgets/file_input_row.dart';
import 'package:iscope_downloader/widgets/logo_row.dart';
import 'package:iscope_downloader/widgets/progress_log.dart';
import 'package:iscope_downloader/widgets/save_log_button.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  void _handleDownloadClick(WidgetRef ref, BuildContext context) async {
    try {
      final String? filePath = ref.watch(fileProvider)?.path;

      if (filePath is String) {
        final log = ref.read(logProvider.notifier).addMessage;
        final startDate =
            DateFormat('dd/MM/yyyy HH:mm:ss').format(DateTime.now());
        final Uint8List bytes = await File(filePath).readAsBytes();
        final Excel excel = Excel.decodeBytes(bytes);
        final sheet = excel.tables['Sheet1']!;
        final columnsList =
            sheet.row(0).map((cell) => '${cell?.value}').toList();

        log('Start: $startDate\n$logSeparator');

        for (var i = 0; i < sheet.maxRows; i++) {
          if (i == 0) continue;

          final url = sheet
              .cell(CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: i))
              .value
              .toString();

          final fileName = sheet
              .cell(CellIndex.indexByColumnRow(columnIndex: 8, rowIndex: i))
              .value
              .toString();

          final Map<String, String> values = {};

          for (var j = 0; j < columnsList.length; j++) {
            values[columnsList[j]] = sheet
                .cell(CellIndex.indexByColumnRow(columnIndex: j, rowIndex: i))
                .value
                .toString();
          }

          final String directory = '${Directory.current.path}\\downloads';
          final dirExists = await Directory(directory).exists();
          if (!dirExists) {
            await Directory(directory).create(recursive: true);
          }
          final filePath = '$directory\\$fileName';
          final xmlPath = '$directory\\${fileName.split('.')[0]}.xml';

          await ref.read(xmlProvider.notifier).createAndSaveXmlProvider(
              xmlValues: values, filePath: xmlPath, log: log);

          await ref.read(fileDownloadProvider.notifier).downloadFile(
                url: url,
                filePath: filePath,
                currentPercentage: (i + 1) / sheet.maxRows,
                log: log,
              );

          debugPrint(url);
          debugPrint(fileName);
        }

        final endDate =
            DateFormat('dd/MM/yyyy HH:mm:ss').format(DateTime.now());

        log('End: $endDate');

        if (context.mounted) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog.adaptive(
                title: const Text("تم التحميل بنجاح 👍"),
                content: Text(
                    "تم تحميل الملفات في\n${Directory.current.path}\\downloads"),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text("تم"),
                  ),
                ],
              );
            },
          );
        }
      } else {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "برجاء اختيار ملف بالضغط على 'تصفح' قبل الضغط على تحميل",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onError,
              ),
            ),
            backgroundColor: Theme.of(context).colorScheme.error,
            showCloseIcon: true,
            closeIconColor: Theme.of(context).colorScheme.onError,
          ),
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _saveLog(WidgetRef ref, BuildContext context) async {
    try {
      final log = ref.read(logProvider).join('\n');
      final directory = '${Directory.current.path}\\downloads';
      if (!await Directory(directory).exists()) {
        await Directory(directory).create();
      }
      final file = File('$directory\\download-log.txt');
      await file.writeAsString(log);

      if (context.mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog.adaptive(
            title: const Text("تم الحفظ بنجاح 👍"),
            content: Text("تم حفظ سجل العمليات في\n${file.path}"),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("تم"),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        // appBar: AppBar(
        //   backgroundColor: Colors.grey.shade300,
        //   elevation: 0,
        //   title: const Text(
        //     "اداة نسخ الوثائق من نظام iScope  عن طريق تحديد ملف اكسيل يحتوى مسار الملفات بالاضافة الى انشاء ملف XML  بخصائص كل وثيقة",
        //     style: TextStyle(fontSize: 14),
        //   ),
        // ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                const LogoRow(),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Text(
                    "اداة نسخ الوثائق من نظام iScope  عن طريق تحديد ملف اكسيل يحتوى مسار الملفات بالاضافة الى انشاء ملف XML  بخصائص كل وثيقة",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 90,
                  child: FileInputRow(),
                ),
                DownloadButton(
                  onPress: ref.watch(fileDownloadProvider).loading
                      ? null
                      : () => _handleDownloadClick(ref, context),
                ),
                const SizedBox(
                  height: 25,
                ),
                const DownloadProgressBar(),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 15,
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Colors.grey.shade700,
                    ),
                    color: Colors.grey.shade700,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "سجل العمليات",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey.shade50,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      SaveLogButton(
                        onPressed: () => _saveLog(ref, context),
                      ),
                    ],
                  ),
                ),
                const ProgressLog(),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
