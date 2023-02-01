import 'package:flutter/material.dart';

class BasicDesignScreen extends StatelessWidget {
  const BasicDesignScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Image(image: AssetImage('assets/landscape.jpg')),
          const Title(),
          const ButtonSection(),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: const Text(
              'Dolor ipsum anim sit laborum sit duis adipisicing nostrud minim sit aliqua. Excepteur ex reprehenderit consectetur excepteur. Amet elit mollit amet et tempor sit minim cupidatat aute dolor laborum mollit commodo. Enim duis incididunt Lorem adipisicing nostrud dolor commodo Lorem.',
            ),
          )
        ],
      ),
    );
  }
}

class Title extends StatelessWidget {
  const Title({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Oeschinen Lake Campground',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'Kandersteg, Switzerland',
                style: TextStyle(color: Colors.black45),
              ),
            ],
          ),
          Expanded(child: Container()),
          const Icon(
            Icons.star,
            color: Colors.red,
          ),
          const Text('41')
        ],
      ),
    );
  }
}

class ButtonSection extends StatelessWidget {
  const ButtonSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: const [
              Icon(
                Icons.phone,
                color: Colors.blue,
              ),
              SizedBox(
                height: 10,
              ),
              Text('CALL', style: TextStyle(color: Colors.blue)),
            ],
          ),
          Expanded(child: Container()),
          Column(
            children: const [
              Icon(Icons.send, color: Colors.blue),
              SizedBox(
                height: 10,
              ),
              Text('ROUTE', style: TextStyle(color: Colors.blue)),
            ],
          ),
          Expanded(child: Container()),
          Column(
            children: const [
              Icon(Icons.share, color: Colors.blue),
              SizedBox(
                height: 10,
              ),
              Text('SHARE', style: TextStyle(color: Colors.blue)),
            ],
          ),
        ],
      ),
    );
  }
}
