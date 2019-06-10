import 'package:cnupogo/models/user.dart';
import 'package:cnupogo/utils/network_util.dart';

class RestData {
  NetworkUtil _networkUtil = new NetworkUtil();
  static final BASE_URL = "";
  static final LOGIN_URL = BASE_URL + "/";

  Future<User> signup(String username, String password) {
    return Future.value(new User(username, password));
  }

  Future<User> login(String username, String password) {
    return null;
  }
}
