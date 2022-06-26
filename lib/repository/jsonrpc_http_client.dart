import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:jsonrpc2/jsonrpc2.dart';

/// basic usage:
///
///    String url = "http://somelocation";
///    ServerProxy proxy = HttpServerProxy(url);
///    response = await proxy.call("someServerMethod", [arg1, arg2]);
///     // do something with response...
///
///  Each arg in the call must be representable in json
///  or have a toJson() method.
///
///  Exceptions on the remote end will throw RpcException.

class HttpServerProxy extends ServerProxyBase {
  /// customHeaders, for jwts and other niceties
  Map<String, String> customHeaders;

  /// constructor. superize properly
  HttpServerProxy(url, [this.customHeaders = const <String, String>{}])
      : super(url);

  /// Return a Future with the JSON-RPC response
  @override
  Future<String> transmit(String package) async {
    /// This is HttpRequest from dart:html
    var headers = {
      "Accept": "*/*",
      "Content-type": "application/json",
      //"Authorization": 'Token ${session.accessDevToken}'
    };
    if (customHeaders.isNotEmpty) {
      headers.addAll(customHeaders);
    }

    // useful for debugging!
    log(package, name: 'JsonRPC Request');
    var resp =
        await http.post(Uri.parse(resource), body: package, headers: headers);

    var body = strToUtf8Charset(resp.body);
    if (body.length > 800) {
      log(body.substring(0, 800), name: 'JsonRPC Service Response ');
    } else {
      log(body, name: 'JsonRPC Service Response');
    }

    if (resp.statusCode == 204 || body.isEmpty) {
      return ''; // we'll return an empty string for null response
    } else {
      return body;
    }
  }

// optionally, mirror remote API
// Future echo(dynamic aThing) async {
//   var resp = await call('echo', [aThing]);
//   return resp;
// }
}

/// see the documentation in [BatchServerProxyBase]
class HttpBatchServerProxy extends BatchServerProxyBase {
  @override
  dynamic proxy;

  /// constructor
  HttpBatchServerProxy(String url, [customHeaders = const <String, String>{}]) {
    proxy = HttpServerProxy(url, customHeaders);
  }
}

String strToUtf8Charset(String _str) {
  return Utf8Decoder().convert(_str.toString().codeUnits);
}
