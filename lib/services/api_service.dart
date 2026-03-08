/// Generic HTTP client for API calls. Optional – use when you add a backend.
class ApiService {
  static final ApiService _instance = ApiService._();
  factory ApiService() => _instance;

  ApiService._();

  // TODO: add dio/http client and base URL when backend is ready
  // Future<Response> get(String path) async => ...
  // Future<Response> post(String path, dynamic body) async => ...
}
