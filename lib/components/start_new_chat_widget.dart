import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/create_workspace_widget.dart';
import '/flutter_flow/chat/index.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'start_new_chat_model.dart';
export 'start_new_chat_model.dart';

class StartNewChatWidget extends StatefulWidget {
  const StartNewChatWidget({
    Key? key,
    this.workspaceRef,
    this.workspaceId,
    this.memberList,
  }) : super(key: key);

  final DocumentReference? workspaceRef;
  final String? workspaceId;
  final List<DocumentReference>? memberList;

  @override
  _StartNewChatWidgetState createState() => _StartNewChatWidgetState();
}

class _StartNewChatWidgetState extends State<StartNewChatWidget> {
  late StartNewChatModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => StartNewChatModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      FFAppState().update(() {
        FFAppState().selectedMembers = [];
      });
      setState(() {
        _model.isLoaded = false;
      });
      if (widget.workspaceRef == null) {
        _model.workspaceList = await queryWorkspacesRecordOnce(
          queryBuilder: (workspacesRecord) => workspacesRecord.where(
            'members',
            arrayContains: currentUserReference,
          ),
        );
      }
      setState(() {
        _model.isLoaded = true;
      });
    });

    _model.channelNameController ??= TextEditingController();
    _model.channelNameFocusNode ??= FocusNode();

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

    return Builder(
      builder: (context) {
        if (_model.isLoaded == true) {
          return Container(
            width: double.infinity,
            constraints: BoxConstraints(
              maxWidth: 590.0,
            ),
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).primaryBackground,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: FlutterFlowTheme.of(context).alternate,
                width: 1.0,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(25.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: AlignmentDirectional(-1.0, 0.0),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 20.0),
                                child: Text(
                                  'Start New Chat',
                                  textAlign: TextAlign.end,
                                  style: FlutterFlowTheme.of(context)
                                      .headlineSmall
                                      .override(
                                        fontFamily: 'Inter',
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ),
                              InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  _model.updatePage(() {
                                    FFAppState().selectedMembers = [];
                                  });
                                  Navigator.pop(context);
                                },
                                child: Icon(
                                  Icons.clear_rounded,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 24.0,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            _model.workspaceList != null &&
                                    _model.workspaceList!.isNotEmpty
                                ? 'Invite new user to the chat'
                                : 'No workspace available. Create one to start a new chat.',
                            textAlign: TextAlign.start,
                            style: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'Inter',
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w300,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 25.0, 0.0, 0.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(-1.0, 0.0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 15.0),
                            child: Text(
                              'Channel name (At least 3 members)',
                              textAlign: TextAlign.start,
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Inter',
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.normal,
                                    lineHeight: 1.5,
                                  ),
                            ),
                          ),
                        ),
                        InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            if (FFAppState().selectedMembers.length < 2) {
                              await showDialog(
                                context: context,
                                builder: (alertDialogContext) {
                                  return AlertDialog(
                                    title: Text('Info'),
                                    content: Text(
                                        'Please add at least 2 members to start a channel.'),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(alertDialogContext),
                                        child: Text('Ok'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          },
                          child: Container(
                            height: 50.0,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .primaryBackground,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 4.0,
                                  color: Color(0x14000000),
                                  offset: Offset(0.0, 2.0),
                                )
                              ],
                              borderRadius: BorderRadius.circular(5.0),
                              border: Border.all(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                width: 1.0,
                              ),
                            ),
                            child: TextFormField(
                              controller: _model.channelNameController,
                              focusNode: _model.channelNameFocusNode,
                              onChanged: (_) => EasyDebounce.debounce(
                                '_model.channelNameController',
                                Duration(milliseconds: 100),
                                () => setState(() {}),
                              ),
                              autofocus: true,
                              readOnly: FFAppState().selectedMembers.length < 2,
                              obscureText: false,
                              decoration: InputDecoration(
                                hintText: 'Whole team',
                                hintStyle: FlutterFlowTheme.of(context)
                                    .headlineMedium
                                    .override(
                                      fontFamily: 'Inter',
                                      color: FlutterFlowTheme.of(context)
                                          .darkGrey2,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.normal,
                                    ),
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                focusedErrorBorder: InputBorder.none,
                                contentPadding: EdgeInsetsDirectional.fromSTEB(
                                    10.0, 0.0, 10.0, 0.0),
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .headlineMedium
                                  .override(
                                    fontFamily: 'Inter',
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.normal,
                                  ),
                              maxLines: null,
                              validator: _model.channelNameControllerValidator
                                  .asValidator(context),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (widget.workspaceRef == null)
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 25.0, 0.0, 0.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: AlignmentDirectional(-1.0, 0.0),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 15.0),
                              child: Text(
                                'Choose workspace',
                                textAlign: TextAlign.start,
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Inter',
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.normal,
                                      lineHeight: 1.5,
                                    ),
                              ),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            height: 50.0,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .primaryBackground,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 4.0,
                                  color: Color(0x14000000),
                                  offset: Offset(0.0, 2.0),
                                )
                              ],
                              borderRadius: BorderRadius.circular(5.0),
                              border: Border.all(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                width: 1.0,
                              ),
                            ),
                            child: Builder(
                              builder: (context) {
                                if ((_model.workspaceList != null &&
                                        _model.workspaceList!.isNotEmpty) ==
                                    true) {
                                  return FlutterFlowDropDown<String>(
                                    controller:
                                        _model.dropDownValueController ??=
                                            FormFieldController<String>(
                                      _model.dropDownValue ??= '',
                                    ),
                                    options: List<String>.from(_model
                                        .workspaceList!
                                        .map((e) => e.id)
                                        .toList()),
                                    optionLabels: _model.workspaceList!
                                        .map((e) => e.name)
                                        .toList(),
                                    onChanged: (val) async {
                                      setState(
                                          () => _model.dropDownValue = val);
                                      _model.updatePage(() {
                                        _model.isLoaded = false;
                                      });
                                      FFAppState().update(() {
                                        FFAppState().selectedMembers = [];
                                      });
                                      _model.thisSelectedWorkspace =
                                          await queryWorkspacesRecordOnce(
                                        queryBuilder: (workspacesRecord) =>
                                            workspacesRecord.where(
                                          'id',
                                          isEqualTo: _model.dropDownValue,
                                        ),
                                        singleRecord: true,
                                      ).then((s) => s.firstOrNull);
                                      _model.updatePage(() {
                                        _model.selectedWorkspaceRef = _model
                                            .thisSelectedWorkspace?.reference;
                                        _model.selectedMemberList = _model
                                            .thisSelectedWorkspace!.members
                                            .where((e) =>
                                                e != currentUserReference)
                                            .toList()
                                            .cast<DocumentReference>();
                                        _model.selectedWorkspaceId =
                                            _model.thisSelectedWorkspace!.id;
                                      });
                                      _model.updatePage(() {
                                        _model.isLoaded = true;
                                      });

                                      setState(() {});
                                    },
                                    width: double.infinity,
                                    height: 50.0,
                                    searchHintTextStyle:
                                        FlutterFlowTheme.of(context)
                                            .labelMedium,
                                    textStyle:
                                        FlutterFlowTheme.of(context).bodyMedium,
                                    hintText: 'Please select...',
                                    searchHintText: 'Search for an item...',
                                    icon: Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      size: 24.0,
                                    ),
                                    fillColor: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    elevation: 0.0,
                                    borderColor: Colors.transparent,
                                    borderWidth: 0.0,
                                    borderRadius: 5.0,
                                    margin: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 4.0, 16.0, 4.0),
                                    hidesUnderline: true,
                                    isOverButton: true,
                                    isSearchable: true,
                                    isMultiSelect: false,
                                  );
                                } else {
                                  return Builder(
                                    builder: (context) => FFButtonWidget(
                                      onPressed: () async {
                                        Navigator.pop(context);
                                        await showAlignedDialog(
                                          context: context,
                                          isGlobal: true,
                                          avoidOverflow: false,
                                          targetAnchor: AlignmentDirectional(
                                                  0.0, 0.0)
                                              .resolve(
                                                  Directionality.of(context)),
                                          followerAnchor: AlignmentDirectional(
                                                  0.0, 0.0)
                                              .resolve(
                                                  Directionality.of(context)),
                                          builder: (dialogContext) {
                                            return Material(
                                              color: Colors.transparent,
                                              child: CreateWorkspaceWidget(),
                                            );
                                          },
                                        ).then((value) => setState(() {}));
                                      },
                                      text: 'Create a new workspace',
                                      icon: Icon(
                                        Icons.add_rounded,
                                        size: 15.0,
                                      ),
                                      options: FFButtonOptions(
                                        height: 50.0,
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            24.0, 0.0, 24.0, 0.0),
                                        iconPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                0.0, 0.0, 0.0, 0.0),
                                        color: FlutterFlowTheme.of(context)
                                            .customBlue,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                              fontFamily: 'Inter',
                                              color: Colors.white,
                                            ),
                                        elevation: 0.0,
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 25.0, 0.0, 0.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(-1.0, 0.0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 15.0),
                            child: Text(
                              'Email',
                              textAlign: TextAlign.start,
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Inter',
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.normal,
                                    lineHeight: 1.5,
                                  ),
                            ),
                          ),
                        ),
                        StreamBuilder<List<UsersRecord>>(
                          stream: queryUsersRecord(
                            queryBuilder: (usersRecord) => usersRecord.whereIn(
                                'user_ref',
                                (widget.memberList != null &&
                                            widget.memberList!.isNotEmpty) ==
                                        true
                                    ? widget.memberList
                                    : _model.selectedMemberList),
                          ),
                          builder: (context, snapshot) {
                            // Customize what your widget looks like when it's loading.
                            if (!snapshot.hasData) {
                              return Center(
                                child: SizedBox(
                                  width: 50.0,
                                  height: 50.0,
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      FlutterFlowTheme.of(context).primary,
                                    ),
                                  ),
                                ),
                              );
                            }
                            List<UsersRecord> containerUsersRecordList =
                                snapshot.data!
                                    .where((u) => u.uid != currentUserUid)
                                    .toList();
                            return Container(
                              width: double.infinity,
                              height: 100.0,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                              ),
                              child: Stack(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height: 56.0,
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(4.0),
                                      border: Border.all(
                                        color: FlutterFlowTheme.of(context)
                                            .darkGrey2,
                                        width: 1.0,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 535.0,
                                    height: 100.0,
                                    child:
                                        custom_widgets.CustomMemberSelectorV2(
                                      width: 535.0,
                                      height: 100.0,
                                      userDocsList: containerUsersRecordList,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                    child: Builder(
                      builder: (context) {
                        if (widget.workspaceRef != null) {
                          return FFButtonWidget(
                            onPressed: ((FFAppState().selectedMembers.length ==
                                        0) ||
                                    ((FFAppState().selectedMembers.length >
                                            1) &&
                                        (_model.channelNameController.text ==
                                                null ||
                                            _model.channelNameController.text ==
                                                '')))
                                ? null
                                : () async {
                                    var _shouldSetState = false;
                                    final firestoreBatch =
                                        FirebaseFirestore.instance.batch();
                                    try {
                                      if (FFAppState().selectedMembers.length >
                                          1) {
                                        _model.updatePage(() {
                                          FFAppState().addToSelectedMembers(
                                              currentUserReference!);
                                        });
                                        _model.groupChatCreated =
                                            await FFChatManager.instance
                                                .createChat(
                                          FFAppState().selectedMembers.toList(),
                                        );
                                        _shouldSetState = true;

                                        var chatMessagesRecordReference1 =
                                            ChatMessagesRecord.collection.doc();
                                        firestoreBatch.set(
                                            chatMessagesRecordReference1,
                                            createChatMessagesRecordData(
                                              user: currentUserReference,
                                              chat: _model
                                                  .groupChatCreated?.reference,
                                              text: 'Welcome everyone!',
                                              timestamp: getCurrentTimestamp,
                                            ));
                                        _model.createdMessage = ChatMessagesRecord
                                            .getDocumentFromData(
                                                createChatMessagesRecordData(
                                                  user: currentUserReference,
                                                  chat: _model.groupChatCreated
                                                      ?.reference,
                                                  text: 'Welcome everyone!',
                                                  timestamp:
                                                      getCurrentTimestamp,
                                                ),
                                                chatMessagesRecordReference1);
                                        _shouldSetState = true;

                                        firestoreBatch.update(
                                            _model.createdMessage!.reference,
                                            createChatMessagesRecordData(
                                              chatMessageRef: _model
                                                  .createdMessage?.reference,
                                            ));

                                        firestoreBatch.update(
                                            _model.groupChatCreated!.reference,
                                            createChatsRecordData(
                                              lastMessage: 'Welcome everyone!',
                                              lastMessageTime:
                                                  getCurrentTimestamp,
                                              lastMessageSentBy:
                                                  currentUserReference,
                                              chatType: 'Channel',
                                              workspaceId: widget.workspaceId,
                                              channelName: _model
                                                  .channelNameController.text,
                                              workspaceRef: widget.workspaceRef,
                                              chatRef: _model
                                                  .groupChatCreated?.reference,
                                              createdTime: getCurrentTimestamp,
                                            ));

                                        firestoreBatch
                                            .update(widget.workspaceRef!, {
                                          ...mapToFirestore(
                                            {
                                              'chat_refs':
                                                  FieldValue.arrayUnion([
                                                _model
                                                    .groupChatCreated?.reference
                                              ]),
                                            },
                                          ),
                                        });
                                        FFAppState().update(() {
                                          FFAppState().currentChatRef = _model
                                              .groupChatCreated?.reference;
                                          FFAppState().currentChatUserRef =
                                              null;
                                          FFAppState().currentMainView = 'Chat';
                                        });
                                      } else {
                                        _model.updatePage(() {
                                          FFAppState().addToSelectedMembers(
                                              currentUserReference!);
                                        });
                                        _model.chatsInWorkspace =
                                            await queryChatsRecordOnce(
                                          queryBuilder: (chatsRecord) =>
                                              chatsRecord
                                                  .where(
                                                    'workspace_ref',
                                                    isEqualTo:
                                                        widget.workspaceRef,
                                                  )
                                                  .where(
                                                    'users',
                                                    arrayContains: FFAppState()
                                                        .selectedMembers
                                                        .first,
                                                  )
                                                  .where(
                                                    'chat_type',
                                                    isEqualTo: 'DM',
                                                  ),
                                        );
                                        _shouldSetState = true;
                                        if (_model.chatsInWorkspace!.length >=
                                            1) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'Chat already exists',
                                                style: GoogleFonts.getFont(
                                                  'Inter',
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryBackground,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16.0,
                                                ),
                                              ),
                                              duration:
                                                  Duration(milliseconds: 4000),
                                              backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                            ),
                                          );
                                          _model.updatePage(() {
                                            FFAppState().selectedMembers = [];
                                          });
                                          Navigator.pop(context);
                                          FFAppState().update(() {
                                            FFAppState().currentChatRef = _model
                                                .chatsInWorkspace
                                                ?.first
                                                ?.reference;
                                            FFAppState().currentChatUserRef =
                                                _model.chatsInWorkspace?.first
                                                    ?.users
                                                    ?.where((e) =>
                                                        e !=
                                                        currentUserReference)
                                                    .toList()
                                                    ?.first;
                                            FFAppState().currentMainView =
                                                'Chat';
                                          });
                                          if (_shouldSetState) setState(() {});
                                          return;
                                        } else {
                                          var chatsRecordReference =
                                              ChatsRecord.collection.doc();
                                          firestoreBatch
                                              .set(chatsRecordReference, {
                                            ...createChatsRecordData(
                                              chatType: 'DM',
                                              workspaceId: widget.workspaceId,
                                              channelName: _model
                                                  .channelNameController.text,
                                              workspaceRef: widget.workspaceRef,
                                              userA: currentUserReference,
                                              userB: FFAppState()
                                                  .selectedMembers
                                                  .first,
                                              createdTime: getCurrentTimestamp,
                                            ),
                                            ...mapToFirestore(
                                              {
                                                'users': FFAppState()
                                                    .selectedMembers,
                                              },
                                            ),
                                          });
                                          _model.createdChat =
                                              ChatsRecord.getDocumentFromData({
                                            ...createChatsRecordData(
                                              chatType: 'DM',
                                              workspaceId: widget.workspaceId,
                                              channelName: _model
                                                  .channelNameController.text,
                                              workspaceRef: widget.workspaceRef,
                                              userA: currentUserReference,
                                              userB: FFAppState()
                                                  .selectedMembers
                                                  .first,
                                              createdTime: getCurrentTimestamp,
                                            ),
                                            ...mapToFirestore(
                                              {
                                                'users': FFAppState()
                                                    .selectedMembers,
                                              },
                                            ),
                                          }, chatsRecordReference);
                                          _shouldSetState = true;

                                          var chatMessagesRecordReference2 =
                                              ChatMessagesRecord.collection
                                                  .doc();
                                          firestoreBatch.set(
                                              chatMessagesRecordReference2,
                                              createChatMessagesRecordData(
                                                user: currentUserReference,
                                                chat: _model
                                                    .createdChat?.reference,
                                                text: 'Hello!',
                                                timestamp: getCurrentTimestamp,
                                              ));
                                          _model.createdMessage2 =
                                              ChatMessagesRecord.getDocumentFromData(
                                                  createChatMessagesRecordData(
                                                    user: currentUserReference,
                                                    chat: _model
                                                        .createdChat?.reference,
                                                    text: 'Hello!',
                                                    timestamp:
                                                        getCurrentTimestamp,
                                                  ),
                                                  chatMessagesRecordReference2);
                                          _shouldSetState = true;

                                          firestoreBatch.update(
                                              _model.createdMessage2!.reference,
                                              createChatMessagesRecordData(
                                                chatMessageRef: _model
                                                    .createdMessage2?.reference,
                                              ));

                                          firestoreBatch.update(
                                              _model.createdChat!.reference, {
                                            ...createChatsRecordData(
                                              chatRef:
                                                  _model.createdChat?.reference,
                                              lastMessage:
                                                  _model.createdMessage2?.text,
                                              lastMessageTime:
                                                  getCurrentTimestamp,
                                              lastMessageSentBy:
                                                  currentUserReference,
                                            ),
                                            ...mapToFirestore(
                                              {
                                                'last_message_seen_by':
                                                    FieldValue.arrayUnion(
                                                        [currentUserReference]),
                                              },
                                            ),
                                          });

                                          firestoreBatch
                                              .update(widget.workspaceRef!, {
                                            ...mapToFirestore(
                                              {
                                                'chat_refs':
                                                    FieldValue.arrayUnion([
                                                  _model.createdChat?.reference
                                                ]),
                                              },
                                            ),
                                          });
                                          FFAppState().update(() {
                                            FFAppState().currentChatRef =
                                                _model.createdChat?.reference;
                                            FFAppState().currentChatUserRef =
                                                _model.createdChat?.userB;
                                            FFAppState().currentMainView =
                                                'Chat';
                                          });
                                        }
                                      }

                                      _model.updatePage(() {
                                        FFAppState().selectedMembers = [];
                                      });
                                      Navigator.pop(context);
                                    } finally {
                                      await firestoreBatch.commit();
                                    }

                                    if (_shouldSetState) setState(() {});
                                  },
                            text: 'Start Chat',
                            options: FFButtonOptions(
                              width: double.infinity,
                              height: 56.0,
                              padding: EdgeInsets.all(0.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: FlutterFlowTheme.of(context).primary,
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    fontFamily: 'Inter',
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500,
                                    lineHeight: 1.2,
                                  ),
                              elevation: 3.0,
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                              disabledColor:
                                  FlutterFlowTheme.of(context).secondaryText,
                              hoverColor: FlutterFlowTheme.of(context).accent1,
                              hoverBorderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).primary,
                                width: 1.0,
                              ),
                              hoverTextColor:
                                  FlutterFlowTheme.of(context).primaryText,
                              hoverElevation: 0.0,
                            ),
                          );
                        } else {
                          return FFButtonWidget(
                            onPressed: ((FFAppState().selectedMembers.length ==
                                        0) ||
                                    ((FFAppState().selectedMembers.length >
                                            1) &&
                                        (_model.channelNameController.text ==
                                                null ||
                                            _model.channelNameController.text ==
                                                '')) ||
                                    (_model.dropDownValue == null ||
                                        _model.dropDownValue == ''))
                                ? null
                                : () async {
                                    var _shouldSetState = false;
                                    final firestoreBatch =
                                        FirebaseFirestore.instance.batch();
                                    try {
                                      if (FFAppState().selectedMembers.length >
                                          1) {
                                        FFAppState().update(() {
                                          FFAppState().addToSelectedMembers(
                                              currentUserReference!);
                                        });
                                        _model.groupChatCreatedCopy =
                                            await FFChatManager.instance
                                                .createChat(
                                          FFAppState().selectedMembers.toList(),
                                        );
                                        _shouldSetState = true;

                                        var chatMessagesRecordReference1 =
                                            ChatMessagesRecord.collection.doc();
                                        firestoreBatch.set(
                                            chatMessagesRecordReference1,
                                            createChatMessagesRecordData(
                                              user: currentUserReference,
                                              chat: _model.groupChatCreatedCopy
                                                  ?.reference,
                                              text: 'Welcome everyone!',
                                              timestamp: getCurrentTimestamp,
                                            ));
                                        _model.createdMessageCopy =
                                            ChatMessagesRecord.getDocumentFromData(
                                                createChatMessagesRecordData(
                                                  user: currentUserReference,
                                                  chat: _model
                                                      .groupChatCreatedCopy
                                                      ?.reference,
                                                  text: 'Welcome everyone!',
                                                  timestamp:
                                                      getCurrentTimestamp,
                                                ),
                                                chatMessagesRecordReference1);
                                        _shouldSetState = true;

                                        firestoreBatch.update(
                                            _model
                                                .createdMessageCopy!.reference,
                                            createChatMessagesRecordData(
                                              chatMessageRef: _model
                                                  .createdMessageCopy
                                                  ?.reference,
                                            ));

                                        firestoreBatch.update(
                                            _model.groupChatCreatedCopy!
                                                .reference,
                                            createChatsRecordData(
                                              lastMessage: 'Welcome everyone!',
                                              lastMessageTime:
                                                  getCurrentTimestamp,
                                              lastMessageSentBy:
                                                  currentUserReference,
                                              chatType: 'Channel',
                                              workspaceId:
                                                  _model.selectedWorkspaceId,
                                              channelName: _model
                                                  .channelNameController.text,
                                              workspaceRef:
                                                  _model.selectedWorkspaceRef,
                                              chatRef: _model
                                                  .groupChatCreatedCopy
                                                  ?.reference,
                                              createdTime: getCurrentTimestamp,
                                            ));

                                        firestoreBatch.update(
                                            _model.selectedWorkspaceRef!, {
                                          ...mapToFirestore(
                                            {
                                              'chat_refs':
                                                  FieldValue.arrayUnion([
                                                _model.groupChatCreatedCopy
                                                    ?.reference
                                              ]),
                                            },
                                          ),
                                        });
                                        FFAppState().update(() {
                                          FFAppState().currentChatRef = _model
                                              .groupChatCreatedCopy?.reference;
                                          FFAppState().currentChatUserRef =
                                              null;
                                          FFAppState().currentMainView = 'Chat';
                                        });
                                        Navigator.pop(context);
                                      } else {
                                        FFAppState().update(() {
                                          FFAppState().addToSelectedMembers(
                                              currentUserReference!);
                                        });
                                        _model.chatsInWorkspaceCopy =
                                            await queryChatsRecordOnce(
                                          queryBuilder: (chatsRecord) =>
                                              chatsRecord
                                                  .where(
                                                    'workspace_ref',
                                                    isEqualTo: _model
                                                        .selectedWorkspaceRef,
                                                  )
                                                  .where(
                                                    'users',
                                                    arrayContains:
                                                        currentUserReference,
                                                  )
                                                  .where(
                                                    'chat_type',
                                                    isEqualTo: 'DM',
                                                  ),
                                        );
                                        _shouldSetState = true;
                                        if (_model
                                                .chatsInWorkspaceCopy!.length >=
                                            1) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'Chat already exists',
                                                style: GoogleFonts.getFont(
                                                  'Inter',
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryBackground,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16.0,
                                                ),
                                              ),
                                              duration:
                                                  Duration(milliseconds: 4000),
                                              backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                            ),
                                          );
                                          _model.updatePage(() {
                                            FFAppState().selectedMembers = [];
                                          });
                                          FFAppState().update(() {
                                            FFAppState().currentChatRef = _model
                                                .chatsInWorkspaceCopy
                                                ?.first
                                                ?.reference;
                                            FFAppState().currentChatUserRef =
                                                _model.chatsInWorkspaceCopy
                                                    ?.first?.users
                                                    ?.where((e) =>
                                                        e !=
                                                        currentUserReference)
                                                    .toList()
                                                    ?.first;
                                            FFAppState().currentMainView =
                                                'Chat';
                                          });
                                          Navigator.pop(context);
                                          if (_shouldSetState) setState(() {});
                                          return;
                                        } else {
                                          var chatsRecordReference =
                                              ChatsRecord.collection.doc();
                                          firestoreBatch
                                              .set(chatsRecordReference, {
                                            ...createChatsRecordData(
                                              chatType: 'DM',
                                              workspaceId:
                                                  _model.selectedWorkspaceId,
                                              channelName: _model
                                                  .channelNameController.text,
                                              workspaceRef:
                                                  _model.selectedWorkspaceRef,
                                              userA: currentUserReference,
                                              userB: FFAppState()
                                                  .selectedMembers
                                                  .first,
                                              createdTime: getCurrentTimestamp,
                                            ),
                                            ...mapToFirestore(
                                              {
                                                'users': FFAppState()
                                                    .selectedMembers,
                                              },
                                            ),
                                          });
                                          _model.createdChatCopy =
                                              ChatsRecord.getDocumentFromData({
                                            ...createChatsRecordData(
                                              chatType: 'DM',
                                              workspaceId:
                                                  _model.selectedWorkspaceId,
                                              channelName: _model
                                                  .channelNameController.text,
                                              workspaceRef:
                                                  _model.selectedWorkspaceRef,
                                              userA: currentUserReference,
                                              userB: FFAppState()
                                                  .selectedMembers
                                                  .first,
                                              createdTime: getCurrentTimestamp,
                                            ),
                                            ...mapToFirestore(
                                              {
                                                'users': FFAppState()
                                                    .selectedMembers,
                                              },
                                            ),
                                          }, chatsRecordReference);
                                          _shouldSetState = true;

                                          var chatMessagesRecordReference2 =
                                              ChatMessagesRecord.collection
                                                  .doc();
                                          firestoreBatch.set(
                                              chatMessagesRecordReference2,
                                              createChatMessagesRecordData(
                                                user: currentUserReference,
                                                chat: _model
                                                    .createdChatCopy?.reference,
                                                text: 'Hello!',
                                                timestamp: getCurrentTimestamp,
                                              ));
                                          _model.createdMessage2Copy =
                                              ChatMessagesRecord.getDocumentFromData(
                                                  createChatMessagesRecordData(
                                                    user: currentUserReference,
                                                    chat: _model.createdChatCopy
                                                        ?.reference,
                                                    text: 'Hello!',
                                                    timestamp:
                                                        getCurrentTimestamp,
                                                  ),
                                                  chatMessagesRecordReference2);
                                          _shouldSetState = true;

                                          firestoreBatch.update(
                                              _model.createdMessage2!.reference,
                                              createChatMessagesRecordData(
                                                chatMessageRef: _model
                                                    .createdMessage2Copy
                                                    ?.reference,
                                              ));

                                          firestoreBatch.update(
                                              _model.createdChat!.reference, {
                                            ...createChatsRecordData(
                                              chatRef: _model
                                                  .createdChatCopy?.reference,
                                              lastMessage: _model
                                                  .createdMessage2Copy?.text,
                                              lastMessageTime:
                                                  getCurrentTimestamp,
                                              lastMessageSentBy:
                                                  currentUserReference,
                                            ),
                                            ...mapToFirestore(
                                              {
                                                'last_message_seen_by':
                                                    FieldValue.arrayUnion(
                                                        [currentUserReference]),
                                              },
                                            ),
                                          });

                                          firestoreBatch.update(
                                              _model.selectedWorkspaceRef!, {
                                            ...mapToFirestore(
                                              {
                                                'chat_refs':
                                                    FieldValue.arrayUnion([
                                                  _model.createdChatCopy
                                                      ?.reference
                                                ]),
                                              },
                                            ),
                                          });
                                          FFAppState().update(() {
                                            FFAppState().currentChatRef = _model
                                                .createdChatCopy?.reference;
                                            FFAppState().currentChatUserRef =
                                                _model.createdChatCopy?.userB;
                                            FFAppState().currentMainView =
                                                'Chat';
                                          });
                                          Navigator.pop(context);
                                        }
                                      }
                                    } finally {
                                      await firestoreBatch.commit();
                                    }

                                    if (_shouldSetState) setState(() {});
                                  },
                            text: 'Start Chat',
                            options: FFButtonOptions(
                              width: double.infinity,
                              height: 56.0,
                              padding: EdgeInsets.all(0.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: FlutterFlowTheme.of(context).primary,
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    fontFamily: 'Inter',
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500,
                                    lineHeight: 1.2,
                                  ),
                              elevation: 3.0,
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                              disabledColor:
                                  FlutterFlowTheme.of(context).secondaryText,
                              hoverColor: FlutterFlowTheme.of(context).accent1,
                              hoverBorderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).primary,
                                width: 1.0,
                              ),
                              hoverTextColor:
                                  FlutterFlowTheme.of(context).primaryText,
                              hoverElevation: 0.0,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Align(
            alignment: AlignmentDirectional(0.0, 0.0),
            child: Container(
              width: 100.0,
              height: 100.0,
              child: custom_widgets.FFlowSpinner(
                width: 100.0,
                height: 100.0,
                spinnerWidth: 50.0,
                spinnerHeight: 50.0,
                backgroundColor: Colors.transparent,
                spinnerColor: FlutterFlowTheme.of(context).primary,
              ),
            ),
          );
        }
      },
    );
  }
}
