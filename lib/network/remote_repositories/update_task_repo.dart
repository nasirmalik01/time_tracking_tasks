
import 'package:take_home_challenge/network/remote_services.dart';
import 'package:take_home_challenge/utils/methods/methods.dart';

class UpdateTaskRepo{
  static Future<dynamic> updateTask({
        required String endUrl,
        required Map<String, dynamic> query
  }) async {

    final response = await getItLocator<RemoteServices>().postRequest(
        endUrl, query);

    if (response != null){
      return response;
    }
  }
}