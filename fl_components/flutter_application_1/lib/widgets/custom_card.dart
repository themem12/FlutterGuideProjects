import 'package:flutter/material.dart';

import '../themes/app_theme.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          const ListTile(
            leading: Icon(
              Icons.phone,
              color: AppTheme.primaryColor,
            ),
            title: Text('Soy un título'),
            subtitle: Text(
                'Deserunt ullamco reprehenderit culpa nostrud ex laboris est. Eiusmod sint ex aliquip occaecat aliqua irure do minim et amet.'),
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Text('Cancelar'),
                  ),
                  TextButton(onPressed: () {}, child: const Text('Ok'))
                ],
              ))
        ],
      ),
    );
  }
}
