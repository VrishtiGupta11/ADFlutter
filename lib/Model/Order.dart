import 'package:cloud_firestore/cloud_firestore.dart';

class Order{
  List? dishes;
  double? total;
  String? address;
  String? restaurantID;
  int? orderNo;
  Timestamp? timestamp;

  Order({this.dishes, this.total, this.address, this.restaurantID, this.orderNo, this.timestamp});

  @override
  String toString() {
    return 'Order{dishes: $dishes, total: $total, address: $address, restaurantID: $restaurantID, orderNo: $orderNo, timestamp: $timestamp}';
  }

  toMap() => {
    'dishes': dishes,
    'total': total,
    'address': address,
    'restaurantID': restaurantID,
    'orderNo': orderNo,
    'timestamp': timestamp,
  };
}