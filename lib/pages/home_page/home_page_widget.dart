import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/components/channel_button_widget.dart';
import '/components/create_workspace_widget.dart';
import '/components/direct_message_button_widget.dart';
import '/components/empty_chat_widget_widget.dart';
import '/components/main_web_nav_widget.dart';
import '/components/overview_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
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
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            25.0, 25.0, 25.0, 25.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'My workspaces',
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
                    Align(
                      alignment: AlignmentDirectional(-1.00, -1.00),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            25.0, 40.0, 0.0, 0.0),
                        child: Text(
                          'Workspaces',
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                fontFamily: 'Inter',
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                fontSize: 16.0,
                                fontWeight: FontWeight.normal,
                              ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 25.0, 0.0, 0.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
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
                                                            setState(() {
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
                                                                          ),
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
                                                                          ),
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
                                          }),
                                        );
                                      },
                                    ),
                                    Builder(
                                      builder: (context) => Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            25.0, 25.0, 25.0, 0.0),
                                        child: InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            await showAlignedDialog(
                                              barrierColor: Color(0x25000000),
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
                            ),
                          ].addToEnd(SizedBox(height: 25.0)),
                        ),
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
                            return Container(
                              width: double.infinity,
                              height: double.infinity,
                              child: custom_widgets.CustomChatContainer(
                                width: double.infinity,
                                height: double.infinity,
                                chatUser: _model.chatUser,
                                chatRef: FFAppState().currentChatRef,
                                // CUSTOM_CODE_STARTED
                                key: ValueKey(
                                    '${_model.chatUser ?? 'null'}-${_model.chatRef?.id}'),
                                // CUSTOM_CODE_ENDED
                              ),
                            );
                          } else {
                            return wrapWithModel(
                              model: _model.emptyChatWidgetModel1,
                              updateCallback: () => setState(() {}),
                              child: EmptyChatWidgetWidget(),
                            );
                          }
                        },
                      );
                    } else if (FFAppState().currentMainView == 'Overview') {
                      return wrapWithModel(
                        model: _model.overviewModel,
                        updateCallback: () => setState(() {}),
                        child: OverviewWidget(
                          selectedWorkspaceOverview: _model.selectedOverview!,
                          workspaceMembers: _model.workspaceMembers,
                          workspaceFiles: _model.workspaceFiles,
                          workspaceRef: _model.workspaceRef!,
                        ),
                      );
                    } else {
                      return wrapWithModel(
                        model: _model.emptyChatWidgetModel2,
                        updateCallback: () => setState(() {}),
                        child: EmptyChatWidgetWidget(),
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
