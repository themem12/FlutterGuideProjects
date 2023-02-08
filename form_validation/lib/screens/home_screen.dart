import 'package:flutter/material.dart';
import 'package:form_validation/models/product.dart';
import 'package:form_validation/screens/screens.dart';
import 'package:form_validation/services/product_service.dart';
import 'package:form_validation/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsService = Provider.of<ProductsService>(context);
    if (productsService.isLoading) {
      return const LoadingScreen();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),
      ),
      body: ListView.builder(
        itemCount: productsService.products.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            productsService.selectedProduct = productsService.products[index].copy();
            Navigator.pushNamed(context, 'product');
          },
          child: ProductCard(product: productsService.products[index],)
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          productsService.selectedProduct = Product(available: false, name: '', price: 0);
          Navigator.pushNamed(context, 'product');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
