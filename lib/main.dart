import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';
import 'package:screenshot/screenshot.dart';
import 'package:path_provider/path_provider.dart';

import 'count.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider<Count>(
          create: (context) => Count(), child: Home()),
    );
  }
}

class Home extends StatelessWidget {
  Home({super.key});

  final String mailAddress = 'flutter.database@gmail.com';
  final String mailTitle = '件名';
  final String mailContents = 'メール本文';
  final String website = 'https://github.com/trajanme';

  ScreenshotController screenshotController = ScreenshotController();

  Future<void> launchURL(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw '$urlが立ち上がりません';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () async {
                await screenshotController
                    .capture(delay: const Duration(milliseconds: 10))
                    .then((image) async {
                  if (image != null) {
                    final directory =
                        (await getApplicationDocumentsDirectory()).path;
                    final imagePath =
                        await File('$directory/image.png').create();
                    await imagePath.writeAsBytes(image);

                    await Share.shareXFiles([XFile(imagePath.path)],
                        text: '私のプロフィールです');
                  }
                });
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
            Screenshot(
              controller: screenshotController,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          Provider.of<Count>(context, listen: false)
                              .countIncremented();
                        },
                        child: const Icon(Icons.thumb_up),
                      ),
                      Text(
                        '${Provider.of<Count>(context).count} likes',
                        style: const TextStyle(fontSize: 30),
                      ),
                    ],
                  ),
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
    );
  }
}
