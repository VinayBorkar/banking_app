import 'package:banking_app/bloc/customer_provider.dart';
import 'package:banking_app/utils/constants.dart';
import 'package:flutter/material.dart';
import '../model/customer.dart';
import 'package:provider/provider.dart';

enum BankingAction {
  withdraw,
  deposit,
}

class CustomerDetail extends StatefulWidget {
  Customer customer;
  int index;

  CustomerDetail(this.customer, this.index);

  @override
  _CustomerDetailState createState() => _CustomerDetailState();
}

class _CustomerDetailState extends State<CustomerDetail> {
  double balance = 0.0;
  final _formKey = GlobalKey<FormState>();
  TextEditingController balanceController = TextEditingController();

  @override
  void initState() {
    balance = widget.customer.balance;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var customerProvider =
        Provider.of<CustomerProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Detail'),
      ),
      body: Column(
        children: [
          titleAndText('Name: ', widget.customer.name),
          const SizedBox(
            height: 10,
          ),
          titleAndText('Phone No: ', widget.customer.phno),
          const SizedBox(
            height: 10,
          ),
          titleAndText('Balance: ', balance.toString()),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  inputBalanceDialog(context, BankingAction.withdraw);
                },
                child: const Text(
                  'Withdraw',
                ),
              ),
              TextButton(
                onPressed: () {
                  inputBalanceDialog(context, BankingAction.deposit);
                },
                child: const Text(
                  'Deposit',
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget titleAndText(String title, String subtitle) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
      ],
    );
  }

  inputBalanceDialog(BuildContext context, BankingAction action) {
    var customerProvider =
        Provider.of<CustomerProvider>(context, listen: false);
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              padding: const EdgeInsets.only(
                left: 15,
                right: 15,
                top: 40,
              ),
              height: 0.45 * screenHeight,
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      const Text(
                        'Enter Amount',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: balanceController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Item name cannot be empty';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Amount',
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      TextButton(
                        onPressed: () async {
                          if (action == BankingAction.withdraw) {
                            if (double.parse(balanceController.text) >=
                                balance) {
                              print('Low Balance');
                              return;
                            } else if (balance -
                                    (double.parse(balanceController.text)) <
                                100) {
                              print('Minimum balance should be 100');
                              return;
                            }
                            setState(() {
                              balance -= double.parse(balanceController.text);
                            });
                            customerProvider.updateItem(
                              widget.index,
                              Customer(widget.customer.name,
                                  widget.customer.phno, balance),
                            );
                          } else {
                            setState(() {
                              balance += double.parse(balanceController.text);
                            });
                            customerProvider.updateItem(
                              widget.index,
                              Customer(widget.customer.name,
                                  widget.customer.phno, balance),
                            );
                          }
                          balanceController.text = '';
                          Navigator.pop(context);
                        },
                        child: Text(
                          action == BankingAction.deposit
                              ? 'Deposit'
                              : 'Withdraw',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.purple,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
