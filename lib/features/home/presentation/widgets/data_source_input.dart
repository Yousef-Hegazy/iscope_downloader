import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iscope_downloader/features/home/domain/usecases/download_and_create_xml_usecase.dart';
import 'package:iscope_downloader/features/home/presentation/providers/data_source_provider.dart';

class DataSourceInput extends ConsumerWidget {
  const DataSourceInput({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: 200,
      child: DropdownButtonFormField(
        dropdownColor: Colors.white,
        focusColor: Colors.transparent,
        value: ref.watch(dataSourceProvider),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        decoration: const InputDecoration(
          hintTextDirection: TextDirection.rtl,
          labelText: "اختر مصدر بيانات الوثائق",
          contentPadding: EdgeInsets.only(left: 16, right: 16, top: 40),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
        items: const [
          DropdownMenuItem(
            value: DataSources.excel,
            child: Row(
              children: [
                Text("ملف اكسيل"),
                SizedBox(
                  width: 20,
                ),
                Icon(Icons.file_open_outlined),
              ],
            ),
          ),
          DropdownMenuItem(
            value: DataSources.database,
            child: Row(
              children: [
                Text("قاعدة البيانات"),
                SizedBox(
                  width: 20,
                ),
                Icon(Icons.youtube_searched_for_rounded),
              ],
            ),
          ),
        ],
        onChanged: (value) {
          ref.read(dataSourceProvider.notifier).setDataSource(value!);
        },
      ),
    );
  }
}
