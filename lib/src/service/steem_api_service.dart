import 'package:jsonrpc2/jsonrpc_client.dart';
import 'package:logging/logging.dart';

class SteemApiService {
  static final String steemApiUrl = "https://api.steemit.com";
  final ServerProxy proxy;
  bool loading = true;

  final _logger = Logger('SteemApiService');

  SteemApiService() : proxy = new ServerProxy(steemApiUrl);

  init() {
    _logger.info("SteemApiService init function called!!!!!!!!!!!!!1");
  }

  call(String method, List args, Function success, Function fail) {
    proxy
        .call(method, args)
        .then((returned) => proxy.checkError(returned))
        .then((result) => success(result))
        .catchError((error) => fail(error));
  }
}
