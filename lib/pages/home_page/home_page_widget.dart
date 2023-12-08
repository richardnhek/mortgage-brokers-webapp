import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/components/channel_button_widget.dart';
import '/components/create_workspace_widget.dart';
import '/components/direct_message_button_widget.dart';
import '/components/empty_chat_widget_widget.dart';
import '/components/main_web_nav_widget.dart';
import '/components/overview_widget.dart';
import '/components/start_new_chat_widget.dart';
import '/components/user_details_widget.dart';
import '/components/workspace_detail_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'home_page_model.dart';
export 'home_page_model.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  late HomePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomePageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      FFAppState().update(() {
        FFAppState().selectedMembers = [];
        FFAppState().mainNavView = 'Workspace';
      });
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isiOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              wrapWithModel(
                model: _model.mainWebNavModel,
                updateCallback: () => setState(() {}),
                child: MainWebNavWidget(),
              ),
              Container(
                width: MediaQuery.sizeOf(context).width * 0.2,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).alternate,
                  border: Border.all(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    width: 0.0,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 75.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).alternate,
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            25.0, 25.0, 25.0, 25.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              FFAppState().mainNavView == 'Workspace'
                                  ? 'My workspaces'
                                  : 'Chats',
                              textAlign: TextAlign.start,
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Inter',
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      height: 0.0,
                      thickness: 1.0,
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    Expanded(
                      child: Builder(
                        builder: (context) {
                          if (FFAppState().mainNavView == 'Workspace') {
                            return Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 25.0, 0.0, 0.0),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    FutureBuilder<List<WorkspacesRecord>>(
                                      future: queryWorkspacesRecordOnce(
                                        queryBuilder: (workspacesRecord) =>
                                            workspacesRecord.where(
                                          'members',
                                          arrayContains: currentUserReference,
                                        ),
                                      ),
                                      builder: (context, snapshot) {
                                        // Customize what your widget looks like when it's loading.
                                        if (!snapshot.hasData) {
                                          return Center(
                                            child: SizedBox(
                                              width: 50.0,
                                              height: 50.0,
                                              child: CircularProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                        List<WorkspacesRecord>
                                            columnWorkspacesRecordList =
                                            snapshot.data!;
                                        return Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: List.generate(
                                              columnWorkspacesRecordList.length,
                                              (columnIndex) {
                                            final columnWorkspacesRecord =
                                                columnWorkspacesRecordList[
                                                    columnIndex];
                                            return Container(
                                              width: double.infinity,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .darkGray1,
                                              child: ExpandableNotifier(
                                                child: ExpandablePanel(
                                                  header: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                25.0,
                                                                25.0,
                                                                0.0,
                                                                25.0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Icon(
                                                          Icons.lock_outline,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondary,
                                                          size: 21.0,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      10.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          child: Text(
                                                            columnWorkspacesRecord
                                                                .name,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .displaySmall
                                                                .override(
                                                                  fontFamily:
                                                                      'Inter',
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      16.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  collapsed: Container(),
                                                  expanded: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    25.0,
                                                                    0.0,
                                                                    25.0,
                                                                    0.0),
                                                        child: InkWell(
                                                          splashColor: Colors
                                                              .transparent,
                                                          focusColor: Colors
                                                              .transparent,
                                                          hoverColor: Colors
                                                              .transparent,
                                                          highlightColor: Colors
                                                              .transparent,
                                                          onTap: () async {
                                                            FFAppState()
                                                                .update(() {
                                                              FFAppState()
                                                                  .currentMainView = '';
                                                            });
                                                            setState(() {
                                                              _model.selectedOverview =
                                                                  null;
                                                              _model.workspaceMembers =
                                                                  [];
                                                              _model.workspaceFiles =
                                                                  [];
                                                              _model.workspaceRef =
                                                                  null;
                                                            });
                                                            await Future.delayed(
                                                                const Duration(
                                                                    milliseconds:
                                                                        500));
                                                            setState(() {
                                                              _model.selectedOverview =
                                                                  columnWorkspacesRecord
                                                                      .overview;
                                                              _model.workspaceMembers =
                                                                  columnWorkspacesRecord
                                                                      .members
                                                                      .toList()
                                                                      .cast<
                                                                          DocumentReference>();
                                                              _model.workspaceFiles =
                                                                  columnWorkspacesRecord
                                                                      .files
                                                                      .toList()
                                                                      .cast<
                                                                          WorkspaceFileStruct>();
                                                              _model.workspaceRef =
                                                                  columnWorkspacesRecord
                                                                      .reference;
                                                            });
                                                            FFAppState()
                                                                .update(() {
                                                              FFAppState()
                                                                      .currentMainView =
                                                                  'Overview';
                                                            });
                                                          },
                                                          child: Container(
                                                            width:
                                                                double.infinity,
                                                            height: 40.0,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primaryBackground,
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  blurRadius:
                                                                      4.0,
                                                                  color: Color(
                                                                      0x0E000000),
                                                                  offset:
                                                                      Offset(
                                                                          0.0,
                                                                          4.0),
                                                                )
                                                              ],
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5.0),
                                                              border:
                                                                  Border.all(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .tertiary,
                                                                width: 1.0,
                                                              ),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          5.0,
                                                                          5.0,
                                                                          5.0,
                                                                          5.0),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Icon(
                                                                    Icons
                                                                        .auto_awesome_outlined,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondary,
                                                                    size: 21.0,
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            10.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                    child: Text(
                                                                      'Overview',
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .displaySmall
                                                                          .override(
                                                                            fontFamily:
                                                                                'Inter',
                                                                            color:
                                                                                Colors.black,
                                                                            fontSize:
                                                                                15.0,
                                                                            fontWeight:
                                                                                FontWeight.normal,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    25.0,
                                                                    0.0,
                                                                    0.0),
                                                        child: Container(
                                                          width:
                                                              double.infinity,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryBackground,
                                                          ),
                                                          child: Container(
                                                            width:
                                                                double.infinity,
                                                            color: Colors
                                                                .transparent,
                                                            child:
                                                                ExpandableNotifier(
                                                              child:
                                                                  ExpandablePanel(
                                                                header: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          25.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                  child: Text(
                                                                    'Channels',
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .displaySmall
                                                                        .override(
                                                                          fontFamily:
                                                                              'Inter',
                                                                          color:
                                                                              FlutterFlowTheme.of(context).secondaryText,
                                                                          fontSize:
                                                                              15.0,
                                                                          fontWeight:
                                                                              FontWeight.normal,
                                                                        ),
                                                                  ),
                                                                ),
                                                                collapsed:
                                                                    Container(),
                                                                expanded:
                                                                    Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          25.0,
                                                                          20.0,
                                                                          25.0,
                                                                          0.0),
                                                                  child: FutureBuilder<
                                                                      List<
                                                                          ChatsRecord>>(
                                                                    future:
                                                                        queryChatsRecordOnce(
                                                                      queryBuilder: (chatsRecord) => chatsRecord
                                                                          .where(
                                                                            'chat_type',
                                                                            isEqualTo:
                                                                                'Channel',
                                                                          )
                                                                          .where(
                                                                            'users',
                                                                            arrayContains:
                                                                                currentUserReference,
                                                                          )
                                                                          .where(
                                                                            'workspace_ref',
                                                                            isEqualTo:
                                                                                columnWorkspacesRecord.workspaceRef,
                                                                          )
                                                                          .orderBy('last_message_time', descending: true),
                                                                    ),
                                                                    builder:
                                                                        (context,
                                                                            snapshot) {
                                                                      // Customize what your widget looks like when it's loading.
                                                                      if (!snapshot
                                                                          .hasData) {
                                                                        return Center(
                                                                          child:
                                                                              SizedBox(
                                                                            width:
                                                                                50.0,
                                                                            height:
                                                                                50.0,
                                                                            child:
                                                                                CircularProgressIndicator(
                                                                              valueColor: AlwaysStoppedAnimation<Color>(
                                                                                FlutterFlowTheme.of(context).primary,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        );
                                                                      }
                                                                      List<ChatsRecord>
                                                                          columnChatsRecordList =
                                                                          snapshot
                                                                              .data!;
                                                                      return Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children: List.generate(
                                                                            columnChatsRecordList.length,
                                                                            (columnIndex) {
                                                                          final columnChatsRecord =
                                                                              columnChatsRecordList[columnIndex];
                                                                          return InkWell(
                                                                            splashColor:
                                                                                Colors.transparent,
                                                                            focusColor:
                                                                                Colors.transparent,
                                                                            hoverColor:
                                                                                Colors.transparent,
                                                                            highlightColor:
                                                                                Colors.transparent,
                                                                            onTap:
                                                                                () async {
                                                                              setState(() {
                                                                                FFAppState().currentChatRef = columnChatsRecord.reference;
                                                                                FFAppState().currentChatUserRef = null;
                                                                              });
                                                                              setState(() {
                                                                                _model.chatUser = null;
                                                                                _model.selectedChannel = columnChatsRecord.channelName;
                                                                              });
                                                                              setState(() {
                                                                                FFAppState().currentMainView = 'Chat';
                                                                              });
                                                                            },
                                                                            child:
                                                                                ChannelButtonWidget(
                                                                              key: Key('Keyed1_${columnIndex}_of_${columnChatsRecordList.length}'),
                                                                              channelName: columnChatsRecord.channelName,
                                                                            ),
                                                                          );
                                                                        }).divide(SizedBox(
                                                                            height:
                                                                                5.0)),
                                                                      );
                                                                    },
                                                                  ),
                                                                ),
                                                                theme:
                                                                    ExpandableThemeData(
                                                                  tapHeaderToExpand:
                                                                      true,
                                                                  tapBodyToExpand:
                                                                      false,
                                                                  tapBodyToCollapse:
                                                                      false,
                                                                  headerAlignment:
                                                                      ExpandablePanelHeaderAlignment
                                                                          .center,
                                                                  hasIcon: true,
                                                                  expandIcon: Icons
                                                                      .keyboard_arrow_right_rounded,
                                                                  collapseIcon:
                                                                      Icons
                                                                          .keyboard_arrow_down_rounded,
                                                                  iconColor: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryText,
                                                                  iconPadding: EdgeInsets
                                                                      .fromLTRB(
                                                                          0.0,
                                                                          0.0,
                                                                          25.0,
                                                                          0.0),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    25.0,
                                                                    0.0,
                                                                    0.0),
                                                        child: Container(
                                                          width:
                                                              double.infinity,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryBackground,
                                                          ),
                                                          child: Container(
                                                            width:
                                                                double.infinity,
                                                            color: Colors
                                                                .transparent,
                                                            child:
                                                                ExpandableNotifier(
                                                              child:
                                                                  ExpandablePanel(
                                                                header: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          25.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                  child: Text(
                                                                    'Direct messages',
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .displaySmall
                                                                        .override(
                                                                          fontFamily:
                                                                              'Inter',
                                                                          color:
                                                                              FlutterFlowTheme.of(context).secondaryText,
                                                                          fontSize:
                                                                              15.0,
                                                                          fontWeight:
                                                                              FontWeight.normal,
                                                                        ),
                                                                  ),
                                                                ),
                                                                collapsed:
                                                                    Container(),
                                                                expanded:
                                                                    Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          25.0,
                                                                          20.0,
                                                                          25.0,
                                                                          0.0),
                                                                  child: FutureBuilder<
                                                                      List<
                                                                          ChatsRecord>>(
                                                                    future:
                                                                        queryChatsRecordOnce(
                                                                      queryBuilder: (chatsRecord) => chatsRecord
                                                                          .where(
                                                                            'chat_type',
                                                                            isEqualTo:
                                                                                'DM',
                                                                          )
                                                                          .where(
                                                                            'users',
                                                                            arrayContains:
                                                                                currentUserReference,
                                                                          )
                                                                          .where(
                                                                            'workspace_ref',
                                                                            isEqualTo:
                                                                                columnWorkspacesRecord.workspaceRef,
                                                                          )
                                                                          .orderBy('last_message_time', descending: true),
                                                                    ),
                                                                    builder:
                                                                        (context,
                                                                            snapshot) {
                                                                      // Customize what your widget looks like when it's loading.
                                                                      if (!snapshot
                                                                          .hasData) {
                                                                        return Center(
                                                                          child:
                                                                              SizedBox(
                                                                            width:
                                                                                50.0,
                                                                            height:
                                                                                50.0,
                                                                            child:
                                                                                CircularProgressIndicator(
                                                                              valueColor: AlwaysStoppedAnimation<Color>(
                                                                                FlutterFlowTheme.of(context).primary,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        );
                                                                      }
                                                                      List<ChatsRecord>
                                                                          columnChatsRecordList =
                                                                          snapshot
                                                                              .data!;
                                                                      return Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children: List.generate(
                                                                            columnChatsRecordList.length,
                                                                            (columnIndex) {
                                                                          final columnChatsRecord =
                                                                              columnChatsRecordList[columnIndex];
                                                                          return InkWell(
                                                                            splashColor:
                                                                                Colors.transparent,
                                                                            focusColor:
                                                                                Colors.transparent,
                                                                            hoverColor:
                                                                                Colors.transparent,
                                                                            highlightColor:
                                                                                Colors.transparent,
                                                                            onTap:
                                                                                () async {
                                                                              setState(() {
                                                                                FFAppState().currentChatRef = columnChatsRecord.reference;
                                                                                FFAppState().currentChatUserRef = columnChatsRecord.users.where((e) => e != currentUserReference).toList().first;
                                                                              });
                                                                              _model.selectedUser = await queryUsersRecordOnce(
                                                                                queryBuilder: (usersRecord) => usersRecord.where(
                                                                                  'user_ref',
                                                                                  isEqualTo: columnChatsRecord.users.where((e) => e != currentUserReference).toList().first,
                                                                                ),
                                                                                singleRecord: true,
                                                                              ).then((s) => s.firstOrNull);
                                                                              setState(() {
                                                                                _model.chatUser = _model.selectedUser;
                                                                              });
                                                                              setState(() {
                                                                                FFAppState().currentMainView = 'Chat';
                                                                              });

                                                                              setState(() {});
                                                                            },
                                                                            child:
                                                                                DirectMessageButtonWidget(
                                                                              key: Key('Key19u_${columnIndex}_of_${columnChatsRecordList.length}'),
                                                                              userRef: columnChatsRecord.users.where((e) => e != currentUserReference).toList().first,
                                                                            ),
                                                                          );
                                                                        }).divide(SizedBox(
                                                                            height:
                                                                                5.0)),
                                                                      );
                                                                    },
                                                                  ),
                                                                ),
                                                                theme:
                                                                    ExpandableThemeData(
                                                                  tapHeaderToExpand:
                                                                      true,
                                                                  tapBodyToExpand:
                                                                      false,
                                                                  tapBodyToCollapse:
                                                                      false,
                                                                  headerAlignment:
                                                                      ExpandablePanelHeaderAlignment
                                                                          .center,
                                                                  hasIcon: true,
                                                                  expandIcon: Icons
                                                                      .keyboard_arrow_right_rounded,
                                                                  collapseIcon:
                                                                      Icons
                                                                          .keyboard_arrow_down_rounded,
                                                                  iconColor: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryText,
                                                                  iconPadding: EdgeInsets
                                                                      .fromLTRB(
                                                                          0.0,
                                                                          0.0,
                                                                          25.0,
                                                                          0.0),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Builder(
                                                        builder: (context) =>
                                                            Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      25.0,
                                                                      25.0,
                                                                      25.0,
                                                                      0.0),
                                                          child: InkWell(
                                                            splashColor: Colors
                                                                .transparent,
                                                            focusColor: Colors
                                                                .transparent,
                                                            hoverColor: Colors
                                                                .transparent,
                                                            highlightColor:
                                                                Colors
                                                                    .transparent,
                                                            onTap: () async {
                                                              await showAlignedDialog(
                                                                barrierColor: Color(
                                                                    0x25000000),
                                                                barrierDismissible:
                                                                    false,
                                                                context:
                                                                    context,
                                                                isGlobal: true,
                                                                avoidOverflow:
                                                                    false,
                                                                targetAnchor:
                                                                    AlignmentDirectional(
                                                                            0.0,
                                                                            0.0)
                                                                        .resolve(
                                                                            Directionality.of(context)),
                                                                followerAnchor:
                                                                    AlignmentDirectional(
                                                                            0.0,
                                                                            0.0)
                                                                        .resolve(
                                                                            Directionality.of(context)),
                                                                builder:
                                                                    (dialogContext) {
                                                                  return Material(
                                                                    color: Colors
                                                                        .transparent,
                                                                    child:
                                                                        GestureDetector(
                                                                      onTap: () => _model
                                                                              .unfocusNode
                                                                              .canRequestFocus
                                                                          ? FocusScope.of(context).requestFocus(_model
                                                                              .unfocusNode)
                                                                          : FocusScope.of(context)
                                                                              .unfocus(),
                                                                      child:
                                                                          StartNewChatWidget(
                                                                        workspaceRef:
                                                                            columnWorkspacesRecord.reference,
                                                                        workspaceId:
                                                                            columnWorkspacesRecord.id,
                                                                        memberList:
                                                                            columnWorkspacesRecord.members,
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                              ).then((value) =>
                                                                  setState(
                                                                      () {}));
                                                            },
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Container(
                                                                  width: 20.0,
                                                                  height: 20.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Color(
                                                                        0xFF32176D),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            2.0),
                                                                  ),
                                                                  child: Icon(
                                                                    Icons
                                                                        .add_rounded,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryBackground,
                                                                    size: 12.0,
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          10.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                  child: Text(
                                                                    'New chat',
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          fontFamily:
                                                                              'Inter',
                                                                          fontSize:
                                                                              16.0,
                                                                          fontWeight:
                                                                              FontWeight.normal,
                                                                        ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ].addToEnd(
                                                        SizedBox(height: 25.0)),
                                                  ),
                                                  theme: ExpandableThemeData(
                                                    tapHeaderToExpand: true,
                                                    tapBodyToExpand: false,
                                                    tapBodyToCollapse: false,
                                                    headerAlignment:
                                                        ExpandablePanelHeaderAlignment
                                                            .center,
                                                    hasIcon: true,
                                                    expandIcon: Icons
                                                        .keyboard_arrow_right_rounded,
                                                    collapseIcon: Icons
                                                        .keyboard_arrow_down_rounded,
                                                    iconColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .secondary,
                                                    iconPadding:
                                                        EdgeInsets.fromLTRB(0.0,
                                                            0.0, 25.0, 0.0),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }).divide(SizedBox(height: 10.0)),
                                        );
                                      },
                                    ),
                                    Builder(
                                      builder: (context) => Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            25.0, 25.0, 25.0, 25.0),
                                        child: InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            await showAlignedDialog(
                                              barrierColor: Color(0x25000000),
                                              barrierDismissible: false,
                                              context: context,
                                              isGlobal: true,
                                              avoidOverflow: false,
                                              targetAnchor:
                                                  AlignmentDirectional(0.0, 0.0)
                                                      .resolve(
                                                          Directionality.of(
                                                              context)),
                                              followerAnchor:
                                                  AlignmentDirectional(0.0, 0.0)
                                                      .resolve(
                                                          Directionality.of(
                                                              context)),
                                              builder: (dialogContext) {
                                                return Material(
                                                  color: Colors.transparent,
                                                  child: GestureDetector(
                                                    onTap: () => _model
                                                            .unfocusNode
                                                            .canRequestFocus
                                                        ? FocusScope.of(context)
                                                            .requestFocus(_model
                                                                .unfocusNode)
                                                        : FocusScope.of(context)
                                                            .unfocus(),
                                                    child:
                                                        CreateWorkspaceWidget(),
                                                  ),
                                                );
                                              },
                                            ).then((value) => setState(() {}));
                                          },
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Container(
                                                width: 20.0,
                                                height: 20.0,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          2.0),
                                                ),
                                                child: Icon(
                                                  Icons.add_rounded,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryBackground,
                                                  size: 12.0,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        10.0, 0.0, 0.0, 0.0),
                                                child: Text(
                                                  'Add workspace',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Inter',
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else {
                            return Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 25.0, 0.0, 0.0),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          25.0, 0.0, 25.0, 0.0),
                                      child: FutureBuilder<List<ChatsRecord>>(
                                        future: queryChatsRecordOnce(
                                          queryBuilder: (chatsRecord) =>
                                              chatsRecord
                                                  .where(
                                                    'users',
                                                    arrayContains:
                                                        currentUserReference,
                                                  )
                                                  .orderBy('last_message_time',
                                                      descending: true),
                                        ),
                                        builder: (context, snapshot) {
                                          // Customize what your widget looks like when it's loading.
                                          if (!snapshot.hasData) {
                                            return Center(
                                              child: SizedBox(
                                                width: 50.0,
                                                height: 50.0,
                                                child:
                                                    CircularProgressIndicator(
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                          Color>(
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                  ),
                                                ),
                                              ),
                                            );
                                          }
                                          List<ChatsRecord>
                                              columnChatsRecordList =
                                              snapshot.data!;
                                          return SingleChildScrollView(
                                            primary: false,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: List.generate(
                                                  columnChatsRecordList.length,
                                                  (columnIndex) {
                                                final columnChatsRecord =
                                                    columnChatsRecordList[
                                                        columnIndex];
                                                return Builder(
                                                  builder: (context) {
                                                    if (columnChatsRecord
                                                            .chatType ==
                                                        'Channel') {
                                                      return InkWell(
                                                        splashColor:
                                                            Colors.transparent,
                                                        focusColor:
                                                            Colors.transparent,
                                                        hoverColor:
                                                            Colors.transparent,
                                                        highlightColor:
                                                            Colors.transparent,
                                                        onTap: () async {
                                                          setState(() {
                                                            FFAppState()
                                                                    .currentChatRef =
                                                                columnChatsRecord
                                                                    .reference;
                                                            FFAppState()
                                                                    .currentChatUserRef =
                                                                null;
                                                          });
                                                          setState(() {
                                                            _model.chatUser =
                                                                null;
                                                            _model.selectedChannel =
                                                                columnChatsRecord
                                                                    .channelName;
                                                          });
                                                          setState(() {
                                                            FFAppState()
                                                                    .currentMainView =
                                                                'Chat';
                                                          });
                                                        },
                                                        child:
                                                            ChannelButtonWidget(
                                                          key: Key(
                                                              'Keytaz_${columnIndex}_of_${columnChatsRecordList.length}'),
                                                          channelName:
                                                              columnChatsRecord
                                                                  .channelName,
                                                        ),
                                                      );
                                                    } else {
                                                      return InkWell(
                                                        splashColor:
                                                            Colors.transparent,
                                                        focusColor:
                                                            Colors.transparent,
                                                        hoverColor:
                                                            Colors.transparent,
                                                        highlightColor:
                                                            Colors.transparent,
                                                        onTap: () async {
                                                          setState(() {
                                                            FFAppState()
                                                                    .currentChatRef =
                                                                columnChatsRecord
                                                                    .reference;
                                                            FFAppState()
                                                                    .currentChatUserRef =
                                                                columnChatsRecord
                                                                    .users
                                                                    .where((e) =>
                                                                        e !=
                                                                        currentUserReference)
                                                                    .toList()
                                                                    .first;
                                                          });
                                                          _model.selectedUserChats =
                                                              await queryUsersRecordOnce(
                                                            queryBuilder:
                                                                (usersRecord) =>
                                                                    usersRecord
                                                                        .where(
                                                              'user_ref',
                                                              isEqualTo: columnChatsRecord
                                                                  .users
                                                                  .where((e) =>
                                                                      e !=
                                                                      currentUserReference)
                                                                  .toList()
                                                                  .first,
                                                            ),
                                                            singleRecord: true,
                                                          ).then((s) => s
                                                                  .firstOrNull);
                                                          setState(() {
                                                            _model.chatUser = _model
                                                                .selectedUserChats;
                                                          });
                                                          setState(() {
                                                            FFAppState()
                                                                    .currentMainView =
                                                                'Chat';
                                                          });

                                                          setState(() {});
                                                        },
                                                        child:
                                                            DirectMessageButtonWidget(
                                                          key: Key(
                                                              'Keykj8_${columnIndex}_of_${columnChatsRecordList.length}'),
                                                          userRef: columnChatsRecord
                                                              .users
                                                              .where((e) =>
                                                                  e !=
                                                                  currentUserReference)
                                                              .toList()
                                                              .first,
                                                        ),
                                                      );
                                                    }
                                                  },
                                                );
                                              }),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Builder(
                                      builder: (context) => Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            25.0, 25.0, 25.0, 25.0),
                                        child: InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            await showAlignedDialog(
                                              barrierColor: Color(0x25000000),
                                              barrierDismissible: false,
                                              context: context,
                                              isGlobal: true,
                                              avoidOverflow: false,
                                              targetAnchor:
                                                  AlignmentDirectional(0.0, 0.0)
                                                      .resolve(
                                                          Directionality.of(
                                                              context)),
                                              followerAnchor:
                                                  AlignmentDirectional(0.0, 0.0)
                                                      .resolve(
                                                          Directionality.of(
                                                              context)),
                                              builder: (dialogContext) {
                                                return Material(
                                                  color: Colors.transparent,
                                                  child: GestureDetector(
                                                    onTap: () => _model
                                                            .unfocusNode
                                                            .canRequestFocus
                                                        ? FocusScope.of(context)
                                                            .requestFocus(_model
                                                                .unfocusNode)
                                                        : FocusScope.of(context)
                                                            .unfocus(),
                                                    child: StartNewChatWidget(),
                                                  ),
                                                );
                                              },
                                            ).then((value) => setState(() {}));
                                          },
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Container(
                                                width: 20.0,
                                                height: 20.0,
                                                decoration: BoxDecoration(
                                                  color: Color(0xFF32176D),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          2.0),
                                                ),
                                                child: Icon(
                                                  Icons.add_rounded,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryBackground,
                                                  size: 12.0,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        10.0, 0.0, 0.0, 0.0),
                                                child: Text(
                                                  'New chat',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Inter',
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
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
              Expanded(
                child: Builder(
                  builder: (context) {
                    if (FFAppState().currentMainView == 'Chat') {
                      return Builder(
                        builder: (context) {
                          if (!((FFAppState().currentChatRef == null) &&
                              (FFAppState().currentChatUserRef == null))) {
                            return Stack(
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  child: custom_widgets.CustomChatContainer(
                                    width: double.infinity,
                                    height: double.infinity,
                                    chatUser: _model.chatUser,
                                    chatRef: FFAppState().currentChatRef,
                                    channelName: _model.selectedChannel,
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 75.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Builder(
                                        builder: (context) {
                                          if (_model.chatUser != null) {
                                            return Builder(
                                              builder: (context) => Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        25.0, 25.0, 0.0, 0.0),
                                                child: FutureBuilder<
                                                    List<UsersRecord>>(
                                                  future: queryUsersRecordOnce(
                                                    queryBuilder:
                                                        (usersRecord) =>
                                                            usersRecord.where(
                                                      'user_ref',
                                                      isEqualTo: _model
                                                          .chatUser?.reference,
                                                    ),
                                                    singleRecord: true,
                                                  ),
                                                  builder: (context, snapshot) {
                                                    // Customize what your widget looks like when it's loading.
                                                    if (!snapshot.hasData) {
                                                      return Center(
                                                        child: SizedBox(
                                                          width: 50.0,
                                                          height: 50.0,
                                                          child:
                                                              CircularProgressIndicator(
                                                            valueColor:
                                                                AlwaysStoppedAnimation<
                                                                    Color>(
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .primary,
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                    List<UsersRecord>
                                                        rowUsersRecordList =
                                                        snapshot.data!;
                                                    // Return an empty Container when the item does not exist.
                                                    if (snapshot
                                                        .data!.isEmpty) {
                                                      return Container();
                                                    }
                                                    final rowUsersRecord =
                                                        rowUsersRecordList
                                                                .isNotEmpty
                                                            ? rowUsersRecordList
                                                                .first
                                                            : null;
                                                    return InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        await showAlignedDialog(
                                                          context: context,
                                                          isGlobal: true,
                                                          avoidOverflow: false,
                                                          targetAnchor:
                                                              AlignmentDirectional(
                                                                      0.0, 0.0)
                                                                  .resolve(
                                                                      Directionality.of(
                                                                          context)),
                                                          followerAnchor:
                                                              AlignmentDirectional(
                                                                      0.0, 0.0)
                                                                  .resolve(
                                                                      Directionality.of(
                                                                          context)),
                                                          builder:
                                                              (dialogContext) {
                                                            return Material(
                                                              color: Colors
                                                                  .transparent,
                                                              child:
                                                                  GestureDetector(
                                                                onTap: () => _model
                                                                        .unfocusNode
                                                                        .canRequestFocus
                                                                    ? FocusScope.of(
                                                                            context)
                                                                        .requestFocus(_model
                                                                            .unfocusNode)
                                                                    : FocusScope.of(
                                                                            context)
                                                                        .unfocus(),
                                                                child:
                                                                    UserDetailsWidget(
                                                                  userDocs:
                                                                      rowUsersRecord!,
                                                                  chatRef:
                                                                      FFAppState()
                                                                          .currentChatRef!,
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        ).then((value) =>
                                                            setState(() {}));
                                                      },
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        3.0),
                                                            child:
                                                                Image.network(
                                                              rowUsersRecord!
                                                                  .photoUrl,
                                                              width: 25.0,
                                                              height: 25.0,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        10.0,
                                                                        0.0,
                                                                        0.0,
                                                                        0.0),
                                                            child: Text(
                                                              rowUsersRecord!
                                                                  .displayName
                                                                  .maybeHandleOverflow(
                                                                maxChars: 18,
                                                                replacement:
                                                                    '…',
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Inter',
                                                                    fontSize:
                                                                        16.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                  ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            );
                                          } else {
                                            return Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      25.0, 25.0, 25.0, 0.0),
                                              child: StreamBuilder<
                                                  List<ChatsRecord>>(
                                                stream: queryChatsRecord(
                                                  queryBuilder: (chatsRecord) =>
                                                      chatsRecord.where(
                                                    'chat_ref',
                                                    isEqualTo: FFAppState()
                                                        .currentChatRef,
                                                  ),
                                                  singleRecord: true,
                                                ),
                                                builder: (context, snapshot) {
                                                  // Customize what your widget looks like when it's loading.
                                                  if (!snapshot.hasData) {
                                                    return Center(
                                                      child: SizedBox(
                                                        width: 50.0,
                                                        height: 50.0,
                                                        child:
                                                            CircularProgressIndicator(
                                                          valueColor:
                                                              AlwaysStoppedAnimation<
                                                                  Color>(
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  }
                                                  List<ChatsRecord>
                                                      rowChatsRecordList =
                                                      snapshot.data!;
                                                  // Return an empty Container when the item does not exist.
                                                  if (snapshot.data!.isEmpty) {
                                                    return Container();
                                                  }
                                                  final rowChatsRecord =
                                                      rowChatsRecordList
                                                              .isNotEmpty
                                                          ? rowChatsRecordList
                                                              .first
                                                          : null;
                                                  return Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Builder(
                                                        builder: (context) =>
                                                            InkWell(
                                                          splashColor: Colors
                                                              .transparent,
                                                          focusColor: Colors
                                                              .transparent,
                                                          hoverColor: Colors
                                                              .transparent,
                                                          highlightColor: Colors
                                                              .transparent,
                                                          onTap: () async {
                                                            await showAlignedDialog(
                                                              context: context,
                                                              isGlobal: true,
                                                              avoidOverflow:
                                                                  false,
                                                              targetAnchor:
                                                                  AlignmentDirectional(
                                                                          0.0,
                                                                          0.0)
                                                                      .resolve(
                                                                          Directionality.of(
                                                                              context)),
                                                              followerAnchor:
                                                                  AlignmentDirectional(
                                                                          0.0,
                                                                          0.0)
                                                                      .resolve(
                                                                          Directionality.of(
                                                                              context)),
                                                              builder:
                                                                  (dialogContext) {
                                                                return Material(
                                                                  color: Colors
                                                                      .transparent,
                                                                  child:
                                                                      GestureDetector(
                                                                    onTap: () => _model
                                                                            .unfocusNode
                                                                            .canRequestFocus
                                                                        ? FocusScope.of(context).requestFocus(_model
                                                                            .unfocusNode)
                                                                        : FocusScope.of(context)
                                                                            .unfocus(),
                                                                    child:
                                                                        WorkspaceDetailWidget(
                                                                      chatRef:
                                                                          rowChatsRecord!
                                                                              .reference,
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                            ).then((value) =>
                                                                setState(
                                                                    () {}));
                                                          },
                                                          child: Text(
                                                            rowChatsRecord!
                                                                .channelName
                                                                .maybeHandleOverflow(
                                                              maxChars: 18,
                                                              replacement: '…',
                                                            ),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Inter',
                                                                  fontSize:
                                                                      16.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                      Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          StreamBuilder<
                                                              List<
                                                                  UsersRecord>>(
                                                            stream:
                                                                queryUsersRecord(
                                                              queryBuilder: (usersRecord) =>
                                                                  usersRecord.whereIn(
                                                                      'user_ref',
                                                                      rowChatsRecord
                                                                          ?.users),
                                                              limit: 3,
                                                            ),
                                                            builder: (context,
                                                                snapshot) {
                                                              // Customize what your widget looks like when it's loading.
                                                              if (!snapshot
                                                                  .hasData) {
                                                                return Center(
                                                                  child:
                                                                      SizedBox(
                                                                    width: 50.0,
                                                                    height:
                                                                        50.0,
                                                                    child:
                                                                        CircularProgressIndicator(
                                                                      valueColor:
                                                                          AlwaysStoppedAnimation<
                                                                              Color>(
                                                                        FlutterFlowTheme.of(context)
                                                                            .primary,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              }
                                                              List<UsersRecord>
                                                                  rowUsersRecordList =
                                                                  snapshot
                                                                      .data!;
                                                              return Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: List.generate(
                                                                    rowUsersRecordList
                                                                        .length,
                                                                    (rowIndex) {
                                                                  final rowUsersRecord =
                                                                      rowUsersRecordList[
                                                                          rowIndex];
                                                                  return ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            3.0),
                                                                    child: Image
                                                                        .network(
                                                                      rowUsersRecord
                                                                          .photoUrl,
                                                                      width:
                                                                          25.0,
                                                                      height:
                                                                          25.0,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                                  );
                                                                }).divide(
                                                                    SizedBox(
                                                                        width:
                                                                            5.0)),
                                                              );
                                                            },
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        20.0,
                                                                        0.0,
                                                                        0.0,
                                                                        0.0),
                                                            child: Text(
                                                              valueOrDefault<
                                                                  String>(
                                                                rowChatsRecord
                                                                    ?.users
                                                                    ?.length
                                                                    ?.toString(),
                                                                'N/A',
                                                              ).maybeHandleOverflow(
                                                                maxChars: 18,
                                                                replacement:
                                                                    '…',
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Inter',
                                                                    fontSize:
                                                                        16.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                  ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  );
                                                },
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                      Divider(
                                        height: 0.0,
                                        thickness: 1.0,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return wrapWithModel(
                              model: _model.emptyChatWidgetModel,
                              updateCallback: () => setState(() {}),
                              child: EmptyChatWidgetWidget(),
                            );
                          }
                        },
                      );
                    } else if (FFAppState().currentMainView == 'Overview') {
                      return StreamBuilder<List<WorkspacesRecord>>(
                        stream: queryWorkspacesRecord(
                          queryBuilder: (workspacesRecord) =>
                              workspacesRecord.where(
                            'workspace_ref',
                            isEqualTo: _model.workspaceRef,
                          ),
                          singleRecord: true,
                        ),
                        builder: (context, snapshot) {
                          // Customize what your widget looks like when it's loading.
                          if (!snapshot.hasData) {
                            return Center(
                              child: SizedBox(
                                width: 40.0,
                                height: 40.0,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    FlutterFlowTheme.of(context).primary,
                                  ),
                                ),
                              ),
                            );
                          }
                          List<WorkspacesRecord> overviewWorkspacesRecordList =
                              snapshot.data!;
                          // Return an empty Container when the item does not exist.
                          if (snapshot.data!.isEmpty) {
                            return Container();
                          }
                          final overviewWorkspacesRecord =
                              overviewWorkspacesRecordList.isNotEmpty
                                  ? overviewWorkspacesRecordList.first
                                  : null;
                          return wrapWithModel(
                            model: _model.overviewModel,
                            updateCallback: () => setState(() {}),
                            child: OverviewWidget(
                              selectedWorkspaceOverview:
                                  overviewWorkspacesRecord!.overview,
                              workspaceMembers:
                                  overviewWorkspacesRecord!.members,
                              workspaceFiles: overviewWorkspacesRecord!.files,
                              workspaceRef: overviewWorkspacesRecord!.reference,
                              workspaceName: overviewWorkspacesRecord!.name,
                              chatRefs: overviewWorkspacesRecord!.chatRefs,
                            ),
                          );
                        },
                      );
                    } else {
                      return Align(
                        alignment: AlignmentDirectional(0.00, 0.00),
                        child: Container(
                          width: 50.0,
                          height: 50.0,
                          child: custom_widgets.FFlowSpinner(
                            width: 50.0,
                            height: 50.0,
                            backgroundColor: Colors.transparent,
                            spinnerColor: FlutterFlowTheme.of(context).primary,
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
      ),
    );
  }
}
