import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pos_app/data/datasource/service/auth_service.dart';
import 'package:shimmer/shimmer.dart';

class PickImageScreen extends StatefulWidget {
  const PickImageScreen({super.key});

  @override
  State<PickImageScreen> createState() => _PickImageScreenState();
}

class _PickImageScreenState extends State<PickImageScreen> {
  File pickedImage = File('');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pick Image')),
      body: Column(
        children: [
          Row(
            children: [
              IconButton.filled(
                onPressed: () async {
                  final picker = ImagePicker();

                  final XFile? image = await picker.pickImage(
                    source: ImageSource.gallery,
                  );

                  final File result = File(image!.path);

                  setState(() {
                    pickedImage = result;
                  });
                },
                icon: Icon(Icons.folder),
              ),
              IconButton.filled(
                onPressed: () async {
                  final picker = ImagePicker();

                  final XFile? image = await picker.pickImage(
                    source: ImageSource.camera,
                  );

                  final File result = File(image!.path);

                  setState(() {
                    pickedImage = result;
                  });
                },
                icon: Icon(Icons.camera),
              ),
            ],
          ),
          Image.file(
            pickedImage,
            errorBuilder: (context, error, stackTrace) {
              return Icon(Icons.image_not_supported_outlined);
            },
          ),
          Image.network(
            'https://letsenhance.io/static/73136da51c245e80edc6ccfe44888a99/1015f/MainBefore.jpg',
            errorBuilder: (context, error, stackTrace) {
              return Icon(Icons.image_not_supported_outlined);
            },
            loadingBuilder: (context, child, loadingProgress) {
              return Shimmer.fromColors(
                baseColor: Color(0xffedeef1),
                highlightColor: Color(0xfff6f7f8),
                child: Container(
                  margin: EdgeInsets.all(10),
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    color: Colors.white,
                  ),
                ),
              );
            },
          ),
          ElevatedButton(
            onPressed: () {
              AuthService().createProduct(pickedImage, 'contoh', '');
            },
            child: Text('Kirim'),
          ),
        ],
      ),
    );
  }
}
