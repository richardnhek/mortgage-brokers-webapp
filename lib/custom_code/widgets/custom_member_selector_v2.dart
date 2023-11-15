// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:textfield_tags/textfield_tags.dart';

import 'index.dart'; // Imports other custom widgets

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
  late double _distanceToField;
  late TextfieldTagsController _controller;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _distanceToField = MediaQuery.of(context).size.width;
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = TextfieldTagsController();
  }

  @override
  Widget build(BuildContext context) {
    final List<UsersRecord> _pickUser = widget.userDocsList;
    return SizedBox(
      width: widget.width ?? 340,
      child: Autocomplete<UsersRecord>(
        optionsViewBuilder: (context, onSelected, options) {
          return Align(
            alignment: const Alignment(-1, -1.07),
            child: Material(
              child: Container(
                width: widget.width ?? 340,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: options.length,
                  itemBuilder: (BuildContext context, int index) {
                    final UsersRecord option = options.elementAt(index);
                    return ListTile(
                      tileColor: Colors.white,
                      title: Text(option.displayName),
                      subtitle: Text(option
                          .email), // Assuming 'email' is a field in UsersRecord
                      onTap: () {
                        onSelected(option);
                        setState(() {
                          FFAppState().selectedMembers.add(option.reference);
                        });

                        for (var member in FFAppState().selectedMembers) {
                          print(
                              "Added members: ${member.id}"); // Replace 'email' with the property you want to print
                        }
                      },
                    );
                  },
                ),
              ),
            ),
          );
        },
        optionsBuilder: (TextEditingValue textEditingValue) {
          if (textEditingValue.text == '') {
            return const Iterable<UsersRecord>.empty();
          }
          return _pickUser.where((UsersRecord option) {
            return option.displayName
                .toLowerCase()
                .contains(textEditingValue.text.toLowerCase());
          });
        },
        onSelected: (UsersRecord selectedTag) {
          _controller.addTag = selectedTag.email;
        },
        fieldViewBuilder: (context, ttec, tfn, onFieldSubmitted) {
          return TextFieldTags(
            textEditingController: ttec,
            focusNode: tfn,
            textfieldTagsController: _controller,
            textSeparators: const [' ', ','],
            letterCase: LetterCase.normal,
            validator: (String tag) {
              if (_controller.getTags!.contains(tag)) {
                final userToRemove = widget.userDocsList.firstWhereOrNull(
                  (user) => user.email == tag,
                );
                if (userToRemove != null) {
                  setState(() {
                    FFAppState().selectedMembers.remove(userToRemove.reference);
                  });
                }
                return 'Member already selected';
              }
              return null;
            },
            inputfieldBuilder:
                (context, tec, fn, error, onChanged, onSubmitted) {
              return ((context, sc, tags, onTagDelete) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextField(
                    controller: tec,
                    focusNode: fn,
                    decoration: InputDecoration(
                      enabledBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText: _controller.hasTags ? '' : "Select member...",
                      hintStyle: GoogleFonts.inter(
                          color: FlutterFlowTheme.of(context).darkGrey2,
                          fontSize: 15.0,
                          fontWeight: FontWeight.normal),
                      errorText: error,
                      prefixIconConstraints:
                          BoxConstraints(maxWidth: _distanceToField * 0.2),
                      prefixIcon: tags.isNotEmpty
                          ? SingleChildScrollView(
                              controller: sc,
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                  children: tags.map((String tag) {
                                return Container(
                                  height: 36,
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(5.0),
                                      ),
                                      border: Border.all(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        width: 1.0,
                                      ),
                                      color: Color(0x2651A781)),
                                  margin: const EdgeInsets.only(right: 10.0),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        tag,
                                        style: GoogleFonts.inter(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      const SizedBox(width: 10),
                                      InkWell(
                                        child: Container(
                                          width: 20,
                                          height: 20,
                                          decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(4.0),
                                              ),
                                              color: Color(0xFF51A781)),
                                          child: const Center(
                                            child: Icon(
                                              CupertinoIcons.clear,
                                              size: 12,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        onTap: () {
                                          final userToRemove = widget
                                              .userDocsList
                                              .firstWhereOrNull(
                                            (user) => user.email == tag,
                                          );
                                          if (userToRemove != null) {
                                            setState(() {
                                              FFAppState()
                                                  .selectedMembers
                                                  .remove(
                                                      userToRemove.reference);
                                              print(
                                                  "Deleted member: ${userToRemove.displayName}");
                                            });
                                          }
                                          onTagDelete(tag);
                                          print(
                                              "Remaining members: ${FFAppState().selectedMembers}");
                                        },
                                      )
                                    ],
                                  ),
                                );
                              }).toList()),
                            )
                          : null,
                    ),
                    onChanged: onChanged,
                    onSubmitted: onSubmitted,
                  ),
                );
              });
            },
          );
        },
      ),
    );
  }
}
