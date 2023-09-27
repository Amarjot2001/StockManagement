import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/product_model.dart';

abstract class ProductProviderInterface {
  void insertDataInProductDatabase(ProductModel product);

  Future<List<ProductModel>> fetchDataFromProductDatabase();
}

class ProductListProvider implements ProductProviderInterface {
  var supabase = Supabase.instance.client;

  @override
  Future<List<ProductModel>> fetchDataFromProductDatabase() async {
    List<ProductModel> productsList = [];
    var response = await Supabase.instance.client
        .from('product')
        .select('id, title, subtitle, company, description')
        .order('id', ascending: true)
        .execute();
    var list = response.data as List<dynamic>;
    for (var element in list) {
      var model = ProductModel.fromJson(element as Map<String, dynamic>);
      productsList.add(model);
    }
    print("Fetch Data Product Table == ${productsList}");
    return productsList;
  }

  @override
  void insertDataInProductDatabase(ProductModel product) async {
    await supabase.from('product').insert({
      'title': product.title,
      'subtitle': product.subtitle,
      'company': product.company,
      'description': product.description
    });
  }
}
