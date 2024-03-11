// ignore_for_file: use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:program/extensions/context.dart';
import 'package:program/plans/steal_image/screens/images.dart';

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
    final size = MediaQuery.of(context).size;
    final double imageWidth = size.width / 2;

    return Scaffold(
      appBar: AppBar(
        title: const Text('ホーム'),
      ),
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
                  MaterialPageRoute(builder: (_) => ImagesScreen(bytes: bytes)),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF805F95),
                foregroundColor: Colors.white,
              ),
              child: const Text(
                '画像データを盗む',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 120),
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
