import 'package:flutter/material.dart';
import 'package:stock_management/widgets/product/product_card.dart';
import '../models/product_model.dart';
import '../providers/product_list_provider.dart';

class ProductScreen extends StatefulWidget {
  final ProductListProvider _productListProvider;

  const ProductScreen(this._productListProvider, {super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: FutureBuilder<List<ProductModel>>(
          future: widget._productListProvider.fetchDataFromProductDatabase(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // While data is loading, show a loading indicator
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              // If there's an error in fetching the data, show an error message
              return Center(
                child: Text('Error occurred: ${snapshot.error}'),
              );
            } else {
              // Data has been fetched successfully
              var productsList = snapshot.data ?? [];

              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: productsList.length,
                itemBuilder: (BuildContext context, int index) {
                  var product = productsList[index];
                  return ProductCard(product);
                },
              );
            }
          },
        ),
      ),
    );
  }
}
