import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iscope_downloader/features/home/domain/usecases/download_and_create_xml_usecase.dart';

class DataSourceNotifier extends StateNotifier<DataSources> {
  DataSourceNotifier() : super(DataSources.excel);

  void setDataSource(DataSources newSource) {
    if (newSource != state) state = newSource;
  }
}

final dataSourceProvider =
    StateNotifierProvider<DataSourceNotifier, DataSources>(
        (ref) => DataSourceNotifier());
