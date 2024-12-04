import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tcc_senai/model/product_model.dart';
class ProductController {
  final String apiUrl = "https://9b2427c5-ff0a-41b5-82b5-d4d152cda757-00-2utlbc55e5ahg.picard.replit.dev/products/";

  Future<List<ProductModel>> fetchProducts() async {
  try {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final List<dynamic> productsData = json.decode(response.body);
      return productsData.map((jsonProduct) => ProductModel.fromJson(jsonProduct)).toList();
    } else {
      throw Exception("Erro ao buscar produtos: ${response.statusCode}");
    }
  } catch (e) {
    print("Erro ao buscar produtos: $e");
    return [];
  }
}

}
