import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:notes_pro/create_note_scree.dart';
import 'package:notes_pro/note.dart';
import 'package:notes_pro/utils/app_widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Box<Note> noteBox;

  @override
  void initState() {
    super.initState();
    noteBox = Hive.box<Note>('notes'); // Access Hive box
  }

  void _confirmDelete(int index) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Confirm Delete"),
        content: Text("Do you really want to delete this note?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text("Cancel")),
          TextButton(onPressed: () => Navigator.pop(ctx, true), child: Text("Delete")),
        ],
      ),
    );

    if (confirm == true) {
      await noteBox.deleteAt(index); // Delete from Hive
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Note deleted")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: customLargeText(textValue: "My Notes"),
        centerTitle: true,
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(right: 20, bottom: 25),
        child: FloatingActionButton(
          backgroundColor: Colors.grey,
          onPressed: () {
            Get.to(() => CreateNoteScreen(isEditable: false));
          },
          child: Icon(Icons.add, color: Colors.white),
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: noteBox.listenable(),
        builder: (context, Box<Note> box, _) {
          if (box.isEmpty) {
            return Center(child: Text("No notes added yet"));
          }

          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              final note = box.getAt(index);
              return Slidable(
                key: ValueKey(note),
                endActionPane: ActionPane(
                  motion: DrawerMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (ctx) {
                        // You can pass the index and note to edit later
                        Get.to(() => CreateNoteScreen(isEditable: true));
                      },
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      icon: Icons.edit,
                      label: 'Edit',
                    ),
                    SlidableAction(
                      onPressed: (ctx) => _confirmDelete(index),
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'Delete',
                    ),
                  ],
                ),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.amberAccent,
                  ),
                  child: ListTile(
                    title: customMediumText(textValue: note?.title ?? ""),
                    subtitle: customMediumText(
                      textValue: note?.description ?? "",
                      color: Colors.grey.shade800,
                      fontSize: 12,
                    ),
                    trailing: customMediumText(
                      textValue: "Created",
                      fontSize: 12,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
