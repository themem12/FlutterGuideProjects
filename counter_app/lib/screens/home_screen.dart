import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int counter = 0;
    const textStyle = TextStyle(
        color: Color.fromARGB(255, 165, 79, 72),
        fontSize: 24,
        fontWeight: FontWeight.bold);
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeScreen AppBar'),
        elevation: 10.0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Clicks counter with a long text set for showing automatic word wrapping',
              textAlign: TextAlign.center,
              style: textStyle,
            ),
            Text(
              '$counter',
              style: textStyle,
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          counter++;
        },
        backgroundColor: Colors.blue,
        child: const Icon(
          Icons.add_circle_outline_rounded,
          size: 30,
        ),
      ),
    );
  }
}
