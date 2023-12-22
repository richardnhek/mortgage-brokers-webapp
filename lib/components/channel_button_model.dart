import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/request_manager.dart';

import 'channel_button_widget.dart' show ChannelButtonWidget;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ChannelButtonModel extends FlutterFlowModel<ChannelButtonWidget> {
  /// Query cache managers for this widget.

  final _lastUserQueryCacheManager = FutureRequestManager<UsersRecord>();
  Future<UsersRecord> lastUserQueryCache({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<UsersRecord> Function() requestFn,
  }) =>
      _lastUserQueryCacheManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearLastUserQueryCacheCache() => _lastUserQueryCacheManager.clear();
  void clearLastUserQueryCacheCacheKey(String? uniqueKey) =>
      _lastUserQueryCacheManager.clearRequest(uniqueKey);

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    /// Dispose query cache managers for this widget.

    clearLastUserQueryCacheCache();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
