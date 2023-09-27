class ProductModel {
  String? id;
  String? title;
  String? subtitle;
  String? company;
  String? description;

  ProductModel(
      this.id, this.title, this.subtitle, this.company, this.description);

  ProductModel.fromJson(Map<String, dynamic> json) {
    print("Json: $json");
    id = json['id'];
    title = json['title'];
    subtitle = json['subtitle'];
    company = json['company'];
    description = json['description'];
  }
}
