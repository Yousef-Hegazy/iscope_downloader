import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:iscope_downloader/constants.dart';
import 'package:iscope_downloader/features/home/domain/usecases/download_and_create_xml_usecase.dart';
import 'package:iscope_downloader/features/home/presentation/providers/download_directory_provider.dart';
import 'package:iscope_downloader/features/home/presentation/providers/log_provider.dart';
import 'package:iscope_downloader/features/home/presentation/providers/projects_data_provider.dart';

class DownloadState {
  final bool loading;
  final double progress;
  final int total;

  const DownloadState({
    required this.loading,
    required this.progress,
    required this.total,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DownloadState &&
          runtimeType == other.runtimeType &&
          loading == other.loading &&
          progress == other.progress &&
          total == other.total);

  @override
  int get hashCode => loading.hashCode ^ progress.hashCode ^ total.hashCode;

  DownloadState copyWith({
    bool? loading,
    double? progress,
    int? total,
  }) {
    return DownloadState(
      loading: loading ?? this.loading,
      progress: progress ?? this.progress,
      total: total ?? this.total,
    );
  }
}

class DownloadAndCreateXmlNotifier extends StateNotifier<DownloadState> {
  DownloadAndCreateXmlNotifier(this._ref)
      : super(const DownloadState(loading: false, progress: 0, total: 1));

  final Ref _ref;

  void _increaseProgress() {
    state = state.copyWith(progress: state.progress + 1);
  }

  Future<void> downloadAndCreateXml() async {
    state = state.copyWith(loading: true, progress: 0);

    final downloadDirectory = _ref.watch(downloadDirectoryProvider);
    final logMessage = _ref.read(logProvider.notifier).addMessage;
    final projects = await _ref.read(projectsDataProvider.future);

    if (projects.isNotEmpty) state = state.copyWith(total: projects.length);

    final startDate = DateFormat('dd/MM/yyyy HH:mm:ss').format(DateTime.now());

    logMessage('$logSeparator\nStart: $startDate');

    final DownloadAndCreateXmlUseCase downloadAndCreateXmlUseCase =
        DownloadAndCreateXmlUseCase(
      downloadDirectory: downloadDirectory,
      logMessage: logMessage,
      projects: projects,
    );

    await downloadAndCreateXmlUseCase.call(increaseProgress: _increaseProgress);

    state = state.copyWith(loading: false);

    final endDate = DateFormat('dd/MM/yyyy HH:mm:ss').format(DateTime.now());

    logMessage('$logSeparator\nEnd: $endDate\n$logSeparator');
  }
}

final downloadAndCreateXmlProvider = StateNotifierProvider.autoDispose<
    DownloadAndCreateXmlNotifier, DownloadState>((ref) {
  return DownloadAndCreateXmlNotifier(ref);
});
