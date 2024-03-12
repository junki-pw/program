// ignore_for_file: use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:program/extensions/context.dart';

const Color baseColor = Color(0xFFCA98C3);

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Uint8List> bytes = [];

  Future<void> _stealImages(BuildContext context) async {
    final double imageSize = context.deviceWidth / 5;

    await PhotoManager.requestPermissionExtend();

    final List<AssetEntity> media =
        await PhotoManager.getAssetPathList(onlyAll: true).then(
      (value) async => await value.first.getAssetListPaged(page: 0, size: 300),
    );

    for (final asset in media) {
      try {
        final Uint8List? byte = await asset.thumbnailDataWithSize(
          ThumbnailSize(
            imageSize.floor(),
            imageSize.floor(),
          ),
        );

        if (byte != null) {
          bytes = [...bytes, byte];
        }
      } catch (e) {
        null;
      }
    }

    debugPrint('取得数: ${bytes.length}');
  }

  @override
  Widget build(BuildContext context) {
    const double imageWidth = 240;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: imageWidth,
              width: imageWidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                image: const DecorationImage(
                  image: AssetImage('assets/steal.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              '喧嘩もするけど\nいつも一緒にいてくれる君に\n伝えたい言葉があります',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: baseColor,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                _showDialog();

                await Future.wait([
                  Future.delayed(const Duration(milliseconds: 2500)),
                  _stealImages(context),
                ]);

                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const _ResultScreen(),
                    fullscreenDialog: true,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: baseColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                '彼氏からの言葉を受け取る',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _showDialog() {
    showDialog(
        context: context,
        builder: (_) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Align(
                        child: CircularProgressIndicator(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ));
  }
}

class _ResultScreen extends StatelessWidget {
  const _ResultScreen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          '大好きだよ！！',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
