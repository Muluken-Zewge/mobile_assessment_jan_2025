import 'package:flutter/material.dart';
import '../models/cart.dart';
import '../models/product.dart';

class CartProvider extends ChangeNotifier {
  final Cart _cart = Cart();
  //List<CartItem> _items = [];

  Cart get cart => _cart;

  void addToCart(Product product, {int quantity = 1}) {
    // Provided as a hint
    final existingItem = _cart.items.firstWhere(
      (item) => item.product.id == product.id,
      orElse: () => CartItem(product: Product.empty(), quantity: 0),
    );

    if (existingItem.product.id != -1) {
      existingItem.quantity += quantity;
    } else {
      _cart.items.add(CartItem(product: product, quantity: quantity));
    }
    notifyListeners();
  }

  void removeFromCart(int productId) {
    _cart.items.removeWhere((item) => item.product.id == productId);

    notifyListeners();
  }

  void updateQuantity(int productId, int newQuantity) {
    if (newQuantity <= 0) {
      removeFromCart(productId);
    } else {
      final existingItem = _cart.items.firstWhere(
        (item) => item.product.id == productId,
        orElse: () => CartItem(product: Product.empty(), quantity: 0),
      );
      existingItem.quantity = newQuantity;
    }
    notifyListeners();
  }

  void clearCart() {
    // TODO: Clear the cart
    _cart.items.clear();
    notifyListeners();
  }
}
