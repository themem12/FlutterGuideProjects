import 'package:flutter/material.dart';
import 'package:flutter_application_1/themes/app_theme.dart';

class CustomCard2 extends StatelessWidget {
  final String imageUrl;
  final String? name;

  const CustomCard2({super.key, required this.imageUrl, this.name});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      clipBehavior: Clip.antiAlias,
      elevation: 10,
      shadowColor: AppTheme.primaryColor.withOpacity(0.6),
      child: Column(
        children: [
          FadeInImage(
            image: NetworkImage(imageUrl),
            placeholder: const AssetImage('assets/jar-loading.gif'),
            width: double.infinity,
            height: 230,
            fit: BoxFit.cover,
            fadeInDuration: const Duration(milliseconds: 300),
          ),
          if (name != null)
            Container(
              alignment: AlignmentDirectional.bottomEnd,
              padding: const EdgeInsets.only(right: 20, top: 10, bottom: 10),
              child: Text(name!),
            )
        ],
      ),
    );
  }
}
