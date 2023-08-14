import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:multi_vendor_admin/views/screens/sidebar_screens/widgets/banner_widget.dart';
import 'package:multi_vendor_admin/widget_setting/color_collections.dart';

class UploadBannerScreen extends StatefulWidget {
  static const String routeName = '/Banner';

  @override
  State<UploadBannerScreen> createState() => _UploadBannerScreenState();
}

class _UploadBannerScreenState extends State<UploadBannerScreen> {
  dynamic _image;
  String? fileName;

  _pickImage() async {
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
    if (_image == null) {
      Fluttertoast.showToast(
          msg: 'Please Select Image First',
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.white,
          textColor: Colors.red,
          fontSize: 16.0);
      return;
    }

    EasyLoading.show();

    try {
      String imageUrl = await _uploadBannersToStorage(_image);

      await _firestore
          .collection('banners')
          .doc(fileName)
          .set({'image': imageUrl});

      setState(() {
        Fluttertoast.showToast(
            msg: "Image uploaded successfully!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            backgroundColor: Colors.yellow,
            textColor: Colors.green);
        _image = null;
      });
    } catch (error) {
      Fluttertoast.showToast(
          msg: 'An error occurred: $error',
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.white,
          textColor: Colors.red,
          fontSize: 16.0);
    } finally {
      EasyLoading.dismiss();
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
          Divider(
            color: iconClr,
            height: 2,
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                  height: 10,
                ),
                SizedBox(
                  width: 400,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            _pickImage();
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
                  ),
                )
              ],
            ),
          ),
          Divider(
            color: iconClr,
            height: 2,
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Existing Categories',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 26,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: AdminBannerWidget(),
          ),
        ],
      ),
    );
  }
}
