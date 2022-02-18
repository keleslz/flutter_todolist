import 'dart:convert';

import 'package:http/http.dart' as http;

class RequestApi {
  
    Future<dynamic> getData() async {
      final url =  Uri.parse('https://jsonplaceholder.typicode.com/todos');
      var response = await http.get(url);

      if(response.statusCode == 200)
      {
        return jsonDecode(response.body);
      }

      throw Exception('Une erreur est survenue lors du fetch');

    }
}