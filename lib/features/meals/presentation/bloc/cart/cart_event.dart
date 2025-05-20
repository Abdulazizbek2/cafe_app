part of "cart_bloc.dart";

abstract class CartEvent {}

class AddToCart extends CartEvent {
  final Meal meal;
  AddToCart(this.meal);
}

class RemoveFromCart extends CartEvent {
  final String mealId;
  RemoveFromCart(this.mealId);
}

class IncreaseQuantity extends CartEvent {
  final String mealId;
  IncreaseQuantity(this.mealId);
}

class DecreaseQuantity extends CartEvent {
  final String mealId;
  DecreaseQuantity(this.mealId);
}

class ClearCart extends CartEvent {}
