class ProductModel {
  int id;
  String name;
  String image;
  String desc;
  double price;
  double rate;

  ProductModel({
    required this.id,
    required this.desc,
    required this.name,
    required this.image,
    required this.price,
    required this.rate,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      desc: json['description'],
      name: json['name'],
      image: json['image'],
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      rate: double.tryParse(json['rating'].toString()) ?? 0.0,
    );
  }
}