import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:notes_pro/create_note_scree.dart';
import 'package:notes_pro/utils/app_widgets.dart';
import 'package:notes_pro/create_note_scree.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> items = List.generate(5, (index) => "Item $index");

  void _confirmDelete(int index, BuildContext context) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder:
          (ctx) => AlertDialog(
        title: Text("Confirm Delete"),
        content: Text("Do you really want to delete '${items[index]}'?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text("Delete"),
          ),
        ],
      ),
    );

    if (confirm == true) {
      setState(() {
        items.removeAt(index);
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Item deleted")));
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
            Get.to(CreateNoteScreen(isEditable: false));
            /*  Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CreateNoteScreen(isEditable: false,)),
            );*/
          },
          child: Icon(Icons.add, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Slidable(
              key: ValueKey(items[index]),
              endActionPane: ActionPane(
                motion: DrawerMotion(),
                children: [
                  SlidableAction(
                    onPressed: (ctx) =>
                        Get.to(CreateNoteScreen(isEditable: true)),
                    // Navigator.push(context,MaterialPageRoute(builder: (context) => CreateNoteScreen(isEditable: true,),)),
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    icon: Icons.edit,
                    label: 'Edit',
                  ),
                  SlidableAction(
                    onPressed: (ctx) => _confirmDelete(index, context),
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
                  color: Colors.amber,
                ),
                child: ListTile(
                  title: customMediumText(textValue: "Title"),
                  subtitle: customMediumText(
                    textValue: "SubTitle",
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                  trailing: customMediumText(
                    textValue: "Create by",
                    fontSize: 12,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

