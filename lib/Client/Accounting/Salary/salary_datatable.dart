// @dart=2.9
import 'dart:convert';
import 'package:erp/Client/Accounting/Salary/salary.dart';
import 'package:http/http.dart' as http;
import 'package:erp/Client/Accounting/Salary/salaryModel.dart';
import 'package:erp/constants.dart';
import 'package:erp/widget/appBar/clientAppBar.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SalaryTable extends StatefulWidget {
  final String userName, type;

  SalaryTable({this.userName, this.type});

  @override
  _SalaryTableState createState() => _SalaryTableState();
}

class _SalaryTableState extends State<SalaryTable> {
  List<SalaryModel> model = [];

  Future fetchRecords() async {
    try {
      data = {"command": "SELECT * FROM salary ORDER BY ID"};
      http.post(Uri.parse(getData), body: data).then((http.Response response) {
        var fetchDecode = jsonDecode(response.body);
        fetchDecode.forEach((salary) {
          setState(() {
            model.add(new SalaryModel(
              id: salary['id'],
              name: salary['name'],
              month: salary['month'],
              year: salary['year'],
              salary: salary['salary'],
              insurance: salary['insurance'],
              tax: salary['tax'],
              deduction: salary['deduction'],
              note: salary['notes'],
              netSalary: salary['netSalary'],
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
            Container(
              width: width * 0.7,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      DataTable(
                        showCheckboxColumn: false,
                        sortColumnIndex: 0,
                        sortAscending: true,
                        columns: [
                          DataColumn(label: Text('ID')),
                          DataColumn(label: Text('Name')),
                          DataColumn(label: Text('Month')),
                          DataColumn(label: Text('Year')),
                          DataColumn(label: Text('Salary')),
                          DataColumn(label: Text('Insurance')),
                          DataColumn(label: Text('Tax')),
                          DataColumn(label: Text('Deduction')),
                          DataColumn(label: Text('Note')),
                          DataColumn(label: Text('Net Salary')),
                        ],
                        rows: model
                            .map(
                              (data) => DataRow(
                                cells: [
                                  new DataCell(
                                    Text(data.id),
                                  ),
                                  new DataCell(
                                    Text(data.name),
                                  ),
                                  new DataCell(
                                    Text(data.month),
                                  ),
                                  new DataCell(
                                    Text(data.year),
                                  ),
                                  new DataCell(
                                    Text(data.salary),
                                  ),
                                  new DataCell(
                                    Text(data.insurance),
                                  ),
                                  new DataCell(
                                    Text(data.tax),
                                  ),
                                  new DataCell(
                                    Text(data.deduction),
                                  ),
                                  new DataCell(
                                    Text(data.note),
                                  ),
                                  new DataCell(
                                    Text(data.netSalary),
                                  ),
                                ],
                                onSelectChanged: (bool selected) {
                                  if (selected) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Salary(
                                          model: data,
                                          userName: widget.userName,
                                          type: widget.type,
                                          check: selected,
                                        ),
                                      ),
                                    );
                                  }
                                },
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                actionButtons('Add', () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Salary(
                                userName: widget.userName,
                                type: widget.type,
                              )));
                }, Colors.blue.shade600),
                SizedBox(
                  width: 30,
                ),
                actionButtons('Print', () {
                  launch('http://localhost/ERP/salaryPDF.php');
                }, Colors.blue.shade600),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
