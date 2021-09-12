class Restaurant{
  String? name;
  String? categories;
  int? pricePerPerson;
  double? ratings;
  String? imageURL;
  String? tags;

  Restaurant({this.name, this.categories, this.pricePerPerson, this.ratings, this.imageURL, this.tags});

  toMap() => {
    'name' : name,
    'categories' : categories,
    'pricePerPerson' : pricePerPerson,
    'ratings' : ratings,
    'imageURL' : imageURL,
    'tags' : tags,
  };

  @override
  String toString() {
    return 'Restaurant{name: $name, categories: $categories, pricePerPerson: $pricePerPerson, ratings: $ratings, url: $imageURL, tags: $tags}';
  }
}