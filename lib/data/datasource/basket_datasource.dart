import 'package:apple_shop/data/model/card_item.dart';

import 'package:hive_flutter/adapters.dart';

abstract class IBasketDatasource {
  Future<void> addProduct(BasketItem basketItem);

  Future<List<BasketItem>> getAllBasketItems();

  Future<int> getBasketFinalPrice();
}

class BasketLocalDatasource extends IBasketDatasource {
  var box = Hive.box<BasketItem>('CardBox');

  @override
  Future<void> addProduct(BasketItem basketItem) async {
    box.add(basketItem);
  }

  @override
  Future<List<BasketItem>> getAllBasketItems() async {
    return box.values.toList();
  }

  @override
  Future<int> getBasketFinalPrice() async {
    var productList = box.values.toList();
    var finalPrice = productList.fold(
        0, (accumulator, product) => accumulator + product.realPrice!);
    return finalPrice;
  }
}
