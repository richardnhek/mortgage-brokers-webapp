import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/request_manager.dart';

import 'direct_message_button_widget.dart' show DirectMessageButtonWidget;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DirectMessageButtonModel
    extends FlutterFlowModel<DirectMessageButtonWidget> {
  /// Query cache managers for this widget.

  final _chatUserQueryCacheManager = FutureRequestManager<List<UsersRecord>>();
  Future<List<UsersRecord>> chatUserQueryCache({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<UsersRecord>> Function() requestFn,
  }) =>
      _chatUserQueryCacheManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearChatUserQueryCacheCache() => _chatUserQueryCacheManager.clear();
  void clearChatUserQueryCacheCacheKey(String? uniqueKey) =>
      _chatUserQueryCacheManager.clearRequest(uniqueKey);

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    /// Dispose query cache managers for this widget.

    clearChatUserQueryCacheCache();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
