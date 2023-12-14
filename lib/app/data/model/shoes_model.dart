class ShoesModel {
  final int? id;
  final String? image;
  final String? name;
  final String? description;
  final double? price;
  final int? color;
  int quantity;
  bool hasCart;

  ShoesModel({
    this.id,
    this.image,
    this.name,
    this.description,
    this.price,
    this.color,
    this.quantity = 0,
    this.hasCart = false,
  });
  ShoesModel copyWith({
    int? id,
    String? image,
    String? name,
    String? description,
    double? price,
    int? color,
    int? quantity,
    bool? hasCart,
  }) =>
      ShoesModel(
          id: id ?? this.id,
          image: image ?? this.image,
          name: name ?? this.name,
          description: description ?? this.description,
          price: price ?? this.price,
          color: color ?? this.color,
          quantity: quantity ?? this.quantity,
          hasCart: hasCart ?? this.hasCart);

  factory ShoesModel.fromJson(Map<String, dynamic> json) => ShoesModel(
        id: json["id"],
        image: json["image"],
        name: json["name"],
        description: json["description"],
        price: json["price"]?.toDouble(),
        color: int.parse(json["color"].toString().replaceAll('#', '0xFF')),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "name": name,
        "description": description,
        "price": price,
        "color": color,
      };
}
