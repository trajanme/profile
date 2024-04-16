import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final String mailAddress = 'flutter.database@gmail.com';
  final String mailTitle = '件名';
  final String mailContents = 'メール本文';

  Future<void> launchURL(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw '$urlが立ち上がりません';
    }
  }

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
              Image.asset(
                'assets/image.png',
                height: 200,
              ),
              const Text('Ishikawa Shintaro'),
              const Row(
                children: [Text('所属：'), Text('○○株式会社')],
              ),
              const Row(
                children: [Text('電話：'), Text('070-xxxx-xxxx')],
              ),
              Row(
                children: [
                  const Text('メール：'),
                  const Text('shintaro@example.com'),
                  TextButton(
                      onPressed: () async {
                        launchURL(
                            'mailto:$mailAddress?subject=$mailTitle&body=$mailContents');
                      },
                      child: const Icon(Icons.mail))
                ],
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
