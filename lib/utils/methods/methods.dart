import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:take_home_challenge/network/remote_services.dart';

GetIt getItLocator = GetIt.instance;

dependencyInjectionSetUp() {
  getItLocator.registerSingleton<RemoteServices>(RemoteServices());
}

String getCurrentDateTime(){
  DateTime dateTime = DateTime.now();
  String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
  return formattedDate;
}



