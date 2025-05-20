part of "cart_bloc.dart";

class CartItem {
  final Meal meal;
  int quantity;

  CartItem({required this.meal, required this.quantity});
}

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoaded extends CartState {
  final List<CartItem> items;

  CartLoaded(this.items);

  double get totalPrice => items.fold(0, (sum, item) {
        final price = double.tryParse(item.meal.price ?? '') ?? 0;
        return sum + price * item.quantity;
      });
}
