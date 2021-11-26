import 'package:banking_app/bloc/customer_provider.dart';
import 'package:banking_app/model/customer.dart';
import 'package:banking_app/utils/constants.dart';
import 'package:banking_app/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomerProfile extends StatefulWidget {
  CustomerProfile({Key? key}) : super(key: key);

  //initializing static route name for the class
  static const String routeName = '/customerProfile';

  @override
  State<CustomerProfile> createState() => _CustomerProfileState();
}

class _CustomerProfileState extends State<CustomerProfile> {
  //This screen gets the information required for customer creation
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController phnoController = TextEditingController();
  bool isContinueActive = false;

  @override
  Widget build(BuildContext context) {
    var customerDb = Provider.of<CustomerProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Banking App'),
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 6.0,
            left: 6.0,
            right: 6.0,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Text(
                  'Create Customer',
                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 7,
                ),
                titleAndContainer(
                  'Name:',
                  'Name',
                  nameController,
                  TextInputType.name,
                ),
                const SizedBox(
                  height: 10,
                ),
                titleAndContainer(
                  'Phone Number:',
                  'PhoneNumber',
                  phnoController,
                  TextInputType.number,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      customerDb.addItem(
                        Customer(
                          nameController.text,
                          phnoController.text,
                          500,
                        ),
                      );
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text('Submit',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  titleAndContainer(String title, String validator,
      TextEditingController controller, TextInputType keyboardType) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Color(0xFF1F1F1F),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(
          height: screenHeight * (10 / 753),
        ),
        TextFormField(
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(3.84),
              borderSide:
                  const BorderSide(color: Color(0xFFD2D2D2), width: 0.96),
            ),
          ),
          controller: controller,
          validator: (input) => chooseValidator(validator, input),
          onChanged: (input) {
            _formKey.currentState!.validate();
          },
          keyboardType: keyboardType,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF1F1F1F),
          ),
        ),
      ],
    );
  }
}
