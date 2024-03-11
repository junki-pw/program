import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:program/extensions/context.dart';

class ImagesScreen extends StatelessWidget {
  const ImagesScreen({
    super.key,
    required this.bytes,
  });

  final List<Uint8List> bytes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('注意して下さい'),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            alignment: Alignment.center,
            child: const Text(
              'あなたのスマホに入ってる画像データは\n全世界に公開されました',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                Wrap(
                  children: [
                    for (final byte in bytes) _ImageTile(byte),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ImageTile extends StatelessWidget {
  const _ImageTile(this.byte);

  final Uint8List byte;

  @override
  Widget build(BuildContext context) {
    final width = context.deviceWidth / 5;
    return Container(
      width: width,
      height: width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: MemoryImage(byte),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
