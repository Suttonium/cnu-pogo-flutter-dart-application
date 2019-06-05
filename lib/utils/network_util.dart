class NetworkUtil {
  static NetworkUtil _singleton = new NetworkUtil.internal();

  NetworkUtil.internal();

  factory NetworkUtil() => _singleton;

  Future<dynamic> get() {
    return null;
  }
}
