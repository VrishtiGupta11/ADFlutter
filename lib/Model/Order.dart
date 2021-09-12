class Order{
  List? dishes;
  double? total;
  String? address;
  String? restaurantID;

  Order({this.dishes, this.total, this.address, this.restaurantID});

  @override
  String toString() {
    return 'Order{dishes: $dishes, total: $total, address: $address, restaurantID: $restaurantID}';
  }

  toMap() => {
    'dishes': dishes,
    'total': total,
    'address': address,
    'restaurantID': restaurantID,
  };
}