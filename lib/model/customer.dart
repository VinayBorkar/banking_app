import 'package:hive/hive.dart';

part 'customer.g.dart';

@HiveType(typeId: 0)
class Customer {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String phno;

  @HiveField(2)
  final double balance;

  Customer(this.name, this.phno, this.balance);
}
