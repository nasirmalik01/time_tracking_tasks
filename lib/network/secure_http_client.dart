import 'package:dio/dio.dart';
import 'package:take_home_challenge/res/strings.dart';


class MySecureHttpClient {

  static Dio getClient() {

    return Dio(
      BaseOptions(
        baseUrl: AppStrings.baseUrl,
        headers: {
            AppStrings.authorization: AppStrings.authorizationHeaderValue,
            AppStrings.contentType: AppStrings.contentTypeValue,
        },
        responseType: ResponseType.plain,
      ),
    );
  }



}
