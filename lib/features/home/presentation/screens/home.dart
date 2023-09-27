import 'package:flutter/material.dart';
import 'package:iscope_downloader/features/home/presentation/widgets/reset_log_button.dart';
import 'package:iscope_downloader/features/home/presentation/widgets/widgets.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GestureDetector(
        onTap: () => primaryFocus?.unfocus(),
        child: Scaffold(
          backgroundColor: Colors.grey.shade200,
          body: SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    const LogoRow(),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "اداة نسخ الوثائق من نظام iScope بالاضافة الى انشاء ملف XML  بخصائص كل وثيقة",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const FileInputRow(),
                    const SizedBox(
                      height: 20,
                    ),
                    const DownloadButton(),
                    const SizedBox(
                      height: 25,
                    ),
                    const DownloadProgressBar(),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(
                        top: 15,
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
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
                          const ResetLogButton(),
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
                          const SaveLogButton(),
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
        ),
      ),
    );
  }
}
