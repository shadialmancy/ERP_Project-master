// @dart=2.9
import 'dart:convert';
 import 'package:erp/Client/Online/create.dart';
import 'package:erp/Client/Online/crmModel.dart';
import 'package:erp/constants.dart';
import 'package:erp/widget/appBar/clientAppBar.dart';
import 'package:erp/widget/chat/chatButton.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class crmData extends StatefulWidget {
    String userName="zee", type="admin";

  crmData({userName,type});

  @override
  _crmDataState createState() => _crmDataState();
}

class _crmDataState extends State<crmData> {
  List<crmModel> model = [];
  TextEditingController _name = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _search = TextEditingController();

  apply() async {
    try {
      data = {
        "command": "insert into crm(name,phone,address)"
            "values('${_name.text}','${_phone.text}','${_address.text}' )"
      };
      response = await http.post(Uri.parse(setData), body: data);
    } catch (e) {
      print(e);
    }
    fetchRecords();
  }

  apply2() async {
    try {
      data = {
        "command": "insert into onlineorder(name,phone,address)"
            "values('${_name.text}','${_phone.text}','${_address.text}' )"
      };
      response = await http.post(Uri.parse(setData), body: data);
    } catch (e) {
      print(e);
    }
    fetchRecords();
  }

  delete() async {
    try {
      data = {"command": " DELETE FROM crm where phone = '${_phone.text}'"};
      response = await http.post(Uri.parse(setData), body: data);
    } catch (e) {
      print(e);
    }
    fetchRecords();
  }

  Future fetchRecords() async {
    setState(() {
      model = [];
    });
    try {
      data = {"command": "SELECT * FROM  crm"};
      http.post(Uri.parse(getData), body: data).then((http.Response response) {
        var fetchDecode = jsonDecode(response.body);
        fetchDecode.forEach((crm) {
          setState(() {
            model.add(new crmModel(
              id: crm['id'],
              name: crm['name'],
              phone: crm['phone'],
              address: crm['address'],
            ));
          });
        });
      });
    } catch (e) {
      print(e);
    }
  }

  Future<Null> search() async {
    try {
      data = {"command": "select * from crm where phone='${_search.text}'"};
      return await http
          .post(Uri.parse(getData), body: data)
          .then((http.Response response) {
        final List fetchData = json.decode(response.body);
        fetchData.forEach((onlineorder) {
          setState(() {
            _name.text = onlineorder['name'];
            _phone.text = onlineorder['phone'];
            _address.text = onlineorder['address'];
          });
        });
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    fetchRecords();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(width, 70),
        child: ClientAppBar(userName: widget.userName,type: widget.type,),
      ),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                DataTable(
                  columns: [
                    DataColumn(label: Text('ID')),
                    DataColumn(label: Text('Name')),
                    DataColumn(label: Text('Phone')),
                    DataColumn(label: Text('Address')),
                  ],
                  rows: model
                      .map((data) => DataRow(
                            cells: [
                              new DataCell(
                                Text(data.id),
                              ),
                              new DataCell(
                                Text(data.name),
                              ),
                              new DataCell(
                                Text(data.phone),
                              ),
                              new DataCell(
                                Text(data.address),
                              ),
                            ],
                          ))
                      .toList(),
                ),
                SizedBox(
                  height: 50,
                ),

               Row(
                 children: [
                   textField(_search, width * 0.6, 40.0, false, 'Search'),
SizedBox(
  width: 20,
),
                   IconButton(onPressed: (){
                     search();
                     fetchRecords();
                  }, icon: Icon(Icons.search)),

                 ],
               ),
                SizedBox(
                  height: 50,
                ),
                textField(_name, width * 0.6, 40.0, false, 'Name'),
                SizedBox(
                  height: 30,
                ),
                textField(_phone, width * 0.6, 40.0, false, 'Phone'),
                SizedBox(
                  height: 30,
                ),
                textField(_address, width * 0.6, 40.0, false, 'Address'),
                SizedBox(
                  height: 30,
                ),
                Row(children: [
                  actionButtons('Add', () {
                    apply();

                    fetchRecords();
                  }, Colors.green.shade600),
                  SizedBox(
                    width: 15,
                  ),
                  actionButtons('Edit', () {
                    delete();

                    fetchRecords();
                  }, Colors.blue.shade600),
                  SizedBox(
                    width: 15,
                  ),

                  actionButtons('Next', () {
                    if (_name.text == '' || _address.text == '') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => create(),
                        ),
                      );
                    } else
                      apply2();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => create( ),
                      ),
                    );
                  }, Colors.blue.shade600),
                  SizedBox(
                    width: 15,
                  ),

                ])
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: ChatButton(),
    );
  }
}
