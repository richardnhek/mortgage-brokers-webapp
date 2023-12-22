import 'package:flutter/material.dart';
import 'flutter_flow/request_manager.dart';
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

  String _mainNavView = '';
  String get mainNavView => _mainNavView;
  set mainNavView(String _value) {
    _mainNavView = _value;
  }

  final _testChatQueryCacheManager = StreamRequestManager<List<ChatsRecord>>();
  Stream<List<ChatsRecord>> testChatQueryCache({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Stream<List<ChatsRecord>> Function() requestFn,
  }) =>
      _testChatQueryCacheManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearTestChatQueryCacheCache() => _testChatQueryCacheManager.clear();
  void clearTestChatQueryCacheCacheKey(String? uniqueKey) =>
      _testChatQueryCacheManager.clearRequest(uniqueKey);

  final _pinChatQueryCacheManager = StreamRequestManager<List<ChatsRecord>>();
  Stream<List<ChatsRecord>> pinChatQueryCache({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Stream<List<ChatsRecord>> Function() requestFn,
  }) =>
      _pinChatQueryCacheManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearPinChatQueryCacheCache() => _pinChatQueryCacheManager.clear();
  void clearPinChatQueryCacheCacheKey(String? uniqueKey) =>
      _pinChatQueryCacheManager.clearRequest(uniqueKey);

  final _chatListQueryCacheManager = StreamRequestManager<List<ChatsRecord>>();
  Stream<List<ChatsRecord>> chatListQueryCache({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Stream<List<ChatsRecord>> Function() requestFn,
  }) =>
      _chatListQueryCacheManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearChatListQueryCacheCache() => _chatListQueryCacheManager.clear();
  void clearChatListQueryCacheCacheKey(String? uniqueKey) =>
      _chatListQueryCacheManager.clearRequest(uniqueKey);
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
