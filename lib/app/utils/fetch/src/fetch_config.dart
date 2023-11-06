part of fetch;

// manage base url
String _baseUrl = AppConfig.baseUrl;

// manage header
Map<String, dynamic> _header = {'Accept': 'application/json', 'Content-Type': 'application/json'};

// manage ignore status
List<int> _ignoreErrorStatus = [401, 422];

// manage request listener
Function(int, dynamic)? _onRequest;

BaseOptions dioOptions({String? baseUrl}) => BaseOptions(
    followRedirects: false,
    baseUrl: _baseUrl,
    connectTimeout: const Duration(seconds: 60),
    receiveTimeout: const Duration(seconds: 200),
    headers: _header,
    responseType: ResponseType.plain,
    validateStatus: (status) => status! <= 598);

Dio dio = Dio(dioOptions());
