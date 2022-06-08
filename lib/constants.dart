// @dart=2.9
import 'package:flutter/material.dart';

// implementing the main colors for the all system
Color primaryColor = Color.fromRGBO(255, 255, 255, 1);
Color secondaryColor = Color.fromRGBO(64, 64, 64, 1);
Color textColor = Color.fromRGBO(64, 64, 64, 1);
Color hoverColor = Color.fromRGBO(41, 182, 230, 1);
Color textFill = Colors.white;
Color darkBlue = Color.fromRGBO(224, 224, 224, 1);
Color bar = Color.fromRGBO(26, 82, 118, 1);


// initializing variables for backend
var setData = 'http://localhost/ERP/setAPI.php';
var getData = 'http://localhost/ERP/getAPI.php';
var conditionAPI = 'http://localhost/ERP/condition.php';
var mail = 'http://localhost/PHPMailer/index.php';
var taskMail = 'http://localhost/PHPMailer/taskmail.php';
var data, response;

// Custom AppBar Buttons
Widget appButton(String title, VoidCallback onTap) {
  // ignore: deprecated_member_use
  return FlatButton(
    child: Text(
      title,
      style: TextStyle(
        color: Color.fromRGBO(224, 224, 224, 1),
        fontSize: 20,
      ),
    ),
    hoverColor: hoverColor,
    onPressed: onTap,
    height: 100,
  );
}

// Custom Flat Button for Home Page
Widget labelButton(String title, VoidCallback onTap) {
  // ignore: deprecated_member_use
  return FlatButton(
    child: Text(
      title,
      style: TextStyle(
        color: textFill,
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
    ),
    height: 50,
    onPressed: onTap,
  );
}

// Custom Button for all pages to act on database
Widget actionButtons(String title, VoidCallback onTap, Color color) {
  return Container(
    width: 150,
    height: 40,
    // ignore: deprecated_member_use
    child: RaisedButton(
      color: color,
      padding: EdgeInsets.only(
        top: 20,
        bottom: 20,
        left: 35,
        right: 35,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(50),
        ),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 15,
          color: textColor,
        ),
      ),
      onPressed: onTap,
    ),
  );
}

// Custom Text Field
Widget textField(TextEditingController text, double width, double height,
    bool status, String hint,
    [int limit]) {
  return Container(
    width: width,
    height: height,
    child: TextFormField(
      maxLength: limit,
      readOnly: status,
      controller: text,
      style: TextStyle(
        color: textColor,
      ),
      decoration: InputDecoration(
        counterText: '',
        hintText: hint,
        suffixIcon: Padding(
          padding: const EdgeInsets.only(
            right: 10,
          ),
        ),
        fillColor: textFill,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
          ),
          borderRadius: BorderRadius.all(
            new Radius.circular(
              0.0,
            ),
          ),
        ),
      ),
    ),
  );
}

// Custom Password Field
Widget passwordField(TextEditingController text, double width, double height,
    bool password, bool status, VoidCallback onTap) {
  return Container(
    width: width,
    height: height,
    child: TextFormField(
      maxLength: 20,
      readOnly: status,
      controller: text,
      style: TextStyle(
        color: textColor,
      ),
      decoration: InputDecoration(
        counterText: '',
        hintText: 'Password',
        suffixIcon: Padding(
          padding: const EdgeInsets.only(
            right: 10,
          ),
          child: IconButton(
            icon: Icon(password ? Icons.visibility_off : Icons.visibility),
            onPressed: onTap,
          ),
        ),
        fillColor: textFill,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
          ),
          borderRadius: BorderRadius.all(
            new Radius.circular(
              0.0,
            ),
          ),
        ),
      ),
      obscureText: password,
    ),
  );
}

// Custom Card for Home Page
Widget applicationCard(
    String title, double width, double height, VoidCallback onTap) {
  return InkWell(
    child: Container(
        padding: EdgeInsets.only(
          top: 10,
          bottom: 10,
        ),
        width: 240,
        height: 240,
        /*decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0.0),
        border: Border.all(
          width: 2,
          color: secondaryColor,
        ),

      ),*/
        child: Image.asset(title, height: 500, width: 500)),
    onTap: onTap,
    hoverColor: hoverColor,
    borderRadius: BorderRadius.circular(10.0),
  );
}
