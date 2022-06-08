// @dart=2.9
import 'dart:convert';
import 'package:erp/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Album> createAlbum(String title) async {
  final response = await http.post(
    Uri.parse('https://jsonplaceholder.typicode.com/albums'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'title': title,
    }),
  );

  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}

class Album {
  final int id;
  final String title;

  Album({this.id, this.title});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'],
      title: json['title'],
    );
  }
}

class Task extends StatefulWidget {
  /*Task({this.title});


  final String title;*/

  @override
  _TaskState createState() => _TaskState();
}

class _TaskState extends State<Task> {
  var data, response;
  TextEditingController _mail = TextEditingController();
  TextEditingController _task = TextEditingController();
  TextEditingController _description = TextEditingController();

// ignore: deprecated_member_use
  List _emails = List();
  String _email;

  send() async {
    try {
      data = {
        "email": _mail.text,
        "task": _task.text,
        "description": _description.text,
      };
      response = await http.post(Uri.parse(taskMail), body: data);
    } catch (e) {
      print(e);
    }
  }

  Future emailList() async {
    try {
      data = {
        "command": "select email from users where name <> '' order by id"
      };
      http.post(Uri.parse(getData), body: data).then((http.Response response) {
        var fetchDecode = jsonDecode(response.body);
        fetchDecode.forEach((users) {
          setState(() {
            _emails.add(users['email']);
          });
        });
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    emailList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Task'),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              SizedBox(height: 40),
              Container(
                child: TextField(
                  controller: _task,
                  decoration: InputDecoration(
                      labelText: "Enter Your Task Name",
                      labelStyle: TextStyle(fontSize: 30),
                      hintText: "Task Name"),
                ),
              ),
              SizedBox(height: 20),
              /*DropdownButton<String>(
                value: dropdownValue,
                icon: const Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String newValue) {
                  setState(() {
                    dropdownValue = newValue;
                  });
                },
                items: <String>['Assign To', 'Two', 'three', 'Four']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),*/
              Container(
                width: 400,
                height: 50.0,
                child: DropdownButtonFormField(
                  hint: Text('Emails'),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    filled: true,
                    fillColor: textFill,
                  ),
                  value: _email,
                  onChanged: (newValue) {
                    setState(() {
                      _email = newValue;
                      _mail.text = _email;
                    });
                  },
                  items: _emails.map((location) {
                    return DropdownMenuItem(
                      child: new Text(location),
                      value: location,
                    );
                  }).toList(),
                ),
              ),
              Container(
                width: 500,
                height: 100,
                child: TextField(
                  controller: _description,
                  maxLines: 4,
                  decoration: InputDecoration(
                    labelText: "Description",
                    labelStyle: TextStyle(fontSize: 30),
                  ),
                ),
              ),
              SizedBox(height: 20),
              IconButton(onPressed: () {}, icon: Icon(Icons.attach_file)),
              RaisedButton(
                onPressed: () {
                  send();
                },
                child: Text("send"),
              ),
            ],
          ),
        ));
  }
}
