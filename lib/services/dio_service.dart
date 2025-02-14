import 'package:currypto_watch/utils/constants.dart';
import 'package:dio/dio.dart';

class DioService {
  Dio dio = Dio();

  Future<dynamic> getMethod(String url) async {
    return await dio
        .get(
      url,
      options: Options(
        responseType: ResponseType.json,
        method: 'GET',
        headers: {
          'content-type': 'application/json',
          'accept': '*/*',
          'api-key': apiKey,
        },
      ),
    )
        .then(
      (response) {
        return response;
      },
    ).catchError(
      (e) {
        if (e is DioException) {
          return e.response!;
        }
        return e;
      },
    );
  }
}
