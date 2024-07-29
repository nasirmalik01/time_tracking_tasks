

import 'package:take_home_challenge/network/remote_services.dart';
import 'package:take_home_challenge/utils/methods/methods.dart';

class AddNewTaskRepo{
  static Future<dynamic> createNewTask(Map<String,dynamic> query) async {

    final response = await getItLocator<RemoteServices>().postRequest(
        '', query);

    if (response != null){
      return response;
    }
  }
}