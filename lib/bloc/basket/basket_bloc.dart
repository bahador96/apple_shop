import 'package:apple_shop/bloc/basket/basket_event.dart';
import 'package:apple_shop/bloc/basket/basket_state.dart';
import 'package:apple_shop/di/di.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repository/basket_repository.dart';

class BasketBloc extends Bloc<BasketEvent, BasketSate> {
  final IBasketRepository _basketRepository = locator.get();

  BasketBloc() : super(BasketInitState()) {
    on<BasketFetchFromHiveEvent>(
      (event, emit) async {
        var basketItemList = await _basketRepository.getAllBasketItems();
        emit(BasketDataFetchedState(basketItemList));
      },
    );
  }
}
