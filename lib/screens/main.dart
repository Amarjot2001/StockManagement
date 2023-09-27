import 'package:flutter/material.dart';
import 'package:stock_management/providers/cart_items_provider.dart';
import 'package:stock_management/providers/order_list_provider.dart';
import 'package:stock_management/screens/login_screen.dart';
import 'package:stock_management/screens/product_screen.dart';
import 'package:stock_management/screens/add_stock_screen.dart';
import 'package:stock_management/screens/stock_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../providers/product_list_provider.dart';
import 'add_product_screen.dart';
import 'cart_screen.dart';
import 'make_order_screen.dart';
import 'orders_history_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://fjgqrkgixkgrqhgfowcd.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZqZ3Fya2dpeGtncnFoZ2Zvd2NkIiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODM2MzAxMDYsImV4cCI6MTk5OTIwNjEwNn0.aljWcYUvGXMBFWC1zZZep64Y5M8W5CZ5MBy4r93rS-o',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.purple,
          textTheme: const TextTheme(
              titleLarge: TextStyle(
                  color: Color(0xff600175),
                  fontWeight: FontWeight.bold,
                  fontSize: 28),
              titleMedium: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500))),
      home: const LoginScreen(),
    );
  }
}

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  var addProductScreen = AddProductScreenState();
  var selectedIndex = 0;
  CartItemsProviders cartItemsProviders = CartItemsProviders();
  ProductListProvider productListProvider = ProductListProvider();
  OrderHistoryListProvider orderHistoryListProvider =
      OrderHistoryListProvider();

  late final List<Widget> _screen = <Widget>[
    ProductScreen(productListProvider),
    AddProductScreen(productListProvider),
    const AddStockScreen(),
    const StockScreen(),
    MakeOrderScreen(cartItemsProviders),
    CartScreen(cartItemsProviders),
    OrdersHistory(orderHistoryListProvider)
  ];

  void onButtonTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stock Management'),
        actions: [
          actionButton(Icons.blur_linear_sharp, 'Products', () {
            onButtonTapped(0);
          }),
          actionButton(Icons.add_chart, 'Add Products', () {
            onButtonTapped(1);
          }),
          actionButton(Icons.gradient, 'Add Stock', () {
            onButtonTapped(2);
          }),
          actionButton(Icons.description, 'Stock Detail', () {
            onButtonTapped(3);
          }),
          actionButton(Icons.shopify, 'Make Orders', () {
            onButtonTapped(4);
          }),
          actionButton(Icons.shopping_cart_outlined, 'Cart', () {
            onButtonTapped(5);
          }),
          actionButton(Icons.history, 'Orders History', () {
            onButtonTapped(6);
          })
        ],
      ),
      body: Stack(
        children: <Widget>[_screen.elementAt(selectedIndex)],
      ),
    );
  }

  Widget actionButton(IconData icon, String title, void Function() onClick) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Align(
        child: InkWell(
          onTap: () {
            onClick();
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(width: 1, color: Colors.white),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                children: [Icon(icon), Text(title)],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
