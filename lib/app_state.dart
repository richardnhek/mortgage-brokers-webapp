import 'package:flutter/material.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {}

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  DocumentReference? _currentChatRef;
  DocumentReference? get currentChatRef => _currentChatRef;
  set currentChatRef(DocumentReference? _value) {
    _currentChatRef = _value;
  }

  DocumentReference? _currentChatUserRef;
  DocumentReference? get currentChatUserRef => _currentChatUserRef;
  set currentChatUserRef(DocumentReference? _value) {
    _currentChatUserRef = _value;
  }

  String _currentMainView = '';
  String get currentMainView => _currentMainView;
  set currentMainView(String _value) {
    _currentMainView = _value;
  }

  List<DocumentReference> _selectedMembers = [];
  List<DocumentReference> get selectedMembers => _selectedMembers;
  set selectedMembers(List<DocumentReference> _value) {
    _selectedMembers = _value;
  }

  void addToSelectedMembers(DocumentReference _value) {
    _selectedMembers.add(_value);
  }

  void removeFromSelectedMembers(DocumentReference _value) {
    _selectedMembers.remove(_value);
  }

  void removeAtIndexFromSelectedMembers(int _index) {
    _selectedMembers.removeAt(_index);
  }

  void updateSelectedMembersAtIndex(
    int _index,
    DocumentReference Function(DocumentReference) updateFn,
  ) {
    _selectedMembers[_index] = updateFn(_selectedMembers[_index]);
  }

  void insertAtIndexInSelectedMembers(int _index, DocumentReference _value) {
    _selectedMembers.insert(_index, _value);
  }
}

LatLng? _latLngFromString(String? val) {
  if (val == null) {
    return null;
  }
  final split = val.split(',');
  final lat = double.parse(split.first);
  final lng = double.parse(split.last);
  return LatLng(lat, lng);
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
