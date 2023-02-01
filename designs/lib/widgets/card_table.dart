import 'dart:ui';

import 'package:flutter/material.dart';

class CardTable extends StatelessWidget {
  const CardTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Table(
      children: const [
        TableRow(
          children: [
            _SingleCard(Icons.border_all, Colors.blue, 'General'),
            _SingleCard(Icons.train, Colors.purple, 'Transport'),
          ],
        ),
        TableRow(
          children: [
            _SingleCard(Icons.shopping_bag_rounded, Colors.pink, 'Shopping'),
            _SingleCard(Icons.receipt_long, Colors.orange, 'Bills'),
          ],
        ),
        TableRow(
          children: [
            _SingleCard(Icons.movie_filter, Colors.cyanAccent, 'Entertainment'),
            _SingleCard(
                Icons.local_grocery_store_sharp, Colors.green, 'Grocery'),
          ],
        ),
        TableRow(
          children: [
            _SingleCard(Icons.border_all, Colors.blue, 'General'),
            _SingleCard(Icons.train, Colors.purple, 'Transporte'),
          ],
        ),
      ],
    );
  }
}

class _SingleCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String text;

  const _SingleCard(this.icon, this.color, this.text);

  @override
  Widget build(BuildContext context) {
    return _CardBackground(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: color,
            radius: 30,
            child: Icon(
              icon,
              size: 35,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            text,
            style: TextStyle(color: color, fontSize: 18),
          )
        ],
      ),
    );
  }
}

class _CardBackground extends StatelessWidget {
  final Widget child;

  const _CardBackground({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            height: 180,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(62, 66, 107, 0.7),
              borderRadius: BorderRadius.circular(20),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
