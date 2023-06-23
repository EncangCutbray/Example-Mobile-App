class BackendApi {
  static const String baseUrl = 'https://devbe.bahaso.com/api';

  static const String apiKey =
      'X5ckXwVzY5729zwlYomzgZfcLCQRJtDCyPByDfglvy2VDVpGyBfJ9FT9tvi4C3Xh';

  static Map<String, dynamic> get(String endPoint) {
    return {
      'url': Uri.parse('$baseUrl$endPoint'),
      'headers': {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'X-Authorization': apiKey
      }
    };
  }
}
