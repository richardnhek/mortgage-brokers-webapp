import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'direct_message_button_model.dart';
export 'direct_message_button_model.dart';

class DirectMessageButtonWidget extends StatefulWidget {
  const DirectMessageButtonWidget({
    Key? key,
    required this.userRef,
    required this.isRead,
    required this.isPinned,
    required this.lastMsgTime,
    required this.lastMsg,
    required this.lastMsgSentBy,
    required this.isSelected,
  }) : super(key: key);

  final DocumentReference? userRef;
  final bool? isRead;
  final bool? isPinned;
  final DateTime? lastMsgTime;
  final String? lastMsg;
  final DocumentReference? lastMsgSentBy;
  final bool? isSelected;

  @override
  _DirectMessageButtonWidgetState createState() =>
      _DirectMessageButtonWidgetState();
}

class _DirectMessageButtonWidgetState extends State<DirectMessageButtonWidget> {
  late DirectMessageButtonModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DirectMessageButtonModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return FutureBuilder<List<UsersRecord>>(
      future: queryUsersRecordOnce(
        queryBuilder: (usersRecord) => usersRecord.where(
          'user_ref',
          isEqualTo: widget.userRef,
        ),
        singleRecord: true,
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Center(
            child: SizedBox(
              width: 50,
              height: 50,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  FlutterFlowTheme.of(context).primary,
                ),
              ),
            ),
          );
        }
        List<UsersRecord> containerUsersRecordList =
            snapshot.data!.where((u) => u.uid != currentUserUid).toList();
        // Return an empty Container when the item does not exist.
        if (snapshot.data!.isEmpty) {
          return Container();
        }
        final containerUsersRecord = containerUsersRecordList.isNotEmpty
            ? containerUsersRecordList.first
            : null;
        return Container(
          width: double.infinity,
          height: 70.0,
          decoration: BoxDecoration(
            color: valueOrDefault<Color>(
              () {
                if (widget.isSelected == true) {
                  return Color(0xFFE4E4E4);
                } else if (widget.isRead == false) {
                  return Color(0x1AFF6B78);
                } else {
                  return Colors.transparent;
                }
              }(),
              Colors.transparent,
            ),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(25.0, 5.0, 25.0, 5.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 45.0,
                  height: 45.0,
                  child: Stack(
                    children: [
                      Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(3.0),
                          child: Image.network(
                            containerUsersRecord!.photoUrl,
                            width: 40.0,
                            height: 40.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      if (widget.isRead == false)
                        Align(
                          alignment: AlignmentDirectional(1.0, 1.0),
                          child: Container(
                            width: 10.0,
                            height: 10.0,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).primary,
                              borderRadius: BorderRadius.circular(1.0),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 0.0, 0.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              containerUsersRecord!.displayName
                                  .maybeHandleOverflow(
                                maxChars: 18,
                                replacement: '…',
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Inter',
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.normal,
                                  ),
                            ),
                            Text(
                              functions
                                  .getMessageTime(widget.lastMsgTime)
                                  .maybeHandleOverflow(
                                    maxChars: 20,
                                    replacement: '…',
                                  ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Inter',
                                    color:
                                        FlutterFlowTheme.of(context).secondary4,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.normal,
                                  ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 5.0, 0.0),
                                child: AutoSizeText(
                                  valueOrDefault<String>(
                                    widget.lastMsg,
                                    'N/A',
                                  ).maybeHandleOverflow(
                                    maxChars: 32,
                                    replacement: '…',
                                  ),
                                  maxLines: 1,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Inter',
                                        color: widget.isSelected == true
                                            ? Color(0xFF8D8D8D)
                                            : FlutterFlowTheme.of(context)
                                                .secondary4,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.normal,
                                      ),
                                  minFontSize: 10.0,
                                ),
                              ),
                            ),
                            if (widget.isPinned == true)
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 5.0, 0.0),
                                child: Icon(
                                  Icons.push_pin_rounded,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  size: 16.0,
                                ),
                              ),
                          ],
                        ),
                      ].divide(SizedBox(height: 10.0)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
