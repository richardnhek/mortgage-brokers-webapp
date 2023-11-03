import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/channel_button_widget.dart';
import '/components/direct_message_button_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'workspace_expandable_model.dart';
export 'workspace_expandable_model.dart';

class WorkspaceExpandableWidget extends StatefulWidget {
  const WorkspaceExpandableWidget({Key? key}) : super(key: key);

  @override
  _WorkspaceExpandableWidgetState createState() =>
      _WorkspaceExpandableWidgetState();
}

class _WorkspaceExpandableWidgetState extends State<WorkspaceExpandableWidget> {
  late WorkspaceExpandableModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => WorkspaceExpandableModel());

    _model.expandableController1 = ExpandableController(initialExpanded: false);
    _model.expandableController2 = ExpandableController(initialExpanded: false);
    _model.expandableController3 = ExpandableController(initialExpanded: false);
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: FlutterFlowTheme.of(context).darkGray1,
      child: ExpandableNotifier(
        controller: _model.expandableController1,
        child: ExpandablePanel(
          header: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(25.0, 25.0, 0.0, 25.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Icon(
                  Icons.lock_outline,
                  color: FlutterFlowTheme.of(context).secondary,
                  size: 21.0,
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                  child: Text(
                    'Wallace & William',
                    style: FlutterFlowTheme.of(context).displaySmall.override(
                          fontFamily: 'Inter',
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.normal,
                        ),
                  ),
                ),
              ],
            ),
          ),
          collapsed: Container(),
          expanded: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(25.0, 0.0, 25.0, 0.0),
                child: Container(
                  width: double.infinity,
                  height: 40.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primaryBackground,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 4.0,
                        color: Color(0x0E000000),
                        offset: Offset(0.0, 4.0),
                      )
                    ],
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(
                      color: FlutterFlowTheme.of(context).tertiary,
                      width: 1.0,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(5.0, 5.0, 5.0, 5.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Icon(
                          Icons.auto_awesome_outlined,
                          color: FlutterFlowTheme.of(context).secondary,
                          size: 21.0,
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              10.0, 0.0, 0.0, 0.0),
                          child: Text(
                            'Overview',
                            style: FlutterFlowTheme.of(context)
                                .displaySmall
                                .override(
                                  fontFamily: 'Inter',
                                  color: Colors.black,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.normal,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 25.0, 0.0, 0.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                  child: Container(
                    width: double.infinity,
                    color: Colors.transparent,
                    child: ExpandableNotifier(
                      controller: _model.expandableController2,
                      child: ExpandablePanel(
                        header: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              25.0, 0.0, 0.0, 0.0),
                          child: Text(
                            'Channels',
                            style: FlutterFlowTheme.of(context)
                                .displaySmall
                                .override(
                                  fontFamily: 'Inter',
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.normal,
                                ),
                          ),
                        ),
                        collapsed: Container(),
                        expanded: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              25.0, 20.0, 25.0, 0.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              wrapWithModel(
                                model: _model.channelButtonModel1,
                                updateCallback: () => setState(() {}),
                                child: ChannelButtonWidget(),
                              ),
                              wrapWithModel(
                                model: _model.channelButtonModel2,
                                updateCallback: () => setState(() {}),
                                child: ChannelButtonWidget(),
                              ),
                              wrapWithModel(
                                model: _model.channelButtonModel3,
                                updateCallback: () => setState(() {}),
                                child: ChannelButtonWidget(),
                              ),
                            ].divide(SizedBox(height: 5.0)),
                          ),
                        ),
                        theme: ExpandableThemeData(
                          tapHeaderToExpand: true,
                          tapBodyToExpand: false,
                          tapBodyToCollapse: false,
                          headerAlignment:
                              ExpandablePanelHeaderAlignment.center,
                          hasIcon: true,
                          expandIcon: Icons.keyboard_arrow_right_rounded,
                          collapseIcon: Icons.keyboard_arrow_down_rounded,
                          iconColor: FlutterFlowTheme.of(context).secondaryText,
                          iconPadding: EdgeInsets.fromLTRB(0.0, 0.0, 25.0, 0.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 25.0, 0.0, 0.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                  child: Container(
                    width: double.infinity,
                    color: Colors.transparent,
                    child: ExpandableNotifier(
                      controller: _model.expandableController3,
                      child: ExpandablePanel(
                        header: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              25.0, 0.0, 0.0, 0.0),
                          child: Text(
                            'Direct messages',
                            style: FlutterFlowTheme.of(context)
                                .displaySmall
                                .override(
                                  fontFamily: 'Inter',
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.normal,
                                ),
                          ),
                        ),
                        collapsed: Container(),
                        expanded: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              25.0, 20.0, 25.0, 0.0),
                          child: StreamBuilder<List<UsersRecord>>(
                            stream: queryUsersRecord(),
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
                              List<UsersRecord> columnUsersRecordList = snapshot
                                  .data!
                                  .where((u) => u.uid != currentUserUid)
                                  .toList();
                              return Column(
                                mainAxisSize: MainAxisSize.max,
                                children:
                                    List.generate(columnUsersRecordList.length,
                                        (columnIndex) {
                                  final columnUsersRecord =
                                      columnUsersRecordList[columnIndex];
                                  return DirectMessageButtonWidget(
                                    key: Key(
                                        'Key3q1_${columnIndex}_of_${columnUsersRecordList.length}'),
                                    userRef: currentUserReference!,
                                  );
                                }).divide(SizedBox(height: 5.0)),
                              );
                            },
                          ),
                        ),
                        theme: ExpandableThemeData(
                          tapHeaderToExpand: true,
                          tapBodyToExpand: false,
                          tapBodyToCollapse: false,
                          headerAlignment:
                              ExpandablePanelHeaderAlignment.center,
                          hasIcon: true,
                          expandIcon: Icons.keyboard_arrow_right_rounded,
                          collapseIcon: Icons.keyboard_arrow_down_rounded,
                          iconColor: FlutterFlowTheme.of(context).secondaryText,
                          iconPadding: EdgeInsets.fromLTRB(0.0, 0.0, 25.0, 0.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ].addToEnd(SizedBox(height: 25.0)),
          ),
          theme: ExpandableThemeData(
            tapHeaderToExpand: true,
            tapBodyToExpand: false,
            tapBodyToCollapse: false,
            headerAlignment: ExpandablePanelHeaderAlignment.center,
            hasIcon: true,
            expandIcon: Icons.keyboard_arrow_right_rounded,
            collapseIcon: Icons.keyboard_arrow_down_rounded,
            iconColor: FlutterFlowTheme.of(context).secondary,
            iconPadding: EdgeInsets.fromLTRB(0.0, 0.0, 25.0, 0.0),
          ),
        ),
      ),
    );
  }
}
