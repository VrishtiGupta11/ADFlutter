class Dish{
  String? name;
  double? price;
  int? discountType;
  double? flatDiscount;
  double? percentDiscount;
  String? imageURL;
  double? ratings;
  int? quantity;
  double? totalPrice;

  Dish({this.name, this.price, this.discountType, this.flatDiscount, this.percentDiscount, this.imageURL, this.ratings, this.quantity, this.totalPrice});


  @override
  String toString() {
    return 'Dish{name: $name, price: $price, discountType: $discountType, flatDiscount: $flatDiscount, percentDiscount: $percentDiscount, imageURL: $imageURL, ratings: $ratings, quantity: $quantity, totalPrice: $totalPrice}';
  }

  toMap() => {
    'name': name,
    'price': price,
    'discountType': discountType,
    'flatDiscount': flatDiscount,
    'percentDiscount': percentDiscount,
    'imageURL': imageURL,
    'ratings': ratings,
    'quantity': quantity,
    'totalPrice': totalPrice
  };
}