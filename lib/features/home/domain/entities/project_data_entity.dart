// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ProjectDataEntity {
  final int? projectId;
  final String? projectName;
  final String? projectCode;
  final String? contactNumber;
  final String? documentCode;
  final int? projectDocumentId;
  final String? codeOutSystemClass;
  final String? mFilePass;
  final String? documentName;
  final String? documentUrl;
  final String? documentFileName;
  final String? documentProcessStartDate;
  final String? documentProcessEndDate;
  final int? documentProcessDuration;
  final double? documentProcessCost;
  final String? codeEtimad;
  ProjectDataEntity({
    this.projectId,
    this.projectName,
    this.projectCode,
    this.contactNumber,
    this.documentCode,
    this.projectDocumentId,
    this.codeOutSystemClass,
    this.mFilePass,
    this.documentName,
    this.documentUrl,
    this.documentFileName,
    this.documentProcessStartDate,
    this.documentProcessEndDate,
    this.documentProcessDuration,
    this.documentProcessCost,
    this.codeEtimad,
  });

  ProjectDataEntity copyWith({
    int? projectId,
    String? projectName,
    String? projectCode,
    String? contactNumber,
    String? documentCode,
    int? projectDocumentId,
    String? codeOutSystemClass,
    String? mFilePass,
    String? documentName,
    String? documentUrl,
    String? documentFileName,
    String? documentProcessStartDate,
    String? documentProcessEndDate,
    int? documentProcessDuration,
    double? documentProcessCost,
    String? codeEtimad,
  }) {
    return ProjectDataEntity(
      projectId: projectId ?? this.projectId,
      projectName: projectName ?? this.projectName,
      projectCode: projectCode ?? this.projectCode,
      contactNumber: contactNumber ?? this.contactNumber,
      documentCode: documentCode ?? this.documentCode,
      projectDocumentId: projectDocumentId ?? this.projectDocumentId,
      codeOutSystemClass: codeOutSystemClass ?? this.codeOutSystemClass,
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
      codeEtimad: codeEtimad ?? this.codeEtimad,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'projectId': projectId,
      'projectName': projectName,
      'projectCode': projectCode,
      'contactNumber': contactNumber,
      'documentCode': documentCode,
      'projectDocumentId': projectDocumentId,
      'codeOutSystemClass': codeOutSystemClass,
      'mFilePass': mFilePass,
      'documentName': documentName,
      'documentUrl': documentUrl,
      'documentFileName': documentFileName,
      'documentProcessStartDate': documentProcessStartDate,
      'documentProcessEndDate': documentProcessEndDate,
      'documentProcessDuration': documentProcessDuration,
      'documentProcessCost': documentProcessCost,
      'codeEtimad': codeEtimad,
    };
  }

  factory ProjectDataEntity.fromMap(Map<String, dynamic> map) {
    return ProjectDataEntity(
      projectId: map['projectId'] != null ? map['projectId'] as int : null,
      projectName:
          map['projectName'] != null ? map['projectName'] as String : null,
      projectCode:
          map['projectCode'] != null ? map['projectCode'] as String : null,
      contactNumber:
          map['contactNumber'] != null ? map['contactNumber'] as String : null,
      documentCode:
          map['documentCode'] != null ? map['documentCode'] as String : null,
      projectDocumentId: map['projectDocumentId'] != null
          ? map['projectDocumentId'] as int
          : null,
      codeOutSystemClass: map['codeOutSystemClass'] != null
          ? map['codeOutSystemClass'] as String
          : null,
      mFilePass: map['mFilePass'] != null ? map['mFilePass'] as String : null,
      documentName:
          map['documentName'] != null ? map['documentName'] as String : null,
      documentUrl:
          map['documentUrl'] != null ? map['documentUrl'] as String : null,
      documentFileName: map['documentFileName'] != null
          ? map['documentFileName'] as String
          : null,
      documentProcessStartDate: map['documentProcessStartDate'] != null
          ? map['documentProcessStartDate'] as String
          : null,
      documentProcessEndDate: map['documentProcessEndDate'] != null
          ? map['documentProcessEndDate'] as String
          : null,
      documentProcessDuration: map['documentProcessDuration'] != null
          ? map['documentProcessDuration'] as int
          : null,
      documentProcessCost: map['documentProcessCost'] != null
          ? map['documentProcessCost'] as double
          : null,
      codeEtimad:
          map['codeEtimad'] != null ? map['codeEtimad'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProjectDataEntity.fromJson(String source) =>
      ProjectDataEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProjectDataEntity(projectId: $projectId, projectName: $projectName, projectCode: $projectCode, contactNumber: $contactNumber, documentCode: $documentCode, projectDocumentId: $projectDocumentId, codeOutSystemClass: $codeOutSystemClass, mFilePass: $mFilePass, documentName: $documentName, documentUrl: $documentUrl, documentFileName: $documentFileName, documentProcessStartDate: $documentProcessStartDate, documentProcessEndDate: $documentProcessEndDate, documentProcessDuration: $documentProcessDuration, documentProcessCost: $documentProcessCost, codeEtimad: $codeEtimad)';
  }

  @override
  bool operator ==(covariant ProjectDataEntity other) {
    if (identical(this, other)) return true;

    return other.projectId == projectId &&
        other.projectName == projectName &&
        other.projectCode == projectCode &&
        other.contactNumber == contactNumber &&
        other.documentCode == documentCode &&
        other.projectDocumentId == projectDocumentId &&
        other.codeOutSystemClass == codeOutSystemClass &&
        other.mFilePass == mFilePass &&
        other.documentName == documentName &&
        other.documentUrl == documentUrl &&
        other.documentFileName == documentFileName &&
        other.documentProcessStartDate == documentProcessStartDate &&
        other.documentProcessEndDate == documentProcessEndDate &&
        other.documentProcessDuration == documentProcessDuration &&
        other.documentProcessCost == documentProcessCost &&
        other.codeEtimad == codeEtimad;
  }

  @override
  int get hashCode {
    return projectId.hashCode ^
        projectName.hashCode ^
        projectCode.hashCode ^
        contactNumber.hashCode ^
        documentCode.hashCode ^
        projectDocumentId.hashCode ^
        codeOutSystemClass.hashCode ^
        mFilePass.hashCode ^
        documentName.hashCode ^
        documentUrl.hashCode ^
        documentFileName.hashCode ^
        documentProcessStartDate.hashCode ^
        documentProcessEndDate.hashCode ^
        documentProcessDuration.hashCode ^
        documentProcessCost.hashCode ^
        codeEtimad.hashCode;
  }
}
