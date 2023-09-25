class ProjectDataModel {
  final int? projectId;
  final String? projectName;
  final String? projectCode;
  final String? contactNumber;
  final String? documentCode;
  final String? mFilePass;
  final String? documentName;
  final String? documentUrl;
  final String? documentFileName;
  final String? documentProcessStartDate;
  final String? documentProcessEndDate;
  final int? documentProcessDuration;
  final double? documentProcessCost;

  const ProjectDataModel({
    required this.projectId,
    required this.projectName,
    required this.projectCode,
    required this.contactNumber,
    required this.documentCode,
    required this.mFilePass,
    required this.documentName,
    required this.documentUrl,
    required this.documentFileName,
    required this.documentProcessStartDate,
    required this.documentProcessEndDate,
    required this.documentProcessDuration,
    required this.documentProcessCost,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProjectDataModel &&
          runtimeType == other.runtimeType &&
          projectId == other.projectId &&
          projectName == other.projectName &&
          projectCode == other.projectCode &&
          contactNumber == other.contactNumber &&
          documentCode == other.documentCode &&
          mFilePass == other.mFilePass &&
          documentName == other.documentName &&
          documentUrl == other.documentUrl &&
          documentFileName == other.documentFileName &&
          documentProcessStartDate == other.documentProcessStartDate &&
          documentProcessEndDate == other.documentProcessEndDate &&
          documentProcessDuration == other.documentProcessDuration &&
          documentProcessCost == other.documentProcessCost);

  @override
  int get hashCode =>
      projectId.hashCode ^
      projectName.hashCode ^
      projectCode.hashCode ^
      contactNumber.hashCode ^
      documentCode.hashCode ^
      mFilePass.hashCode ^
      documentName.hashCode ^
      documentUrl.hashCode ^
      documentFileName.hashCode ^
      documentProcessStartDate.hashCode ^
      documentProcessEndDate.hashCode ^
      documentProcessDuration.hashCode ^
      documentProcessCost.hashCode;

  @override
  String toString() {
    return 'ProjectDataModel{ projectId: $projectId, projectName: $projectName, projectCode: $projectCode, contactNumber: $contactNumber, documentCode: $documentCode, mFilePass: $mFilePass, documentName: $documentName, documentUrl: $documentUrl, documentFileName: $documentFileName, documentProcessStartDate: $documentProcessStartDate, documentProcessEndDate: $documentProcessEndDate, documentProcessDuration: $documentProcessDuration, documentProcessCost: $documentProcessCost,}';
  }

  ProjectDataModel copyWith({
    int? projectId,
    String? projectName,
    String? projectCode,
    String? contactNumber,
    String? documentCode,
    String? mFilePass,
    String? documentName,
    String? documentUrl,
    String? documentFileName,
    String? documentProcessStartDate,
    String? documentProcessEndDate,
    int? documentProcessDuration,
    double? documentProcessCost,
  }) {
    return ProjectDataModel(
      projectId: projectId ?? this.projectId,
      projectName: projectName ?? this.projectName,
      projectCode: projectCode ?? this.projectCode,
      contactNumber: contactNumber ?? this.contactNumber,
      documentCode: documentCode ?? this.documentCode,
      mFilePass: mFilePass ?? this.mFilePass,
      documentName: documentName ?? this.documentName,
      documentUrl: documentUrl ?? this.documentUrl,
      documentFileName: documentFileName ?? this.documentFileName,
      documentProcessStartDate:
          documentProcessStartDate ?? this.documentProcessStartDate,
      documentProcessEndDate:
          documentProcessEndDate ?? this.documentProcessEndDate,
      documentProcessDuration:
          documentProcessDuration ?? this.documentProcessDuration,
      documentProcessCost: documentProcessCost ?? this.documentProcessCost,
    );
  }

  factory ProjectDataModel.fromMap(Map<String, dynamic> map) {
    return ProjectDataModel(
      projectId: map['projectId'] as int?,
      projectName: map['projectName'] as String?,
      projectCode: map['projectCode'] as String?,
      contactNumber: map['contactNumber'] as String?,
      documentCode: map['documentCode'] as String?,
      mFilePass: map['mFilePass'] as String?,
      documentName: map['documentName'] as String?,
      documentUrl: map['documentUrl'] as String?,
      documentFileName: map['documentFileName'] as String?,
      documentProcessStartDate: map['documentProcessStartDate'] ?? '',
      documentProcessEndDate: map['documentProcessEndDate'] ?? '',
      documentProcessDuration: map['documentProcessDuration'] ?? 0,
      documentProcessCost: map['documentProcessCost'] ?? 0.0,
    );
  }
}
