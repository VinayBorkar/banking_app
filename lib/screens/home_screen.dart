import 'package:banking_app/screens/customer_list.dart';
import 'package:banking_app/screens/customer_profile.dart';
import 'package:banking_app/utils/constants.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  createCustomer(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(CustomerProfile.routeName);
  }

  customerList(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(CustomerList.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Banking App'),
      ),
      body: Row(
        children: [
          buttonWidget('Create Customer', createCustomer, context),
          SizedBox(
            width: (10 / 360) * screenWidth,
          ),
          buttonWidget('Customer List', customerList, context),
        ],
      ),
    );
  }

  Widget buttonWidget(
      String title, Function targetFunction, BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      height: (120 / 700) * screenHeight,
      width: (165 / 360) * screenWidth,
      color: Colors.grey,
      child: TextButton(
        onPressed: () {
          targetFunction(context);
          print(title);
        },
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.amber,
            fontSize: 25,
          ),
        ),
      ),
    );
  }
}
