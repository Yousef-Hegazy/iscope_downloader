import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iscope_downloader/features/home/domain/entities/project_data_entity.dart';
import 'package:iscope_downloader/features/home/domain/usecases/download_and_create_xml_usecase.dart';
import 'package:iscope_downloader/features/home/domain/usecases/get_projects_data_usecase.dart';
import 'package:iscope_downloader/features/home/presentation/providers/data_source_provider.dart';
import 'package:iscope_downloader/features/home/presentation/providers/file_provider.dart';

final projectsDataProvider =
    FutureProvider.autoDispose<List<ProjectDataEntity>>((ref) async {
  final filePath = ref.watch(fileProvider);
  final source = ref.watch(dataSourceProvider);
  List<ProjectDataEntity> projectsData = [];

  if (source == DataSources.excel) {
    projectsData =
        await GetProjectsDataUseCase.excelFileSource(filePath: filePath);
  } else {
    projectsData = await GetProjectsDataUseCase.remoteSource();
  }

  return projectsData;
});
