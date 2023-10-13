import 'package:flutter/material.dart';

import '../constants.dart';
import 'appointment_tab_row.dart';
import 'note_text_area.dart';

class ScheduleNote extends StatefulWidget {
  const ScheduleNote({
    Key? key,
  }) : super(key: key);

  @override
  State<ScheduleNote> createState() => _ScheduleNoteState();
}

class _ScheduleNoteState extends State<ScheduleNote> {
  bool isNoteEditable = true;
  final notesController = TextEditingController();

  @override
  void dispose() {
    notesController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    notesController.text = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20 * screenWidth,
          vertical: 19 * screenHeight,
        ),
        // height: 183 * screenHeight,
        width: 383 * screenWidth,
        decoration: BoxDecoration(
          color: sectionColor,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            AppointmentTabRow(tabTitle: 'Notes', isCustomVisible: false),
            SizedBox(height: 16 * screenHeight),
            NoteTextArea(
              isNoteEditable: isNoteEditable,
              controller: notesController,
            ),
            SizedBox(height: 21 * screenHeight),
            Padding(
              padding: EdgeInsets.only(left: screenWidth * 11.0),
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                  setState(() {
                    isNoteEditable = !isNoteEditable;
                    if (isNoteEditable == false) {
                      jobApplicationNote = notesController.text.trim();
                    }
                  });
                },
                child: Container(
                  height: 47 * screenHeight,
                  width: 324 * screenWidth,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9),
                    color: primary,
                  ),
                  child: Center(
                    child: Text(
                      isNoteEditable ? 'Add Note' : 'Edit Note',
                      style: TextStyle(
                        color: white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
