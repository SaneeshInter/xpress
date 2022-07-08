class Allowances {
  String? category_name;
  String? category;
  String? allowance;
  String? allowance_name;
  String? price;

  Allowances({
    this.category_name,
    this.category,
    this.allowance,
    this.allowance_name,
    this.price,
  });

  Allowances.fromJson(Map<String, dynamic> json)
      : category_name = json['category_name']??"",
        category = json['category']??"",
        allowance = json['allowance']??"",
        allowance_name = json['allowance_name']??"",
        price = json['amount'] ?? json['price']??"";

  Map<String, dynamic> toJson() {
    return {
      'category_name': category_name,
      'category': category,
      'allowance': allowance,
      'allowance_name': allowance_name,
      'price': price,
    };
  }
}
