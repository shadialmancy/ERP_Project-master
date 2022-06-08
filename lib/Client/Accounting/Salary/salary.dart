// @dart=2.9
import 'package:erp/Client/Accounting/Salary/salaryModel.dart';
import 'package:erp/Client/Accounting/Salary/salary_datatable.dart';
import 'package:erp/constants.dart';
import 'package:erp/widget/appBar/clientAppBar.dart';
import 'package:erp/widget/chat/chatButton.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:rflutter_alert/rflutter_alert.dart';

class Salary extends StatefulWidget {
  final String userName, type;
  final SalaryModel model;
  final bool check;

  Salary({this.userName, this.type, this.model, this.check});

  @override
  _SalaryState createState() => _SalaryState();
}

// Salary accounting page for the client's system
class _SalaryState extends State<Salary> {
  // objects implementation
  bool message = true;
  bool admin = false;
  bool accountant = false;
  TextEditingController _search = TextEditingController();
  TextEditingController _name = TextEditingController();
  TextEditingController _salary = TextEditingController();
  TextEditingController _insurance = TextEditingController();
  TextEditingController _tax = TextEditingController();
  TextEditingController _deduction = TextEditingController();
  TextEditingController _note = TextEditingController();
  TextEditingController _netS = TextEditingController();

  // ignore: deprecated_member_use
  List _monthly = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  // ignore: deprecated_member_use
  List _years = List();
  String _month, _year;

  // ignore: deprecated_member_use
  List _ids = List();
  String _id;

  checkType() {
    if (widget.type == 'Admin') {
      setState(() {
        admin = true;
      });
    } else if (widget.type == 'Accountant') {
      setState(() {
        accountant = true;
      });
    }
  }

  update() async {
    try {
      data = {
        "command": "update salary set salary = ${_salary.text}, insurance = ${_insurance.text}, "
            "tax = (salary*14)/100, deduction = ${_deduction.text},notes = '${_note.text}'"
            " ,netSalary = (salary-insurance-tax-deduction) where id = ${_search.text} and "
            "month = '${_month.toString()}' and year = '${_year.toString()}'"
      };
      response = await http.post(Uri.parse(setData), body: data);
      if (200 == response.statusCode) {
        return message;
      } else {
        return !message;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<Null> search() async {
    try {
      data = {"command": "select * from salary where id = ${_search.text}"};
      return await http
          .post(Uri.parse(getData), body: data)
          .then((http.Response response) {
        final List fetchData = json.decode(response.body);
        fetchData.forEach((user) {
          setState(() {
            _month = user['month'];
            _year = user['year'];
            _name.text = user['name'];
            _salary.text = user['salary'];
            _insurance.text = user['insurance'];
            _tax.text = user['tax'];
            _deduction.text = user['deduction'];
            _note.text = user['notes'];
            _netS.text = user['netSalary'];
          });
        });
      });
    } catch (e) {
      print(e);
    }
  }

  getRecord() {
    setState(() {
      _search.text = widget.model.id;
    });
  }

  // function to change values of a record and calculate net salary
  apply() async {
    try {
      data = {
        "command":
            "insert into salary values(${_search.text},'${_name.text}','${_month.toString()}'"
                ",'${_year.toString()}',${_salary.text},${_insurance.text},((salary*14)/100),${_deduction.text},"
                "'${_note.text}',(salary-insurance-tax-deduction))"
      };
      response = await http.post(Uri.parse(setData), body: data);
      if (200 == response.statusCode) {
        return message;
      } else {
        return !message;
      }
    } catch (e) {
      return message;
    }
  }

  // function to fetch data from database and calculate columns
  Future<Null> fetchName() async {
    try {
      data = {
        "command":
            "select * from users where concat('User ',id) = '${_id.toString()}'"
      };
      return await http
          .post(Uri.parse(getData), body: data)
          .then((http.Response response) {
        final List fetchData = json.decode(response.body);
        fetchData.forEach((user) {
          setState(() {
            _search.text = user['id'];
            _name.text = user['name'];
          });
        });
      });
    } catch (e) {}
  }

  Future<Null> fetchSalary() async {
    try {
      data = {"command": "select * from salary where id = ${_id.toString()}"};
      return await http
          .post(Uri.parse(getData), body: data)
          .then((http.Response response) {
        final List fetchData = json.decode(response.body);
        fetchData.forEach((user) {
          setState(() {
            _name.text = user['name'];
          });
        });
      });
    } catch (e) {}
  }

  // function to set id data to drop list
  Future idList() async {
    data = {
      "command": "select concat('User ',id) as userid from users order by id"
    };
    http.post(Uri.parse(getData), body: data).then((http.Response response) {
      var fetchDecode = jsonDecode(response.body);
      fetchDecode.forEach((users) {
        setState(() {
          _ids.add(users['userid']);
        });
      });
    });
  }

  @override
  void initState() {
    if (widget.check == true) {
      getRecord();
      search();
    }
    checkType();
    super.initState();
    idList();
    for (int i = 2000; i <= 2100; i++) {
      _years.add(i.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    // Media Query object for responsive layout
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      // calling the client's custom AppBar
      appBar: PreferredSize(
        preferredSize: Size(width, 70),
        child: ClientAppBar(
          userName: widget.userName,
          type: widget.type,
        ),
      ),
      // implementing th body with scroll View and row widget
      body: Container(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: EdgeInsets.only(
              top: 30,
              bottom: 30,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // implementing a container to make the outline border design
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            50.0,
                          ),
                          border: Border.all(
                            color: textColor,
                            width: 2,
                          )),
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 50, right: 50, top: 30, bottom: 30),
                        child: Column(
                          children: [
                            // implementing a row widget to align the rest of the widget
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // implementing a column to call custom drop down list, text field with sizedBox between them.
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: width * 0.29,
                                          height: 50.0,
                                          child: DropdownButtonFormField(
                                            hint: Text('Month'),
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0),
                                                ),
                                              ),
                                              filled: true,
                                              fillColor: textFill,
                                            ),
                                            value: _month,
                                            onChanged: (newValue) {
                                              setState(() {
                                                _month = newValue;
                                              });
                                            },
                                            items: _monthly.map((location) {
                                              return DropdownMenuItem(
                                                child: new Text(location),
                                                value: location,
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 30,
                                        ),
                                        Container(
                                          width: width * 0.29,
                                          height: 50.0,
                                          child: DropdownButtonFormField(
                                            hint: Text('Year'),
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0),
                                                ),
                                              ),
                                              filled: true,
                                              fillColor: textFill,
                                            ),
                                            value: _year,
                                            onChanged: (newValue) {
                                              setState(() {
                                                _year = newValue;
                                              });
                                            },
                                            items: _years.map((location) {
                                              return DropdownMenuItem(
                                                child: new Text(location),
                                                value: location,
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                      width: width * 0.6,
                                      height: 50.0,
                                      child: DropdownButtonFormField(
                                        hint: Text('ID'),
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10.0),
                                            ),
                                          ),
                                          filled: true,
                                          fillColor: textFill,
                                        ),
                                        value: _id,
                                        onChanged: (newValue) {
                                          setState(() {
                                            _id = newValue;
                                            fetchName();
                                          });
                                        },
                                        items: _ids.map((location) {
                                          return DropdownMenuItem(
                                            child: new Text(location),
                                            value: location,
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    textField(
                                        _name, width * 0.6, 40.0, true, 'Name'),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    textField(_salary, width * 0.6, 40.0, false,
                                        'Salary'),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    textField(_insurance, width * 0.6, 40.0,
                                        false, 'Insurance'),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    textField(
                                        _tax, width * 0.6, 40.0, true, 'Tax'),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    textField(_deduction, width * 0.6, 40.0,
                                        false, 'Deduction'),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    textField(_note, width * 0.6, 60.0, false,
                                        'Note', 30),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    textField(_netS, width * 0.6, 40.0, true,
                                        'Net Salary'),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            // implementing a row widget to call custom buttons and align them.
                            admin
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      actionButtons('Back', () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => SalaryTable(
                                              userName: widget.userName,
                                              type: widget.type,
                                            ),
                                          ),
                                        );
                                      }, Colors.blue.shade600),
                                    ],
                                  )
                                : accountant
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          actionButtons('Apply', () {
                                            apply();
                                            Alert(
                                              context: context,
                                              title: message
                                                  ? 'Applied'
                                                  : 'Couldn\'t Apply',
                                              buttons: [
                                                DialogButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                    fetchName();
                                                    search();
                                                  },
                                                  child: Text(
                                                    "OK",
                                                    style: TextStyle(
                                                      color: primaryColor,
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                  color: hoverColor,
                                                )
                                              ],
                                            ).show();
                                          }, Colors.green),
                                          SizedBox(
                                            width: 30,
                                          ),
                                          actionButtons('Update', () {
                                            update();
                                            Alert(
                                              context: context,
                                              title: message
                                                  ? 'Updated'
                                                  : 'Couldn\'t Update',
                                              buttons: [
                                                DialogButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                    update();
                                                    search();
                                                  },
                                                  child: Text(
                                                    "OK",
                                                    style: TextStyle(
                                                      color: primaryColor,
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                  color: hoverColor,
                                                )
                                              ],
                                            ).show();
                                          }, Colors.green),
                                          SizedBox(
                                            width: 30,
                                          ),
                                          actionButtons('Back', () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    SalaryTable(
                                                  userName: widget.userName,
                                                  type: widget.type,
                                                ),
                                              ),
                                            );
                                          }, Colors.blue.shade600),
                                        ],
                                      )
                                    : Row(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: ChatButton(),
    );
  }
}
