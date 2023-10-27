

import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_php/components/crud.dart';
import 'package:flutter_php/components/customtextform.dart';
import 'package:flutter_php/components/valid.dart';
import 'package:flutter_php/constant/linkapi.dart';
import 'package:flutter_php/main.dart';
import 'package:image_picker/image_picker.dart';


class AddNotes extends StatefulWidget {
  const AddNotes({super.key});

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> with Crud {
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  File? myfile;
  bool isLoading = false;
  addNotes() async {
    if (myfile == null) {
      return AwesomeDialog(
              context: context,
              title: "هااام",
              body: Text('الرجاء اضافة الصورة الخاصة بالملاحظة'))
          ..show();
    }
    if (formstate.currentState!.validate()) {
      isLoading = true;
      setState(() {});

      var response = await postRequestWithFile(
          linkAdd,
          {
            "id": sharedPref.getString("id"),
            "content": content.text,
            "title": title.text
          },myfile!);

      isLoading = false;
      setState(() {});

      if (response?["status"] == "success") {
        Navigator.of(context).pushReplacementNamed("Home");
      } else {
        return Text("Fails to Add Note",style:TextStyle(fontWeight: FontWeight.bold));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Notes"),
      ),
      body: isLoading == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: EdgeInsets.all(10),
              child: Form(
                  key: formstate,
                  child: ListView(
                    children: [
                      CustomTextFormSign(
                          hint: "Title",
                          mycontroller: title,
                          valid: (val) {
                            return ValidInput(val!, 1, 20);
                          }),
                      CustomTextFormSign(
                          hint: "Content",
                          mycontroller: content,
                          valid: (val) {
                            return ValidInput(val!, 5, 255);
                          }),
                      MaterialButton(
                        textColor: Colors.white,
                        color: myfile==null ? Colors.blue : Colors.green,
                        onPressed: () async {
                          showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) => Container(
                                    height: 130,
                                    child: Column(
                                     children: [
                                      Container(
                                        child: const Text(
                                          "choose Photo or take Image",
                                          style: TextStyle(fontSize: 22),
                                        ),
                                      ),
                                      InkWell(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black26),
                                              borderRadius:const BorderRadius.all(
                                                  Radius.circular(20))
                                                  ),
                                          alignment: Alignment.center,
                                          width: double.infinity,
                                          padding: EdgeInsets.all(10),
                                          child: const Text(
                                            'from Gallary',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
                                        onTap: () async {
                                          XFile? xfile = await ImagePicker().pickImage(
                                                  source: ImageSource.gallery);
                                          Navigator.of(context).pop();
                                          
                                           myfile = File(xfile!.path);
                                          setState((){});
                                        },
                                      ),
                                      Divider(
                                        height: 3,
                                        color: Colors.grey[500],
                                      ),
                                      InkWell(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black26),
                                              borderRadius: const BorderRadius.all(
                                                  Radius.circular(20))
                                                  ),
                                          alignment: Alignment.center,
                                          width: double.infinity,
                                          padding: EdgeInsets.all(10),
                                          child: const Text(
                                            'from camera',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
                                        onTap: () async {
                                          XFile? xfile = await ImagePicker()
                                              .pickImage(
                                                  source: ImageSource.camera);
                                                   
                                          setState((){
                                            myfile = File(xfile!.path);
                                            });
                                            Navigator.of(context).pop();
                                        },
                                      ),
                                    ]),
                                  ));
                        },
                        child: const Text(
                          "Add Image",
                        ),
                      ),
                      MaterialButton(
                        textColor: Colors.white,
                        color: Colors.blue ,
                        onPressed: () async {
                          await addNotes();
                        },
                        child: const Text(
                          "AddNote",
                        ),
                      )
                    ],
                  )),
            ),
    );
  }
}
