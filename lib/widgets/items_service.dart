import 'package:flutter_testing_lab/widgets/card_item.dart';

class ItemsService {
  ItemsService();
  List<CartItem> _items = [];
  List<CartItem> get items => _items;
  set setItems(List<CartItem> items) => _items = items;

  void addItem(String id, String name, double price, {double discount = 0.0}) {
    _items.add(CartItem(id: id, name: name, price: price, discount: discount));
  }

  void removeItem(String id) {
    _items.removeWhere((item) => item.id == id);
  }

  void updateQuantity(String id, int newQuantity) {
    final index = _items.indexWhere((item) => item.id == id);
    if (index != -1) {
      _items[index].quantity += newQuantity;

      if (_items[index].quantity <= 0) {
        _items.removeAt(index);
      }
    }
  }

  void clearCart() {
    _items.clear();
  }

  double get subtotal {
    double total = 0;
    for (var item in _items) {
      total += item.price * item.quantity;
    }
    return total;
  }

  double get totalDiscount {
    double discount = 0;
    for (var item in _items) {
      discount += item.discount;
    }
    return discount;
  }

  double get totalAmount {
    double totleDiscountforAllAmounts = subtotal * (totalDiscount);
    return subtotal - totleDiscountforAllAmounts;
  }

  int get totalItems {
    return _items.fold(0, (sum, item) => sum + item.quantity);
  }
}
