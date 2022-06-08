//@dart=2.9
import 'dart:convert';
import 'package:erp/constants.dart';
import 'package:erp/widget/appBar/clientAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'InventoryClass.dart';

class InventoryDesktop extends StatefulWidget {
  final String userName, type;
  List<InventoryClass> data;

  InventoryDesktop({this.userName,this.data,this.type});

  @override
  _InventoryDesktopState createState() => _InventoryDesktopState();
}

class _InventoryDesktopState extends State<InventoryDesktop> {
  //Image QR_code=Image.asset("");
  bool message1 = true;
  bool message2 = true;
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

  // ignore: non_constant_identifier_names

  // Future choosePhoto() async {
  //   var pickedImage = await picker.getImage(source: ImageSource.gallery);
  //   if (pickedImage != null) {
  //     image = File(pickedImage.path);
  //     setState(() {});
  //   }
  // }

  // Future imageEncoder() async{
  //   if(file==null)
  //     return;
  //   String base64 = base64Encode(file.readAsBytesSync());
  //   String imageName = file.path.split("/").last;
  //   print(imageName);
  // }

  clearValues() {
    widget.data.clear();
  }
  // ignore: non_constant_identifier_names
  AddData() async {
    clearValues();
    SelectData();
    if(SKU.text==""){
      Alert(
        context: context,
        title: 'SKU is empty',
        buttons: [
          DialogButton(
            onPressed: () {
              Navigator.pop(context);
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
      clearValues();
    }
    else if(model.isEmpty==false){
      Alert(
        context: context,
        title: 'This Data Already Exist',
        buttons: [
          DialogButton(
            onPressed: () {
              Navigator.pop(context);
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
      clearValues();
    }else {
      data = {
        "command": "INSERT INTO `product`(`Name`, `SKU`,"
            " `Quantity`, `Cost price`, `Variant`, `Selling price`, `Compared at price`) VALUES ('"
            "${Name.text}','${SKU.text}','${Quantity.text}'"
            ",'${Cost_price.text}','${Variant.text}','${Selling_price
            .text}','${Compared_at_price.text}')"
      };
      // var request =http.MultipartRequest('POST',Uri.parse(setData));
      // var pic = await http.MultipartFile.fromPath('Image of product',image.path);
      // request.files.add(pic);
      response = await http.post(Uri.parse(setData), body: data);
      if (200 == response.statusCode) {
        return message1;
      } else {
        return !message1;
      }
    }
  }

  // ignore: non_constant_identifier_names
  // AddData() async {
  //   var request = http.MultipartRequest('POST', Uri.parse(setData));
  //   request.fields['Name'] = Name.text;
  //   request.fields['SKU'] = SKU.text;
  //   request.fields['Quantity'] = Quantity.text;
  //   request.fields['Cost price'] = Cost_price.text;
  //   request.fields['Variant'] = Variant.text;
  //   request.fields['Selling_price'] = Selling_price.text;
  //   request.fields['Compared_at_price'] = Compared_at_price.text;
  //   var response = await request.send();
  //   if (200 == response.statusCode) {
  //     return message1;
  //   } else {
  //     return !message1;
  //   }
  // }

  // ignore: non_constant_identifier_names
  DeleteData() async {
    data = {"command": "DELETE FROM `product` WHERE SKU ='${SKU.text}'"};
    response = await http.post(Uri.parse(setData), body: data);
    if (200 == response.statusCode) {
      return message1;
    } else {
      return !message1;
    }
  }
 process(){
    Compared_at_price.text=(int.parse(Selling_price.text) - int.parse(Cost_price.text)).toString();
 }
  // ignore: non_constant_identifier_names
  UpdateData() async {
    data = {
      "command": "UPDATE `product` SET `Name`='${Name.text}'"
          ",`Quantity`='${Quantity.text}',`Cost price`='${Cost_price.text}'"
          ",`Variant`='${Variant.text}',`Selling price`='${Selling_price.text}',`Compared at price`='${Compared_at_price.text}'"
          "where SKU = '${SKU.text}'"
    };
    response = await http.post(Uri.parse(setData), body: data);
    if (200 == response.statusCode) {
      return message1;
    } else {
      return !message1;
    }
  }
  List<InventoryClass> model = [];
  // ignore: non_constant_identifier_names
  SelectData() async {
    data = {"command": "select * from product where SKU = '${SKU.text}'"};
    return await http
        .post(Uri.parse(getData), body: data)
        .then((http.Response response) {
      final List fetchData = json.decode(response.body);
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
        });
      });
    });
  }

  // Future uploadImage() async {}

  // Widget decideImageView() {
  //   if (image == null)
  //     return Text("Image not Selected");
  //   else
  //     return Image.file(
  //       image,
  //       width: 200,
  //       height: 200,
  //     );
  // }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: Color(0xFFE8E8E8),
        appBar: PreferredSize(
          preferredSize: Size(30, 70),
          child: ClientAppBar(
               userName: widget.userName,
            type: widget.type,
              ),
        ),
        body: SingleChildScrollView(
          child: ChangeNotifierProvider<MyProvider>(
              create: (context) => MyProvider(),
              child: Consumer<MyProvider>(builder: (context, provider, child) {
                return Padding(
                  padding: EdgeInsets.only(
                    top: 30,
                    bottom: 30,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(50.0),
                                border: Border.all(
                                  color: textColor,
                                  width: 2,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(
                                  top: 30,
                                  bottom: 30,
                                  left: 20,
                                  right: 20,
                                ),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: [
                                      Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            // implementing a column to call custom label widget with sizedBox between them
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                textField(Name, width * 0.41,
                                                    40.0, false, 'Name'),
                                                SizedBox(
                                                  height: 30,
                                                ),
                                                textField(SKU, width * 0.41,
                                                    40.0, false, 'SKU'),
                                                SizedBox(
                                                  height: 30,
                                                ),
                                                // textField(QR_code, width * 0.20,
                                                //     40.0, false, 'QR Code'),
                                                textField(
                                                    Quantity,
                                                    width * 0.41,
                                                    40.0,
                                                    false,
                                                    'Quantity'),
                                                // Row(children: [
                                                //   textField(
                                                //       Image_of_product,
                                                //       width * 0.20,
                                                //       40.0,
                                                //       false,
                                                //       'Image of product'),
                                                //   SizedBox(
                                                //     width: 5,
                                                //   ),
                                                //   // IconButton(
                                                //   //     onPressed: () async {
                                                //   //       var image = await ImagePicker()
                                                //   //           .getImage(
                                                //   //               source:
                                                //   //                   ImageSource
                                                //   //                       .gallery);
                                                //   //       provider
                                                //   //           .setImage(image);
                                                //   //       setState(() {
                                                //   //         Image_of_product
                                                //   //                 .text =
                                                //   //             provider
                                                //   //                 .image.path;
                                                //   //         // Image_of_product.text=base64Encode(file.readAsBytesSync());
                                                //   //         print(Image_of_product
                                                //   //             .text);
                                                //   //         // try{
                                                //   //         //   NAME_Image_of_product.text=provider.image.path.split('/').last;
                                                //   //         //   Image_of_product.text= provider.image.path;
                                                //   //         //   AddData();
                                                //   //         // }catch(e){
                                                //   //         //   print(e);
                                                //   //         // }
                                                //   //       });
                                                //   //     },
                                                //   //     icon: Icon(Icons
                                                //   //         .camera_alt_outlined))
                                                // ]),
                                                // if (provider.image != null)
                                                //   Image.network(
                                                //     provider.image.path,
                                                //     height: 120,
                                                //   ),
                                                SizedBox(
                                                  height: 30,
                                                ),
                                                Row(
                                                  children: [
                                                    textField(
                                                        Cost_price,
                                                        width * 0.20,
                                                        40.0,
                                                        false,
                                                        'Cost price'),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    textField(
                                                        Selling_price,
                                                        width * 0.20,
                                                        40.0,
                                                        false,
                                                        'Selling price'),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 30,
                                                ),
                                                Row(
                                                  children: [
                                                    textField(
                                                        Compared_at_price,
                                                        width * 0.20,
                                                        40.0,
                                                        true,
                                                        'Compared at price'),
                                                    SizedBox(
                                                      width: 90,
                                                    ),
                                                    actionButtons('Process', process, Color(0xFF00B9FF))
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 30,
                                                ),
                                                textField(Variant, width * 0.41,
                                                    40.0, false, 'Variant'),
                                              ],
                                            ),
                                            SizedBox(
                                              width: width * 0.04,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  width: width * 0.3,
                                                ),
                                                SizedBox(
                                                  height: 30,
                                                ),
                                                Row(
                                                  children: [
                                                    actionButtons("ADD", AddData,
                                                        Color(0xFF00B9FF)),
                                                    SizedBox(
                                                      width: 30
                                                    ),
                                                    actionButtons("Back", (){Navigator.pop(context);},
                                                      Color(0xFF00B9FF))
                                                  ],
                                                ),
                                              ],
                                            )

                                            // implementing a column to call custom drop down list, text field and
                                            // password field widget with sizedBox between them.
                                            // Column(
                                            //     crossAxisAlignment:
                                            //         CrossAxisAlignment.end,
                                            //
                                            //     children: [
                                            //       Container(
                                            //         alignment: Alignment.centerLeft,
                                            //         width: width * 0.40,
                                            //         height: 0.0,
                                            //       ),
                                            //       SizedBox(
                                            //         height: 15,
                                            //       ),
                                            //       textField(
                                            //           name, width * 0.20, 40.0, true),
                                            //       SizedBox(
                                            //         height: 15,
                                            //       ),
                                            //       textField(
                                            //           SKU, width * 0.20, 40.0, true),
                                            //       SizedBox(
                                            //         height: 15,
                                            //       ),
                                            //       textField(QR_code, width * 0.20,
                                            //           40.0, true),
                                            //       SizedBox(
                                            //         height: 15,
                                            //       ),
                                            //       textField(Quantity, width * 0.20,
                                            //           40.0, true),
                                            //       SizedBox(
                                            //         height: 15,
                                            //       ),
                                            //       textField(Image_of_product,
                                            //           width * 0.20, 40.0, true),
                                            //       SizedBox(
                                            //         height: 15,
                                            //       ),
                                            //       textField(Cost_price, width * 0.20,
                                            //           40.0, true),
                                            //       SizedBox(
                                            //         height: 15,
                                            //       ),
                                            //       textField(Variant, width * 0.20,
                                            //           40.0, true),
                                            //       SizedBox(
                                            //         height: 15,
                                            //       ),
                                            //       textField(Selling_price,
                                            //           width * 0.20, 40.0, true),
                                            //       SizedBox(
                                            //         height: 15,
                                            //       ),
                                            //       textField(Compared_at_price,
                                            //           width * 0.20, 40.0, true),
                                            //       SizedBox(
                                            //         height: 15,
                                            //       )
                                            //     ])
                                          ])
                                    ]),
                              )),
                        ],
                      ),
                    ],
                  ),
                );
              })),
        ));
  }
// ),
// )

}

class MyProvider extends ChangeNotifier {
  var image;

  Future setImage(img) async {
    this.image = img;
    this.notifyListeners();
  }
}
