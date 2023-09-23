class ProjectDataEntity {
  final String url;
  final String fileName;
  final Map<String, String> otherData;

  const ProjectDataEntity(
      {required this.url, required this.fileName, required this.otherData});
}
