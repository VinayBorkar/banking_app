import 'package:banking_app/screens/customer_list.dart';
import 'package:banking_app/screens/customer_profile.dart';
import 'package:flutter/material.dart';

final routes = <String, WidgetBuilder>{
  CustomerProfile.routeName: (BuildContext context) => CustomerProfile(),
  CustomerList.routeName: (BuildContext context) => CustomerList(),
};
