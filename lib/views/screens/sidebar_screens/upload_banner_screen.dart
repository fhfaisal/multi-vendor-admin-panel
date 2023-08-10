import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:multi_vendor_admin/widget_setting/color_collections.dart';

class UploadBannerScreen extends StatefulWidget {
  static const String routeName = '/Banner';

  @override
  State<UploadBannerScreen> createState() => _UploadBannerScreenState();
}

class _UploadBannerScreenState extends State<UploadBannerScreen> {
  dynamic _image;
  String? fileName;

  pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.image,
    );
    setState(() {
      if (result != null) {
        _image = result.files.first.bytes;
        fileName = result.files.first.name;
      }
    });
  }

  final FirebaseStorage _storage = FirebaseStorage.instance;

  _uploadBannersToStorage(dynamic image) async {
    Reference ref = _storage.ref().child('Banners').child(fileName!);
    UploadTask uploadTask = ref.putData(image);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  uploadToFirestore() async {
    if (_image != null) {
      String imageUrl = await _uploadBannersToStorage(_image);
      await _firestore
          .collection('banners')
          .doc(fileName)
          .set({'image': imageUrl});
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Banners',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 36,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      height: 140,
                      width: 400,
                      decoration: BoxDecoration(
                        color: cardColor,
                        border: Border.all(color: iconClr, width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: _image != null
                          ? Image.memory(
                              _image,
                              fit: BoxFit.cover,
                            )
                          : Center(child: Text('Upload Banner')),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          pickImage();
                        },
                        child: Text('Upload Banner')),
                    SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          uploadToFirestore();
                        },
                        child: Text('Save ')),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
