class Product {
  int id;
  String title;
  // ignore: non_constant_identifier_names
  String short_description;
  String imageUrl;
  int price;
  String details;
  // ignore: non_constant_identifier_names
  int sale_precent;
  bool isFavourite;

  Product(
      this.id, this.title, this.short_description, this.imageUrl, this.price, this.details, this.sale_precent, this.isFavourite);


  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['title'] = title;
    map['short_description'] = short_description;
    map['imageUrl'] = imageUrl;
    map['price'] = price;
    map['details'] = details;
    map['sale_precent'] = sale_precent;

    return map;
  }

  // Extract a Note object from a Map object
  Product.fromMapObject(Map<String, dynamic> map) {
    this.id = map['id'];
    this.title = map['title'];
    this.short_description = map['short_description'];
    this.imageUrl = map['imageUrl'];
    this.price = map['price'];
    this.details = map['details'];
    this.sale_precent = map['sale_precent'];
    this.isFavourite = false;
  }

  String toString() {
    return 'Product{id: $id, title: $title, short_description: $short_description, imageUrl: $imageUrl,'
        'price: $price,  details: $details}, sale_precent: $sale_precent';
  }

}