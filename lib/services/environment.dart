String apiUrl = "https://mtboss.com/api";
String paymentUrl = "https://mtboss.com/api";
Map<String, String>? headersToken(token, language) => {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      "Authorization": "Bearer $token",
    };

Map<String, String>? get headers =>
    {'Accept': 'application/json', 'Content-Type': 'application/json'};
