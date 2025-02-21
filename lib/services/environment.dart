String apiUrl = "https://mtboss.com/api";
String paymentUrl = "https://mtboss.com/api";

// String apiUrl = "https://laravel.webiots.co.in/fixit/api";
// String paymentUrl = "https://laravel.webiots.co.in/fixit/";

// String apiUrl = "https://laravel.pixelstrap.net/fixit/api";
// String paymentUrl = "https://laravel.pixelstrap.net/fixit/api";

Map<String, String>? headersToken(token, language) => {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      "Authorization": "Bearer $token",
    };

Map<String, String>? get headers =>
    {'Accept': 'application/json', 'Content-Type': 'application/json'};
