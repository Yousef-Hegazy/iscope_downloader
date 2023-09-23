import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iscope_downloader/features/home/domain/entities/project_data_entity.dart';
import 'package:iscope_downloader/features/home/domain/usecases/get_projects_data_usecase.dart';
import 'package:iscope_downloader/features/home/presentation/providers/file_provider.dart';

final projectsDataProvider =
    FutureProvider<List<ProjectDataEntity>>((ref) async {
  final filePath = ref.watch(fileProvider);

  if (filePath == null || filePath.isEmpty) return [];

  final projectsData =
      await GetProjectsDataUseCase.excelFileSource(filePath: filePath);

  if (projectsData == null) return [];

  return projectsData;
});
