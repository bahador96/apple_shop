import 'package:apple_shop/data/model/comment.dart';
import 'package:dio/dio.dart';

import '../../di/di.dart';
import '../../util/api_exception.dart';

abstract class ICommentDatasource {
  Future<List<Comment>> getComments(String productId);
  Future<void> postComment(String productId, String comment);
}

class CommentRemoteDatasource extends ICommentDatasource {
  final Dio _dio = locator.get();

  @override
  Future<List<Comment>> getComments(String productId) async {
    Map<String, String> qParams = {
      "filter": 'product_id="$productId"',
      'expand': 'user_id'
    };
    try {
      var respones = await _dio.get('collections/comment/records',
          queryParameters: qParams);
      return respones.data['items']
          .map<Comment>((jsonObject) => Comment.fromMapJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'unknown error');
    }
  }

  @override
  Future<void> postComment(String productId, String comment) async {
    try {
      final response = await _dio.post(
          'http://startflutter.ir/api/collections/comment/records',
          data: {
            'text': comment,
            'user_id': "lkg8xc50i07oedn",
            'product_id': productId,
          });
      if (response.statusCode == 200) {
        return response.data?['token'];
      }
    } on DioException catch (ex) {
      throw ApiException(
        ex.response?.statusCode,
        ex.response?.data['message'],
      );
    } catch (ex) {
      throw ApiException(0, 'uknown error');
    }
  }
}
