import 'package:http/http.dart' as http;
import '../utils/constants.dart';

Future<http.Response?> httpServiceGet(
    String endpoint, dynamic queryParams) async {
  try {
    final response = await http.get(Uri.https(BASE_URL, endpoint, queryParams));

    if (response.statusCode == 200) {
      return response;
    }
    return null;
  } on Exception catch (e) {
    print('An error occurred with the request');
    print(e.toString());
    return null;
  }
}

//TODO: further implement this service
