import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_php/app/model/notemodel.dart';
import 'package:flutter_php/app/notes/edit.dart';
import 'package:flutter_php/components/cardnote.dart';
import 'package:flutter_php/components/crud.dart';
import 'package:flutter_php/constant/linkapi.dart';
import 'package:flutter_php/main.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with Crud {
  getNotes() async {
    var response =
        await postRequest(linkViewNotes, {"id": sharedPref.getString("id")});
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[400],
        actions: [
          IconButton(
            onPressed: () {
              sharedPref.clear();
              Navigator.of(context)
                  .pushNamedAndRemoveUntil("login", (route) => false);
            },
            icon: const Icon(Icons.exit_to_app),
          )
        ],
        title: const Text("Home"),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple[200],
        onPressed: () {
          Navigator.of(context).pushReplacementNamed("add");
        },
        child: const Icon(Icons.add),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            FutureBuilder(
              future: getNotes(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data?['status'] == 'Fail') {
                    return Center(
                        child: Text(
                      "لا يوجد ملاحظات",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ));
                  } else {
                    print(snapshot.data?['status']);
                    return ListView.builder(
                      itemCount: snapshot.data['data'].length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        List<dynamic> json = snapshot.data['data'];
                        return cardnote(
                          ontab: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => EditNotes(
                                      notes: snapshot.data['data'][index],
                                    )));
                          },
                          noteModel: NoteModel.fromJson(json[index]),
                          onDelete: () async {
                            var response = await postRequest(linkDelete, {
                              'id': snapshot.data['data'][index]['note_id']
                                  .toString(),
                              'imagename': snapshot.data['data'][index]
                                      ['note_image']
                                  .toString(),
                            });
                            if (response?['status'] == 'success') {
                              Navigator.of(context)
                                  .pushReplacementNamed('Home');
                            }
                          },
                        );
                      },
                    );
                  }
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: Text("Loading Connection ....."),
                  );
                }
                return Center(
                  child: Text("Loading Future ....."),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
