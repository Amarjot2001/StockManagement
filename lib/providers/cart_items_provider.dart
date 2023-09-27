import '../screens/make_order_screen.dart';

class CartItemsProviders {
  List<SelectedItem> selectedItems = [];

  void updateQuantity(int qty, String id) {
    bool hasFound = false;
    for (SelectedItem item in selectedItems) {
      if (item.itemId == id) {
        hasFound = true;
        if (qty == 0) {
          selectedItems.remove(item);
        } else {
          item.quantity = qty;
        }
        break;
      }
    }
    if (hasFound == false) {
      selectedItems.add(SelectedItem(qty, id));
    }
  }
}