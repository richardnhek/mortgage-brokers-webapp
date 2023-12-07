// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

class CustomMemberSelector extends StatefulWidget {
  const CustomMemberSelector({
    Key? key,
    this.width,
    this.height,
    this.userDocsList,
  }) : super(key: key);

  final double? width;
  final double? height;
  final List<UsersRecord>? userDocsList;

  @override
  _CustomMemberSelectorState createState() => _CustomMemberSelectorState();
}

class _CustomMemberSelectorState extends State<CustomMemberSelector> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  List<UsersRecord> _selectedUsers = [];

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _addUserChip(UsersRecord user) {
    setState(() {
      _selectedUsers.add(user);
      _controller.clear();
    });
    print("Add user: $user");
  }

  void _removeUserChip(UsersRecord user) {
    setState(() {
      _selectedUsers.remove(user);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          spacing: 6.0,
          runSpacing: 6.0,
          children: _selectedUsers.map((user) {
            return Chip(
              label: Text(user.displayName),
              onDeleted: () => _removeUserChip(user),
            );
          }).toList(),
        ),
        TextField(
          controller: _controller,
          focusNode: _focusNode,
          decoration: InputDecoration(
            hintText: 'Enter member name',
          ),
          onChanged: (value) {
            // Implement your filtering logic here if necessary
            setState(() {});
          },
        ),
        Visibility(
          visible: _focusNode.hasFocus,
          child: Expanded(
            child: ListView.builder(
              itemCount: widget.userDocsList?.length ?? 0,
              itemBuilder: (context, index) {
                var user = widget.userDocsList![index];
                // Implement your filtering logic here based on _controller.text
                return ListTile(
                  title: Text(user.displayName),
                  onTap: () => _addUserChip(user),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
