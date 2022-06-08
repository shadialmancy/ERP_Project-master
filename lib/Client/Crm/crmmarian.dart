// @dart=2.9
import 'package:erp/constants.dart';
import 'package:erp/widget/appBar/clientAppBar.dart';
import 'package:erp/widget/chat/chatButton.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CRMData extends StatefulWidget {
  final String userName, type;

  CRMData({this.userName, this.type});

  @override
  _CRMDataState createState() => _CRMDataState();
}

class _CRMDataState extends State<CRMData> {
  TextEditingController _name = TextEditingController();
  TextEditingController _category = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _address = TextEditingController();
  bool admin = false;
  bool seller = false;
  bool online = false;
  bool inventory = false;

  checkType() {
    if (widget.type == 'Admin') {
      setState(() {
        admin = true;
      });
    } else if (widget.type == 'Seller') {
      setState(() {
        seller = true;
      });
    } else if (widget.type == 'Online Sale') {
      setState(() {
        online = true;
      });
    } else if (widget.type == 'Inventory') {
      setState(() {
        inventory = true;
      });
    }
  }

  apply() async {
    try {
      data = {
        "command": "insert into client(name,category,email,phone,address)"
            "values('${_name.text}','${_category.text}','${_email.text}','${_phone.text}','${_address.text}')"
      };
      response = await http.post(Uri.parse(setData), body: data);
    } catch (e) {
      print(e);
    }
  }

  delete() async {
    try {
      data = {"command": " DELETE FROM client where phone = '${_phone.text}'"};
      response = await http.post(Uri.parse(setData), body: data);
    } catch (e) {
      print(e);
    }
  }



  @override
  void initState() {
    checkType();
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
      body: Container(
        child: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  textField(_name, width * 0.6, 40.0, false, 'Name'),
                  SizedBox(
                    height: 30,
                  ),
                  textField(_category, width * 0.6, 40.0, false, 'Category'),
                  SizedBox(
                    height: 30,
                  ),
                  textField(_email, width * 0.6, 40.0, false, 'Email'),
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
                  admin
                      ? Row()
                      : seller
                          ? Row()
                          : online
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    actionButtons('Add', () {
                                      apply();
                                    }, Colors.green.shade600),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    actionButtons('Delete', () {
                                      delete();
                                    }, Colors.blue.shade600),
                                  ],
                                )
                              : inventory
                                  ? Row()
                                  : Row(),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: ChatButton(),
    );
  }
}
