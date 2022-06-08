//@dart=2.9
import 'dart:convert';
import 'package:erp/Client/Crm/crmmarian.dart';
import 'package:erp/Client/Online/crmModel.dart';
import 'package:erp/constants.dart';
import 'package:erp/widget/appBar/clientAppBar.dart';
import 'package:erp/widget/chat/chatButton.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CRMTable extends StatefulWidget {
  final String userName, type;

  CRMTable({this.userName, this.type});

  @override
  _CRMTableState createState() => _CRMTableState();
}

class _CRMTableState extends State<CRMTable> {
  List<crmModel> model = [];
  Future fetchRecords() async {
    try {
      data = {"command": "SELECT * FROM  client"};
      http.post(Uri.parse(getData), body: data).then((http.Response response) {
        var fetchDecode = jsonDecode(response.body);
        fetchDecode.forEach((client) {
          setState(() {
            model.add(new crmModel(
              id: client['id'],
              name: client['name'],
              category: client['category'],
              email: client['email'],
              phone: client['phone'],
              address: client['address'],
            ));
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
        child: ClientAppBar(
          userName: widget.userName,
          type: widget.type,
        ),
      ),
      body: Center(
        child: Column(
          children: [
            DataTable(
              columns: [
                DataColumn(label: Text('ID')),
                DataColumn(label: Text('Name')),
                DataColumn(label: Text('category')),
                DataColumn(label: Text('email')),
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
                    Text(data.category),
                  ),
                  new DataCell(
                    Text(data.email),
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
            actionButtons('Add', () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => CRMData(userName: widget.userName,type: widget.type,)));
            }, Colors.green.shade600),
          ],
        ),
      ),
      floatingActionButton: ChatButton(),
    );
  }
}
