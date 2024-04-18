import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final String mailAddress = 'flutter.database@gmail.com';
  final String mailTitle = '件名';
  final String mailContents = 'メール本文';
  final String website = 'https://github.com/trajanme';

  Future<void> launchURL(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw '$urlが立ち上がりません';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blue.shade50,
        appBar: AppBar(
          actions: [
            TextButton(
                onPressed: () {
                  Share.share('こんにちは。Shintaroです。');
                },
                child: const Icon(Icons.share))
          ],
          title: const Text('My Profile'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/image.png',
                height: 200,
              ),
              const Text(
                'Ishikawa Shintaro',
                style: TextStyle(fontSize: 30),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      '所属：',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text('○○株式会社')
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      '電話：',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text('070-xxxx-xxxx')
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Text(
                      'メール：',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Text('shintaro@example.com'),
                    TextButton(
                        onPressed: () async {
                          launchURL(
                              'mailto:$mailAddress?subject=$mailTitle&body=$mailContents');
                        },
                        child: const Icon(Icons.mail))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Text(
                      'Website：',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(website),
                    TextButton(
                        onPressed: () async {
                          launchURL(website);
                        },
                        child: const Icon(Icons.public))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
