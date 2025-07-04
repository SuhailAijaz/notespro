import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:notes_pro/home_screen.dart';
import 'package:notes_pro/utils/app_widgets.dart';

import 'note.dart';

class CreateNoteScreen extends StatefulWidget {
  final bool isEditable;

  const CreateNoteScreen({super.key, required this.isEditable});

  @override
  State<CreateNoteScreen> createState() => _CreateNoteScreenState();
}

class _CreateNoteScreenState extends State<CreateNoteScreen> {
  final _formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var subjController = TextEditingController();
  var noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: customLargeText(textValue: "Add Notes"),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              customTextField(
                controller: titleController,
                hintText: "Enter Title",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter title";
                  }
                  return null;
                },
              ),
              spaceY(height: 15),
              customTextField(
                controller: subjController,
                hintText: "Enter Subject",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter subject";
                  }
                  return null;
                },
              ),
              spaceY(height: 15),
              customTextField(
                controller: noteController,
                maxLines: 10,
                hintText: "Write Note",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please add note";
                  }
                  return null;
                },
              ),
              spaceY(height: 20),
              customElevatedButton(
                textValue: widget.isEditable ? "Update" : "Save",
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    await saveNote(
                      titleController.text,
                      subjController.text,
                      noteController.text,
                    );
                    Get.to(() => const HomeScreen());
                  } else {
                    print("Please check the fields");
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> saveNote(String title, String subject, String noteText) async {
    final noteBox = Hive.box<Note>('notes'); // Use a consistent box name
    final note = Note(
      title: title,
      description: "$subject\n\n$noteText",
    );
    await noteBox.add(note);
    titleController.clear();
    subjController.clear();
    noteController.clear();
  }
}
