import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('My Profile'),
        ),
        body: Center(
          child: Column(
            children: [
              Image.asset('assets/image.png'),
              const Text('Ishikawa Shintaro'),
              const Row(
                children: [Text('所属：'), Text('○○株式会社')],
              ),
              const Row(
                children: [Text('電話：'), Text('070-xxxx-xxxx')],
              ),
              const Row(
                children: [Text('メール：'), Text('shintaro@example.com')],
              ),
              const Row(
                children: [Text('Website：'), Text('https://example.com')],
              )
            ],
          ),
        ),
      ),
    );
  }
}
