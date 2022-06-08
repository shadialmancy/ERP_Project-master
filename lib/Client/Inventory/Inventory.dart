//@dart=2.9
import 'package:erp/Client/Inventory/InventoryDesktop2.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';


class Inventory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: InventoryDesktop2(),
    );
  }
}
