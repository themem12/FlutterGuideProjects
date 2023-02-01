import 'package:flutter/material.dart';

class Listview2Screen extends StatelessWidget {
  final options = const [
    'Megaman',
    'Metal Gear',
    'Super Smash',
    'Final Fantasy'
  ];

  const Listview2Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("ListView Tipo 2"),
        ),
        body: ListView.separated(
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(options[index]),
              trailing: const Icon(
                Icons.arrow_forward_ios_sharp,
                color: Colors.red,
              ),
              onTap: () {},
            );
          },
          separatorBuilder: (_, __) => const Divider(),
          itemCount: options.length,
        ));
  }
}
