import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_validation/providers/product_form_provider.dart';
import 'package:form_validation/services/services.dart';
import 'package:form_validation/ui/input_decoration.dart';
import 'package:form_validation/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart' show ImagePicker, ImageSource, PickedFile;

class ProductScreen extends StatelessWidget {
   const ProductScreen({super.key});

   @override
   Widget build(BuildContext context) {
    final ProductsService productsService = Provider.of<ProductsService>(context);
      return ChangeNotifierProvider(create: (_) => ProductFormProvider(productsService.selectedProduct), child: _ProductScreenBody(productsService: productsService),);
   }
}

class _ProductScreenBody extends StatelessWidget {
  const _ProductScreenBody({
    required this.productsService,
  });

  final ProductsService productsService;

  @override
  Widget build(BuildContext context) {
    final productFormProvider = Provider.of<ProductFormProvider>(context);
    return Scaffold(
       body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                ProductImage(url: productsService.selectedProduct.picture),
                Positioned(
                  top: 60,
                  left: 20,
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.arrow_back_ios_new, size: 40, color: Colors.white,),
                  ),
                ),
                Positioned(
                  top: 60,
                  right: 20,
                  child: IconButton(
                    onPressed: () async {
                      final picker = ImagePicker();
                      final PickedFile? pickedFile = await picker.getImage(source: ImageSource.camera, 
                      imageQuality: 100);
                      if(pickedFile == null) {
                        debugPrint('no seleccionó nada');
                        return;
                      }

                      productsService.updateSelectedProductImage(pickedFile.path);
                    },
                    icon: const Icon(Icons.camera_alt_outlined, size: 40, color: Colors.white,),
                  ),
                )
              ],
            ),
            const _ProductForm(),
            const SizedBox(height: 20,),
          ],
        ),
       ),
       floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
       floatingActionButton: FloatingActionButton(
        onPressed: productsService.isSaving ? null : () async {
          if(!productFormProvider.isValidForm()) return;

          final String? imageURL = await productsService.uploadImage();
          if(imageURL != null) productFormProvider.product.picture = imageURL;
          await productsService.saveOrUpdateProduct(productFormProvider.product);
        },
        child: productsService.isSaving ? const CircularProgressIndicator(color: Colors.white,) : const Icon(Icons.save_outlined),
       ),
    );
  }
}

class _ProductForm extends StatelessWidget {
  const _ProductForm();

  @override
  Widget build(BuildContext context) {
    final ProductFormProvider productFormProvider = Provider.of<ProductFormProvider>(context);
    final product = productFormProvider.product;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(bottomRight: Radius.circular(25), bottomLeft: Radius.circular(25)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: const Offset(0,5),
              blurRadius: 5
            )
          ]
        ),
        child: Form(
          key: productFormProvider.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              const SizedBox(height: 10,),
              TextFormField(
                decoration: InputsDecorations.authInputDecoration(hintText: 'Nombre del producto', labelText: 'Nombre:'),
                initialValue: product.name,
                onChanged: (value) => product.name = value,
                validator: (value) {
                  if(value == null || value.isEmpty) {
                    return 'El nombre es obligatorio';
                  }
                  return null;
                }
              ),
              const SizedBox(height: 30,),
              TextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
                ],
                decoration: InputsDecorations.authInputDecoration(hintText: '\$150', labelText: 'Precio:'),
                initialValue: '${product.price}',
                onChanged: (value) {
                  if(double.tryParse(value) == null) {
                    product.price = 0.0;
                  } else {
                    product.price = double.parse(value);
                  }
                },
              ),
              const SizedBox(height: 30,),
              SwitchListTile.adaptive(
                value: product.available,
                title: const Text('Disponible'),
                activeColor: Colors.indigo,
                onChanged: productFormProvider.updateAvailability,
              ),
              const SizedBox(height: 30,),
            ],
          ),
        ),
      ),
    );
  }
}