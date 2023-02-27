import 'package:apple_shop/data/model/product.dart';
import 'package:apple_shop/di/di.dart';
import 'package:dio/dio.dart';

import '../../util/api_exception.dart';

abstract class ICategoryProductDatasource {
  Future<List<Product>> getProductByCategoryId(String categoryId);
}

class CategoryProductRemoteDatasource extends ICategoryProductDatasource {
  final Dio _dio = locator.get();

  @override
  Future<List<Product>> getProductByCategoryId(String categoryId) async {
    try {
      Map<String, String> qParams = {
        "filter": 'category="$categoryId"',
      };

      Response<dynamic> respones;

      if (categoryId == '78q8w901e6iipuk') {
        respones = await _dio.get('collections/products/records');
      } else {
        respones = await _dio.get('collections/products/records',
            queryParameters: qParams);
      }
      // var respones = await _dio.get('collections/products/records',
      //     queryParameters: qParams);
      return respones.data['items']
          .map<Product>((jsonObject) => Product.fromJson(jsonObject))
          .toList();
    } on DioError catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'unknown error');
    }
  }
}
