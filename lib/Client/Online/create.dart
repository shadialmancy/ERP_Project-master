// @dart=2.9
import 'package:erp/Client/Crm/crmmarian.dart';
import 'package:erp/Client/Online/createModel.dart';
import 'package:erp/Client/Online/crm.dart';
import 'package:erp/widget/appBar/clientAppBar.dart';
import 'package:erp/widget/chat/chatButton.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:erp/constants.dart';
import 'package:erp/widget/appBar/clientAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../constants.dart';
import 'crmModel.dart';

class create extends StatefulWidget {
    String userName, type;

  create({this.userName, this.type});

  @override
  _createState createState() => _createState();
}

class _createState extends State<create> {
  List<createModel> model = [];
  List<crmModel> model2 = [];

  TextEditingController _SKU = TextEditingController();
  TextEditingController _Name = TextEditingController();
  TextEditingController _Seliing_price = TextEditingController();
  TextEditingController _q = TextEditingController();
  TextEditingController _cus_id = TextEditingController();
  TextEditingController _search_cus = TextEditingController();

  TextEditingController _cus_Name = TextEditingController();
  TextEditingController _cus_phone = TextEditingController();
  TextEditingController _cus_address = TextEditingController();



  @override

  void initState() {
    super.initState();
     //fetchRecords();
   }



  Future<Null> searchCus() async {
    try {
      data = {"command": "select * from crm where phone='${_search_cus.text}'"};
      return await http
          .post(Uri.parse(getData), body: data)
          .then((http.Response response) {
        final List fetchData = json.decode(response.body);
        fetchData.forEach((onlineorder) {
          setState(() {
            _cus_Name.text = onlineorder['name'];
            _cus_phone.text = onlineorder['phone'];
            _cus_address.text = onlineorder['address'];
          });
        });
      });
    } catch (e) {
      print(e);
    }
  }

  applytoorder() async {
    try {
      data = {
        "command": "insert into ordern(id,name,phone,address,item id,item name,quantity,state)"
         "values( ${_cus_id.text} ,'${_cus_Name.text}','${_cus_phone.text}',${_cus_address.text},'${_SKU.text}','${_Name.text}', ${_q.text} ,'Unfullfild' )"
      };
      response = await http.post(Uri.parse(setData), body: data);
    } catch (e) {
      print(e);
    }
   }


  /*Future fetchRecords2() async {
    setState(() {
      model= [];
    });
    try {
      data = {"command": "SELECT * FROM  onlineorder ORDER BY id DESC LIMIT 1"};
      http.post(Uri.parse(getData), body: data).then((http.Response response) {
        var fetchDecode = jsonDecode(response.body);
        fetchDecode.forEach((user) {
          setState(() {
            _cus_id.text = user['id'];
            _cus_Name.text = user['name'];
             _cus_phone.text = user['phone'];
            _cus_address.text = user['address'];
          });
        });
      });
    } catch (e) {
      print(e);
    }
  }
*/
  Future fetchRecords_cus() async {
    setState(() {
      model2 = [];
    });
    try {
      data = {"command": "SELECT * FROM  crm"};
      http.post(Uri.parse(getData), body: data).then((http.Response response) {
        var fetchDecode = jsonDecode(response.body);
        fetchDecode.forEach((crm) {
          setState(() {
            _cus_Name.text = crm['name'];
            _cus_address.text =crm['address'];
            _cus_phone.text=crm['phone'];

          });
        });
      });
    } catch (e) {
      print(e);
    }
  }

  Future fetchRecords() async {
    setState(() {
      model= [];
    });
    try {
      data = {"command": "SELECT * FROM  product"};
      http.post(Uri.parse(getData), body: data).then((http.Response response) {
        var fetchDecode = jsonDecode(response.body);
        fetchDecode.forEach((crm) {
          setState(() {
            model.add(new  createModel(
              name: crm['Name'],
              SKU: crm['SKU'],
              Selling_Price: crm['Selling Price'],
              q: crm["Quantity"]
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
      data = {
        "command":
        "select * from product where SKU='${_SKU.text}'"
      };
      return await http
          .post(Uri.parse(getData), body: data)
          .then((http.Response response) {
        final List fetchData = json.decode(response.body);
        fetchData.forEach((product) {
          setState(() {
            _Name.text = product['Name'];
            _Seliing_price.text= product['Selling Price'];
           });
        });
      });
    } catch (e) {
      print(e);
    }
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
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Row(
                  children: [
                    textField(_SKU, width * 0.6, 40.0, false, 'Inter SKU'),


                    IconButton(onPressed: (){
                      search();
                    }, icon: Icon(Icons.search)),


                    IconButton(onPressed: (){
                      fetchRecords();

                    }, icon: Icon(Icons.add)),
                    SizedBox(
                      width: 10,
                    ),

                    textField(_q, width * 0.1, 40.0, false, 'Quantity'),
                    IconButton(onPressed: (){
                      applytoorder();
                    }, icon: Icon(Icons.create_new_folder)),
                    SizedBox(
                      height: 30,
                    ),



                  ],
                ),
                Row(
                  children: [
                    Text(
                        _Name.text

                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                        _Seliing_price.text

                    ),


                  ],
                ),

                DataTable(
                  columns: [
                     DataColumn(label: Text('Name')),
                    DataColumn(label: Text('SKU')),
                    DataColumn(label: Text('Selling Price')),
                     DataColumn(label: Text('Quantity'),

        ),
                  ],
                  rows: model
                      .map((data) => DataRow(
                    cells: [

                      new DataCell(
                        Text(data.name),
                      ),
                      new DataCell(
                        Text(data.SKU),
                      ),
                      new DataCell(
                        Text(data.Selling_Price),
                      ),
                      new DataCell(
                        Text(data.q  ),
                      ),

                    ],
                  ))
                      .toList(),
                ),
                SizedBox(
                 height: 30,
                ),

                SizedBox(
                  height: 30,
                ),
               Row(
                 children: [
                   textField(_cus_Name, width * 0.6, 40.0, false, 'Enter Customer Phone'),

                   IconButton(onPressed: (){
                     fetchRecords_cus();
                     searchCus();
                    }, icon: Icon(Icons.search)),
                   SizedBox(
                     width: 30,
                   ),

                   actionButtons('New Cus', () {
                     Navigator.push(
                       context,
                       MaterialPageRoute(
                         builder: (context) => crmData(),
                       ),
                     );


                   }, Colors.green.shade600),
                 ],
               ),
                Row(
                  children: [
                    Text(
                        _cus_Name.text

                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                        _cus_phone.text

                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                        _cus_address.text

                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),


    );
  }
}
