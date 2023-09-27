import 'package:flutter/material.dart';
import '../../models/product_model.dart';

class ProductCard extends StatelessWidget {
  final ProductModel _product;
  const ProductCard(this._product, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
            top: 12, bottom: 12, left: 16, right: 16),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
               const CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.grey,
              backgroundImage: AssetImage('assets/images/product_image.png')),
              Text(
                _product.company.toString(),
                style:
                const TextStyle(color: Colors.black, fontSize: 20),
              ),
              Text(_product.title.toString(),
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 17)),
            ],
          ),
        ),
      ),
    );
  }
}
