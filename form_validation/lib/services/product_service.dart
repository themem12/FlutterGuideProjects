import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:form_validation/models/models.dart';
import 'package:http/http.dart' as http;

class ProductsService extends ChangeNotifier {
  final String _baseURL = 'flutter-varios-3c544-default-rtdb.firebaseio.com';
  final List<Product> products = [];
  File? newPictureFile;
  bool isLoading = true;
  bool isSaving = false;

  late Product selectedProduct;

  ProductsService() {
    loadProducts();
  }

  Future<List<Product>> loadProducts() async {
    isLoading = true;
    notifyListeners();

    final url = Uri.https(_baseURL, 'products.json');
    final resp = await http.get(url);

    final Map<String, dynamic> productsMap = json.decode(resp.body);

    productsMap.forEach((key, value) {
      final tempProduct = Product.fromJson(value);
      tempProduct.id = key;
      products.add(tempProduct);
    });

    isLoading = false;
    notifyListeners();

    return products;
  }

  Future saveOrUpdateProduct(Product product) async {
    isSaving = true;
    notifyListeners();
    if (product.id == null) {
      //Es necesario crear
      await createProduct(product);
    } else {
      //Actualizar
      await updateProduct(product);
    }
    isSaving = false;
    notifyListeners();
  }

  Future<String> createProduct(Product product) async {
    final url = Uri.https(_baseURL, 'products.json');
    final resp = await http.post(url, body: product.toRawJson());
    final decodedData = json.decode(resp.body);
    product.id = decodedData['name'];
    //Actualizar listado de productos

    products.add(product);

    return product.id!;
  }

  Future<String> updateProduct(Product product) async {
    final url = Uri.https(_baseURL, 'products/${product.id}.json');
    final resp = await http.put(url, body: product.toRawJson());
    final decodedData = resp.body;

    debugPrint(decodedData);
    //Actualizar listado de productos

    final index = products.indexWhere((element) => element.id == product.id);
    products[index] = product;

    return product.id!;
  }

  void updateSelectedProductImage(String path) {
    selectedProduct.picture = path;
    newPictureFile = File.fromUri(Uri(path: path));
    notifyListeners();
  }

  Future<String?> uploadImage() async {
    if(newPictureFile == null) return null;
    isSaving = true;
    notifyListeners();

    final url = Uri.parse('https://api.cloudinary.com/v1_1/dlkb1fjwc/image/upload?upload_preset=ejrslunu');
    final imageUploadRequest = http.MultipartRequest('POST', url);
    final file = await http.MultipartFile.fromPath('file', newPictureFile!.path);
    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if(resp.statusCode != 200 && resp.statusCode != 201) {
      debugPrint('algo salió mal');
      return null;
    }

    newPictureFile = null;

    final decodedData = json.decode(resp.body);
    return decodedData['secure_url'];
  }
}