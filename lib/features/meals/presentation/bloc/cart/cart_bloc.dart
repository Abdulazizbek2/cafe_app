import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cafe_app/features/meals/domain/entities/meal.dart';

part "cart_event.dart";
part "cart_state.dart";

class CartBloc extends Bloc<CartEvent, CartState> {
  final List<CartItem> _items = [];

  CartBloc() : super(CartInitial()) {
    on<AddToCart>((event, emit) {
      final index = _items.indexWhere((item) => item.meal.id == event.meal.id);
      if (index == -1) {
        _items.add(CartItem(meal: event.meal, quantity: 1));
      } else {
        _items[index].quantity += 1;
      }
      emit(CartLoaded(List.from(_items)));
    });

    on<RemoveFromCart>((event, emit) {
      _items.removeWhere((item) => item.meal.id == event.mealId);
      emit(CartLoaded(List.from(_items)));
    });

    on<IncreaseQuantity>((event, emit) {
      final item = _items.firstWhere((item) => item.meal.id == event.mealId);
      item.quantity += 1;
      emit(CartLoaded(List.from(_items)));
    });

    on<DecreaseQuantity>((event, emit) {
      final item = _items.firstWhere((item) => item.meal.id == event.mealId);
      if (item.quantity > 1) {
        item.quantity -= 1;
      } else {
        _items.remove(item);
      }
      emit(CartLoaded(List.from(_items)));
    });

    on<ClearCart>((event, emit) {
      _items.clear();
      emit(CartLoaded(List.from(_items)));
    });
  }
}
