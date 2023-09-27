import 'package:flutter/material.dart';

class CartCheckoutButton extends StatelessWidget {
  final Function _onCheckoutClicked;

  const CartCheckoutButton(this._onCheckoutClicked, {super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _onCheckoutClicked();
      },
      style: ElevatedButton.styleFrom(
          elevation: 12.0, textStyle: const TextStyle(color: Colors.white)),
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: SizedBox(
            width: 200,
            child: Center(
                child: Text(
              'CheckOut',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ))),
      ),
    );
  }
}
