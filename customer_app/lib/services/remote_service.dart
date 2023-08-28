import 'package:customer_app/models/post.dart';
import 'package:http/http.dart' as http;

class RemoteService {
  Future<List<Post>?> getPosts() async {
    final client = http.Client();
    final uri = Uri.parse('http://192.168.1.49:3000/api/customer/');
    final response = await client.get(uri);
    if (response.statusCode == 200) {
      final json = response.body;
      return postFromJson(json);
    }
    return null;
  }
}
