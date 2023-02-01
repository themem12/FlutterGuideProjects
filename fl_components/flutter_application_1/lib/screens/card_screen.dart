import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class CardScreen extends StatelessWidget {
  const CardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Card Widget'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        children: const [
          CustomCard(),
          SizedBox(height: 10),
          CustomCard2(
            imageUrl:
                'https://images.pexels.com/photos/1619317/pexels-photo-1619317.jpeg?cs=srgb&dl=pexels-james-wheeler-1619317.jpg&fm=jpg',
            name: 'Un hermoso paisaje',
          ),
          SizedBox(height: 10),
          CustomCard2(
              imageUrl:
                  'https://iso.500px.com/wp-content/uploads/2014/06/W4A2827-1.jpg'),
          SizedBox(height: 10),
          CustomCard2(
              imageUrl:
                  'https://images.squarespace-cdn.com/content/v1/5795a6914402433b8b4b3f74/1652319375667-SCDOQWQARKYR9Q16O6OA/IMG_4617.jpg'),
          SizedBox(height: 10),
          CustomCard2(
              imageUrl:
                  'https://i.seadn.io/gae/abCnMVBtrR9Z_V-ZhPUqqLasxPWqEJKuuxlhLReLpP-Rn_-axSHSZOJtXUHUcOx-mc3H9Do5xkykiWnWX7hACmjLztt-WrW9U-yV1wA?auto=format&w=1000'),
          SizedBox(height: 10),
          CustomCard2(
            imageUrl:
                'https://cdn1.epicgames.com/ue/product/Screenshot/1-1920x1080-dab564274b400e044d6641ad755ee628.jpg?resize=1&w=1920',
            name: 'Otro paisaje',
          ),
          SizedBox(height: 100),
        ],
      ),
    );
  }
}
