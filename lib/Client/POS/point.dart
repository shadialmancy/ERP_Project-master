// @dart=2.9
import 'dart:convert';
import 'package:erp/Client/POS/posModel.dart';
import 'package:erp/constants.dart';
import 'package:erp/widget/appBar/clientAppBar.dart';
import 'package:erp/widget/chat/chatButton.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class PointData extends StatefulWidget {
  final String userName, type;
  PointData({this.userName,this.type});
  @override
  _PointDataState createState() => _PointDataState();
}

class _PointDataState extends State<PointData> {
  List<posModel> model = [];
  TextEditingController _SKU = TextEditingController();
  TextEditingController _name = TextEditingController();
  TextEditingController _quantity = TextEditingController();
  TextEditingController _price = TextEditingController();

  add() async {
    try {
      data = {"command": "Select * from `product` where (SKU) VALUES ('${_SKU.text}'"};
      response = await http.post(Uri.parse(setData), body: data);
    } catch (e) {
      print(e);
    }
    fetchRecords();
  }

  clear() async {
    try {
      data = {"command": " DELETE FROM product where SKU = '${_SKU.text}'"};
      response = await http.post(Uri.parse(setData), body: data);
    } catch (e) {
      print(e);
    }
    fetchRecords();
  }


  // SELECT*FROM [db.table] ORDER BY id ASC;

  refresh() async {
    try {
      data = {"command": " SELECT * FROM product"};
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
      data = {"command": "SELECT * FROM  product"};
      http.post(Uri.parse(getData), body: data).then((http.Response response) {
        var fetchDecode = jsonDecode(response.body);
        fetchDecode.forEach((product) {
          setState(() {
            model.add(new posModel(
              SKU: product['SKU'],
              name: product['Name'],
              quantity: product['Quantity'],
              price: product['Selling price'],
            ));
            print(model);
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
                  showCheckboxColumn: false,
                  columns: [
                    DataColumn(label: Text('SKU')),
                    DataColumn(label: Text('Name')),
                    DataColumn(label: Text('Quantity')),
                    DataColumn(label: Text('Price')),
                  ],
                  rows: model
                      .map((data) => DataRow(
                    onSelectChanged: (bool selected) {
                      if (selected) {
                        _SKU.text = data.SKU;
                        _name.text = data.name;
                        _quantity.text = data.quantity;
                        _price.text = data.price;
                      }
                    },
                    cells: [
                      new DataCell(
                        Text(data.SKU),
                      ),
                      new DataCell(
                        Text(data.name),
                      ),
                      new DataCell(
                        Text(data.quantity),
                      ),
                      new DataCell(
                        Text(data.price),
                      ),
                    ],
                  ))
                      .toList(),
                ),
                SizedBox(
                  height: 50,
                ),
                textField(_SKU, width * 0.6, 40.0, false, 'SKU'),
                SizedBox(
                  height: 30,
                ),
                /*textField(_name, width * 0.6, 40.0, false, 'Name'),
                SizedBox(
                  height: 30,
                ),
                textField(_quantity, width * 0.6, 40.0, false, 'Quantity'),
                SizedBox(
                  height: 30,
                ),
                textField(_price, width * 0.6, 40.0, false, 'Price'),
                SizedBox(
                  height: 30,
                ),*/
                Row(children: [
                  actionButtons('Add', () {
                    add();

                    fetchRecords();
                  }, Colors.green.shade600),
                  SizedBox(
                    width: 15,
                  ),
                  actionButtons('Clear', () {
                    clear();

                    fetchRecords();
                  }, Colors.blue.shade600),
                  SizedBox(
                    width: 15,
                  ),
                  actionButtons('Refresh', () {
                    refresh();

                    fetchRecords();
                  }, Colors.blue.shade600),
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