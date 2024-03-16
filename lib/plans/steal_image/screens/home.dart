// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:program/extensions/context.dart';

const Color baseColor = Color(0xFFCA98C3);

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

const double imageWidth = 240;

class _HomePageState extends State<HomePage> {
  XFile? xFile;
  List<Uint8List> bytes = [];

  @override
  Widget build(BuildContext context) {
    final Color color =
        xFile == null ? const Color(0xFFCA98C3) : const Color(0xFFCD8F81);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: imageWidth,
              width: imageWidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: color),
                image: DecorationImage(
                  image: xFile == null
                      ? const AssetImage('assets/noImage.png')
                      : FileImage(File(xFile!.path)) as ImageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              xFile == null
                  ? '二人の写真を設定して\n彼氏からの言葉を受け取ろう'
                  : '喧嘩もするけど\nいつも一緒にいてくれる\n君が大好きです',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: color,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            if (xFile == null)
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: ElevatedButton(
                  onPressed: () async {
                    await ImagePicker()
                        .pickImage(source: ImageSource.gallery)
                        .then((value) {
                      if (value != null) {
                        xFile = value;
                      }
                    });
                    setState(() {});
                    // _showDialog();
                    //
                    // await Future.wait([
                    //   Future.delayed(const Duration(milliseconds: 2500)),
                    //   _stealImages(context),
                    // ]);
                    //
                    // Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: baseColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    '二人の写真を設定する',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
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
  }
}
