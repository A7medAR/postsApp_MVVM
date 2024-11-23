import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract class NetWorkInfo {
Future<bool>  get isConnected;
}

class NetworkInfoImpl implements NetWorkInfo{

  final InternetConnection connection;

  NetworkInfoImpl(this.connection);
  @override
  Future<bool> get isConnected =>connection.hasInternetAccess;

}