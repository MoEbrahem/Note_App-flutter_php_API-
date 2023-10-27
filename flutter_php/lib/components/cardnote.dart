import 'package:flutter/material.dart';
import 'package:flutter_php/app/model/notemodel.dart';
import 'package:flutter_php/constant/linkapi.dart';
import 'dart:io';

class cardnote extends StatelessWidget {
  final void Function() ontab;
  final void Function()? onDelete;

  final NoteModel noteModel;
  const cardnote(
      {Key? key,
      required this.ontab,
      // required this.noteModel,
      required this.onDelete, required this.noteModel})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontab,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                flex: 1,
                child: Image.network(
                  "$linkImagePath/${noteModel.noteImage}",
                  width: 100,
                  height: 100,
                  fit: BoxFit.fill,
                )),
            Expanded(
              flex: 2,
              child: ListTile(
                title: Text("${noteModel.noteTitle}"),
                subtitle: Text("${noteModel.noteContent}"),
                trailing: IconButton(
                  onPressed: onDelete,
                  icon: Icon(Icons.delete),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
