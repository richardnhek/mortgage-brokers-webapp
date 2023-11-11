// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

class CustomMemberSelectorV2 extends StatefulWidget {
  const CustomMemberSelectorV2({
    Key? key,
    this.width,
    this.height,
    required this.userDocsList,
  }) : super(key: key);

  final double? width;
  final double? height;
  final List<UsersRecord> userDocsList;

  @override
  _CustomMemberSelectorV2State createState() => _CustomMemberSelectorV2State();
}

class _CustomMemberSelectorV2State extends State<CustomMemberSelectorV2> {
  final TextEditingController _controller = TextEditingController();
  List<UsersRecord> _selectedUsers = [];
  late FocusNode _focusNode;
  String _filter = '';

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _addUserChip(UsersRecord user) {
    if (!_selectedUsers
        .any((selectedUser) => selectedUser.userRef == user.userRef)) {
      setState(() {
        _selectedUsers.add(user);
        _controller.clear();
        _filter = '';
        FFAppState().selectedMembers.add(user.reference);
      });
    }
  }

  void _removeUserChip(UsersRecord user) {
    setState(() {
      _selectedUsers.remove(user);
      FFAppState().selectedMembers.remove(user.reference);
    });
  }

  Widget _buildChips() {
    List<Widget> chips = _selectedUsers.map((user) {
      return InputChip(
        label: Text(user.displayName),
        onDeleted: () => _removeUserChip(user),
      );
    }).toList();

    return Wrap(
      spacing: 8.0,
      runSpacing: 4.0,
      children: chips,
    );
  }

  @override
  Widget build(BuildContext context) {
    // List<UsersRecord> filteredList = widget.userDocsList.where((user) {
    //   return user.displayName.toLowerCase().contains(_filter.toLowerCase());
    // }).toList();
    List<UsersRecord> filteredList = widget.userDocsList.where((user) {
      return user.displayName.toLowerCase().contains(_filter.toLowerCase()) &&
          !_selectedUsers
              .any((selectedUser) => selectedUser.userRef == user.userRef);
    }).toList();

    return Column(
      children: [
        GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(_focusNode);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            constraints: BoxConstraints(minHeight: 50),
            decoration: BoxDecoration(),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildChips(),
                TextField(
                  controller: _controller,
                  focusNode: _focusNode,
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: 'Enter member name',
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    setState(() {
                      _filter = value;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: filteredList.length,
            itemBuilder: (context, index) {
              var user = filteredList[index];
              return ListTile(
                title: Text(user.displayName),
                onTap: () {
                  _addUserChip(user);
                  FocusScope.of(context).requestFocus(_focusNode);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
