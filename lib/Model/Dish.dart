class Dish{
  String? name;
  double? price;
  int? discountType;
  double? flatDiscount;
  double? percentDiscount;
  String? imageURL;
  double? ratings;

  Dish({this.name, this.price, this.discountType, this.flatDiscount, this.percentDiscount, this.imageURL, this.ratings});


  @override
  String toString() {
    return 'Dish{name: $name, price: $price, discountType: $discountType, flatDiscount: $flatDiscount, percentDiscount: $percentDiscount, imageURL: $imageURL, ratings: $ratings}';
  }

  toMap() => {
    'name': name,
    'price': price,
    'discountType': discountType,
    'flatDiscount': flatDiscount,
    'percentDiscount': percentDiscount,
    'imageURL': imageURL,
    'ratings': ratings,
  };
}