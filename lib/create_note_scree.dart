import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_pro/home_screen.dart';
import 'package:notes_pro/utils/app_widgets.dart';

class CreateNoteScreen extends StatefulWidget {
  const CreateNoteScreen({super.key});

  @override
  State<CreateNoteScreen> createState() => _CreateNoteScreenState();
}
final _formKey = GlobalKey<FormState>();

class _CreateNoteScreenState extends State<CreateNoteScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: customLargeText(textValue: "Add Notes"),centerTitle: true,),
    body: Form(
      key: _formKey,
      child: Scaffold(body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          customTextField(hintText: "Enter Title",validator: (value){
            if(value == null || value.isEmpty){
        return "Please enter title";
            }
            return null;
          }),
          customTextField(hintText: "Enter Subject",validator: (value){
            if(value == null || value.isEmpty){
              return "Enter subject";
            }
            return null;
          }),
          customTextField(maxLines:10,hintText: "Write Note",validator: (value){
            if(value!.isEmpty || value == null){
              return "Please add note";
            }
            return null;
          }),
          spaceY(height: 15),
          customElevatedButton(onTap: (){
            if (_formKey.currentState!.validate()) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
            }else{
        print("asdfg--Please check the fields");
            }

          })
        ],),
      ),),
    ),
    );
  }
}
