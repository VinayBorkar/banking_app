import 'package:banking_app/model/customer.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class CustomerProvider with ChangeNotifier {
  final String _customerBox = 'customer';

  List _customerList = <Customer>[];

  List get customerList => _customerList;

  addItem(Customer customer) async {
    var box = await Hive.openBox<Customer>(_customerBox);

    box.add(customer);

    print('added');

    notifyListeners();
  }

  getItem() async {
    final box = await Hive.openBox<Customer>(_customerBox);

    _customerList = box.values.toList();

    notifyListeners();
  }

  updateItem(int index, Customer customer) {
    final box = Hive.box<Customer>(_customerBox);

    box.putAt(index, customer);

    notifyListeners();
  }
}
