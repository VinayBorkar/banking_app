import 'package:banking_app/bloc/customer_provider.dart';
import 'package:banking_app/model/customer.dart';
import 'package:banking_app/screens/customer_detail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomerList extends StatelessWidget {
  const CustomerList({Key? key}) : super(key: key);

  static const routeName = '/CustomerList';

  @override
  Widget build(BuildContext context) {
    // Provider.of<CustomerProvider>(context).getItem;
    context.watch<CustomerProvider>().getItem();

    return Consumer<CustomerProvider>(
      builder: (ctx, customer, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Customer List'),
          ),
          body: ListView.builder(
            shrinkWrap: true,
            itemCount: customer.customerList.length,
            itemBuilder: (ctx, index) {
              Customer currentCustomer = customer.customerList[index];
              return customerItem(
                currentCustomer,
                context,
                index,
              );
            },
          ),
        );
      },
    );
  }

  Widget customerItem(
    Customer customer,
    BuildContext ctx,
    int index,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          ctx,
          MaterialPageRoute(
            builder: (context) => CustomerDetail(customer, index),
          ),
        );
      },
      child: ListTile(
        title: Row(
          children: [
            const Text(
              'Name: ',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            Text(customer.name),
          ],
        ),
        subtitle: Row(
          children: [
            const Text(
              'Phone No: ',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            Text(customer.phno),
          ],
        ),
      ),
    );
  }
}
