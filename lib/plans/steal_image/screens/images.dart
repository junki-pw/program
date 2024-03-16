import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:program/extensions/context.dart';

class ImagesScreen extends StatelessWidget {
  const ImagesScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '浮気チェック',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 24),
        children: [
          Align(
            child: Container(
              height: 160,
              width: 160,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                image: const DecorationImage(
                  image: AssetImage('assets/steal.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Text(
              '彼女の画像データを\n一覧表示',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Wrap(
            children: [
              for (final byte in []) _ImageTile(byte),
            ],
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
