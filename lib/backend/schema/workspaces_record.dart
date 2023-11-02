import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class WorkspacesRecord extends FirestoreRecord {
  WorkspacesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "members" field.
  List<DocumentReference>? _members;
  List<DocumentReference> get members => _members ?? const [];
  bool hasMembers() => _members != null;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  void _initializeFields() {
    _members = getDataList(snapshotData['members']);
    _name = snapshotData['name'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('workspaces');

  static Stream<WorkspacesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => WorkspacesRecord.fromSnapshot(s));

  static Future<WorkspacesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => WorkspacesRecord.fromSnapshot(s));

  static WorkspacesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      WorkspacesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static WorkspacesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      WorkspacesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'WorkspacesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is WorkspacesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createWorkspacesRecordData({
  String? name,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'name': name,
    }.withoutNulls,
  );

  return firestoreData;
}

class WorkspacesRecordDocumentEquality implements Equality<WorkspacesRecord> {
  const WorkspacesRecordDocumentEquality();

  @override
  bool equals(WorkspacesRecord? e1, WorkspacesRecord? e2) {
    const listEquality = ListEquality();
    return listEquality.equals(e1?.members, e2?.members) &&
        e1?.name == e2?.name;
  }

  @override
  int hash(WorkspacesRecord? e) =>
      const ListEquality().hash([e?.members, e?.name]);

  @override
  bool isValidKey(Object? o) => o is WorkspacesRecord;
}
