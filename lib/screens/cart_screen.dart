import 'package:flutter/material.dart';
import 'package:stock_management/helper/PrimaryBtn.dart';
import 'package:stock_management/models/stock_product_model.dart';
import 'package:stock_management/models/stock_update_model.dart';
import 'package:stock_management/widgets/cart/cart_detail_card.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../providers/cart_items_provider.dart';
import 'make_order_screen.dart';
import 'package:uuid/uuid.dart';

class CartScreen extends StatefulWidget {
  final CartItemsProviders _cartItemsProvider;

  const CartScreen(this._cartItemsProvider, {super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<StockProductModel> _cartItemsList = [];
  var supabase = Supabase.instance.client;

  @override
  void initState() {
    super.initState();
    _fetchDataFromBothTables();
  }

  void _fetchDataFromBothTables() async {
    List<StockProductModel> productStockList = [];
    var response = await Supabase.instance.client
        .from('stock')
        .select('''*, product(*)''');
    var list = response as List<dynamic>;
    List<StockProductModel> newList = [];
    for (var element in list) {
      var model = StockProductModel.fromJson(element as Map<String, dynamic>);
      for (SelectedItem electedItem
          in widget._cartItemsProvider.selectedItems) {
        if (model.productModel.id.toString() == electedItem.itemId) {
          model.quantity = electedItem.quantity;
          break;
        }
      }
      newList.add(model);
    }
    productStockList = newList;
    _filterCartItems(productStockList);
  }

  void _filterCartItems(List<StockProductModel> cartItemsList) {
    List<StockProductModel> cartFilteredList = [];
    for (StockProductModel item in cartItemsList) {
      if (item.quantity > 0) {
        cartFilteredList.add(item);
      }
    }
    setState(() {
      _cartItemsList = cartFilteredList;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_cartItemsList.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: _cartItemsList.length,
                  itemBuilder: (context, index) {
                    return CartDetailCard(
                      _cartItemsList[index],
                      (p0) => {
                        setState(() {
                          _cartItemsList[index].quantity = p0;
                          widget._cartItemsProvider.updateQuantity(p0,
                              _cartItemsList[index].productModel.id.toString());
                        }),
                      },
                    );
                  }),
            ),
            PrimaryBtn(
                buttonTap: () {
                  _addOrderHistory();
                  _onCartCheckout();
                },
                name: "CheckOut")
          ],
        ),
      );
    } else {
      return const Center(
          child: Text(
        "No Item Selected For Cart!",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ));
    }
  }

  void _addOrderHistory() async {
    var cartItems = _cartItemsList;
    var uuid = const Uuid();
    var id = uuid.v4();
    List<Map<String, dynamic>> insertArr = [];
    List<StockUpdateModel> stockUpdate = [];

    for (StockProductModel cartItem in cartItems) {
      var totalPrice = cartItem.stockModel.mrp! * cartItem.quantity;
          insertArr.add({
        'id': id,
        'pName': cartItem.productModel.title,
        'pPrice': cartItem.stockModel.mrp,
        'pQuantity': cartItem.quantity,
        'totalPrice': totalPrice,
      });
      var stockId = cartItem.stockModel.id; // Move the id assignment inside the loop
      var availableStock = cartItem.stockModel.availableStock;
      availableStock = availableStock! - cartItem.quantity;
      print("Available == $availableStock");
      var soldStock = cartItem.stockModel.soldStock;
      soldStock = soldStock! + cartItem.quantity;
      print("Sold == $soldStock");
      var stockItam = StockUpdateModel(stockId, availableStock, soldStock);
      stockUpdate.add(stockItam);

    }
    print("Stock Update list == ${stockUpdate.length}");
    await supabase.from('orders').insert(insertArr);
    for(StockUpdateModel stock in stockUpdate){
      await supabase
          .from('stock')
          .update({
        'availableStock': stock.availableStock,
        'soldStock': stock.soldStock,
      })
          .eq('id', stock.id) // Use the id variable from the current iteration
          .execute();
    }
  }

  void _onCartCheckout() {
    setState(() {
      widget._cartItemsProvider.selectedItems.clear();
      _cartItemsList.clear();
    });
  }
}


