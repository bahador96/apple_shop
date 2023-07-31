import 'package:apple_shop/data/model/card_item.dart';
import 'package:dartz/dartz.dart';

abstract class BasketSate {}

class BasketInitState extends BasketSate {}

class BasketDataFetchedState extends BasketSate {
  Either<String, List<BasketItem>> basketItemList;

  int basketFinalPrice;
  BasketDataFetchedState(this.basketItemList, this.basketFinalPrice);
}
