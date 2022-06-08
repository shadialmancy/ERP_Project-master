// @dart=2.9
import 'dart:convert';

import 'package:erp/Client/Inventory/InventoryClass.dart';
import 'package:erp/Client/Inventory/inventoryDesktop.dart';
import 'package:erp/constants.dart';
import 'package:erp/widget/appBar/clientAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'InventoryDesktop3.dart';

class InventoryDesktop2 extends StatefulWidget {
  final String userName, type;

  InventoryDesktop2({this.userName, this.type});
  @override
  _InventoryDesktop2State createState() => _InventoryDesktop2State();
}

class _InventoryDesktop2State extends State<InventoryDesktop2> {

  // this list will hold the filtered inventory
  // List listName = [];
  // List listSKU = [];
  // List listQR_code= [];
  // List listQuantity = [];
  // List listImage_of_product = [];
  // List listCost_price = [];
  // List listVariant = [];
  // List listSelling_price = [];
  // List listCompared_at_price = [];
  TextEditingController Name = TextEditingController();

  // ignore: non_constant_identifier_names
  TextEditingController SKU = TextEditingController();

  // ignore: non_constant_identifier_names
  TextEditingController Quantity = TextEditingController();

  // ignore: non_constant_identifier_names
  TextEditingController Cost_price = TextEditingController();

  // ignore: non_constant_identifier_names
  TextEditingController Variant = TextEditingController();

  // ignore: non_constant_identifier_names
  TextEditingController Selling_price = TextEditingController();

  // ignore: non_constant_identifier_names
  TextEditingController Compared_at_price = TextEditingController();

  List<InventoryClass> model = [];

  bool message1 = true;
  bool message2 = true;
  List fetchData = [];
  @override
  void initState() {
    clearValues();
    SelectAllData();
    super.initState();
  }



  DeleteData(String SKU) async {
    data = {
      "command": "DELETE FROM `product` WHERE SKU ='$SKU'"
    };

    response = await http.post(Uri.parse(setData), body: data);
    if (200 == response.statusCode) {
      return message1;
    } else {
      return !message1;
    }
  }

  SelectData() async {
    data = {"command": "select * from product where SKU = '${SKU.text}'"};
    return await http
        .post(Uri.parse(getData), body: data)
        .then((http.Response response) {
      fetchData = jsonDecode(response.body);
      // print(fetchData.toList());
      fetchData.forEach((product) {
        setState(() {
          model.add(new InventoryClass(
            Name: product['Name'],
            SKU: product['SKU'],
            Quantity: product['Quantity'],
            Variant: product['Variant'],
            Cost_price: product['Cost price'],
            Selling_price: product['Selling price'],
            Compared_at_price: product['Compared at price']
          ));
          // listName.add(product['Name']);
          // listSKU.add(product['SKU']);
          // listQuantity.add(product['Quantity']);
          // listCost_price.add(product['Cost price']);
          // listVariant.add(product['Variant']);
          // listSelling_price.add(product['Selling price']);
          // listCompared_at_price.add(product['Compared at price']);
          // print(listName);
        });
      });
    });
  }


  SelectAllData() async {
    data = {"command": "select * from product"};
    return await http
        .post(Uri.parse(getData), body: data)
        .then((http.Response response) {
      fetchData = jsonDecode(response.body);
      fetchData.forEach((product) {
        setState(() {
          model.add(new InventoryClass(
              Name: product['Name'],
              SKU: product['SKU'],
              Quantity: product['Quantity'],
              Variant: product['Variant'],
              Cost_price: product['Cost price'],
              Selling_price: product['Selling price'],
              Compared_at_price: product['Compared at price']
          ));
          // listName.add(product['Name']);
          // listSKU.add(product['SKU']);
          // listQuantity.add(product['Quantity']);
          // listCost_price.add(product['Cost price']);
          // listVariant.add(product['Variant']);
          // listSelling_price.add(product['Selling price']);
          // listCompared_at_price.add(product['Compared at price']);
        });
      });
    });
  }

  clearValues() {
    model.clear();
  }

  // showValues(int i) {
  //    return DataRow(cells: <DataCell>[
  //       DataCell(Text(listName[i])),
  //       DataCell(Text(listSKU[i])),
  //       DataCell(Text(listQuantity[i])),
  //       DataCell(Text(listCost_price[i])),
  //       DataCell(Text(listVariant[i])),
  //       DataCell(Text(listSelling_price[i])),
  //       DataCell(Text(listCompared_at_price[i])),
  //       DataCell(IconButton(
  //         icon: Icon(Icons.delete),
  //         onPressed: () {
  //           DeleteData(listSKU[i]);
  //           SelectAllData();
  //           showValues(i);
  //         },
  //       )
  //       )
  //   ]);
  // }

  // _showSnackBar(message) {
  //   _scaffoldKey.currentState.showSnackBar(
  //     SnackBar(
  //       content: Text(message),
  //     ),
  //   );
  // }

  // forEach(){
  //   fetchData.forEach((product) {
  //     Name.text=product["Name"];
  //     SKU.text = product['SKU'];
  //     QR_code.text = product['QR code'];
  //     Quantity.text = product['Quantity'];
  //     Image_of_product.text = product['Image of product'];
  //     Cost_price.text = product['Cost price'];
  //     Variant.text = product['Variant'];
  //     Selling_price.text = product['Selling price'];
  //     Compared_at_price.text = product['Compared at price'];
  //     return DataRow(cells: <DataCell>[
  //       DataCell(Text(Name.text)),
  //       DataCell(Text(SKU.text)),
  //       DataCell(Text( QR_code.text)),
  //       DataCell(Text(Quantity.text)),
  //       DataCell(Text(Image_of_product.text)),
  //       DataCell(Text(Cost_price.text)),
  //       DataCell(Text(Variant.text)),
  //       DataCell(Text(Selling_price.text)),
  //       DataCell(Text(Compared_at_price.text)),
  //
  //     ]
  //     );
  //   });
  // }

  // DataRow buildDataRow(List data) {
  //   print('hello');
  //   SelectAllData();
  //   return DataRow(
  //     cells: data
  //         .map<DataCell>(
  //           (cell) => DataCell(
  //         Text(cell),
  //       ),
  //     )
  //         .toList(),
  //   );
  // }

  // _getProducts() {
  //   InventoryFunction.getProducts().then((products) {
  //     setState(() {
  //       _inventory = products;
  //       // Initialize to the list from Server when reloading...
  //       _filterInventory = products;
  //     });
  //     print("Length ${products.length}");
  //   });
  // }

  // _addProduct() {
  //   if (SKU.text.isEmpty || Name.text.isEmpty) {
  //     print('Empty Fields');
  //     return;
  //   }
  //   InventoryFunction.addProducts(
  //       Name.text,
  //       SKU.text,
  //       QR_code.text,
  //       Quantity.text,
  //       Image_of_product.text,
  //       Cost_price.text,
  //       Variant.text,
  //       Selling_price.text,
  //       Compared_at_price.text)
  //       .then((result) {
  //     if ('success' == result) {
  //       _getProducts(); // Refresh the List after adding each employee...
  //       _clearValues();
  //     }
  //   });
  // }

  // _updateProduct(InventoryClass product) {
  //   setState(() {
  //     _isUpdating = true;
  //   });
  //   InventoryFunction.updateProducts(
  //       Name.text,
  //       SKU.text,
  //       QR_code.text,
  //       Quantity.text,
  //       Image_of_product.text,
  //       Cost_price.text,
  //       Variant.text,
  //       Selling_price.text,
  //       Compared_at_price.text)
  //       .then((result) {
  //     if ('success' == result) {
  //       _getProducts(); // Refresh the list after update
  //       setState(() {
  //         _isUpdating = true;
  //       });
  //       _clearValues();
  //     } else {
  //       _showSnackBar("Error check database");
  //     }
  //   });
  // }

  // _deleteProduct(InventoryClass product) {
  //   InventoryFunction.deleteProduct(product.SKU).then((result) {
  //     if ('success' == result) {
  //       _getProducts(); // Refresh after delete...
  //     }
  //   });
  // }


  @override
  Widget build(BuildContext context) {
    final width = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
        backgroundColor: Color(0xFFE8E8E8),
        appBar: PreferredSize(
          preferredSize: Size(30, 70),
          child: ClientAppBar(userName: widget.userName,type: widget.type,),
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.only(
                  top: 30,
                  bottom: 30,
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center, children: [
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                        children:[
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.white),
                    width: width * 1,
                    height: 1000,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 0,
                        right: 0,
                      ),
                      child: Column(
                        children:[
                          SizedBox(
                              height:20
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children:[
                              SizedBox(
                                width: 200,
                              ),
                          textField(SKU, width * 0.20, 40.0, false,"Search For SKU"),
                              SizedBox(
                                width: 10,
                              ),
                              IconButton(onPressed: (){
                                clearValues();
                                SelectData();
                                Scaffold();
                              }, icon: Icon(Icons.search)),
                              SizedBox(
                                  width: 0,
                              ),
                              IconButton(onPressed: (){
                                clearValues();
                                SelectAllData();
                                Scaffold();
                              }, icon: Icon(Icons.clear)),
                              Spacer(
                                flex: 1,
                              ),
                              actionButtons('New Product', () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => InventoryDesktop(data: model,userName: widget.userName,type: widget.type,)),
                                );
                              }, Colors.blue),
                              SizedBox(
                                width: 10,
                              ),
                              IconButton(onPressed: (){
                                clearValues();
                                SelectAllData();
                              }, icon: Icon(Icons.refresh)),
                              SizedBox(
                                width: 190,
                              )
                      ]
                          ),
                          SizedBox(
                              height:20
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                          DataTable(
                         showCheckboxColumn: false,
                              sortColumnIndex: 0,
                              sortAscending: true,
                              columns: [
                          DataColumn(
                            label: Text('Name'),
                          ),
                          DataColumn(
                            label: Text('SKU'),
                          ),
                          DataColumn(
                            label: Text('Stock'),
                          ),
                          DataColumn(
                            label: Text('Cost price'),
                          ),
                          DataColumn(
                            label: Text('Variant'),
                          ),
                          DataColumn(
                            label: Text('Selling price'),
                          ),
                          DataColumn(
                            label: Text('Compared at price'),
                          ),
                          // Lets add one more column to show a delete button
                          DataColumn(
                            label: Text('DELETE'),
                          )
                       ],
                       // the list should show the filtered list now
                         rows:  model.map((data) => DataRow(

                           onSelectChanged: (bool selected){
                             if(selected){
                               Navigator.push(
                                 context,
                                 MaterialPageRoute(builder: (context) => InventoryDesktop3(data: data,userName: widget.userName,type: widget.type)),
                               );
                             }
                           },
                             cells: [new DataCell(
                               Text(data.Name),
                             ),
                               new DataCell(
                                 Text(data.SKU),
                               ),
                               new DataCell(
                                 Text(data.Quantity),
                               ),
                               new DataCell(
                                 Text(data.Cost_price),
                               ),
                               new DataCell(
                                 Text(data.Variant),
                               ),
                               new DataCell(
                                 Text(data.Selling_price),
                               ),
                               new DataCell(
                                 Text(data.Compared_at_price),
                               ),
                               new DataCell(IconButton(
                                 icon: Icon(Icons.delete),
                                 onPressed: () {
                                   DeleteData(data.SKU);
                                   clearValues();
                                   SelectAllData();
                                 },
                               ))
    ]
                         )).toList()
                              // <DataRow>[
                       //    for(int i = 0;i<listSKU.length;i++)
                       //          showValues(i)
                       //    ]
                          )
                            ])]),
                    ),
                  )
  ])
                ]
                )
            )
        )
    );
  }

}
