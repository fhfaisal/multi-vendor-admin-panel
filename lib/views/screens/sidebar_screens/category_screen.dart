import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:multi_vendor_admin/views/screens/sidebar_screens/widgets/category_widget.dart';
import 'package:multi_vendor_admin/widget_setting/color_collections.dart';

class CategoryScreen extends StatefulWidget {
  static const String routeName = '/Category';

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  dynamic _image;
  String? fileName;
  late String categoryName;

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

  _uploadCategoryToFirestore(image) async {
    Reference ref = _storage.ref().child('categoryImages').child(fileName!);
    UploadTask uploadTask = ref.putData(image);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  _uploadCategory() async {
    try {
      if (_image == null) {
        Fluttertoast.showToast(
          msg: 'Please select image',
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white, // Set textColor for better visibility
          fontSize: 16.0,
        );
        return;
      }

      EasyLoading.show();

      if (_formKey.currentState!.validate()) {
        String imageUrl = await _uploadCategoryToFirestore(_image);

        await _firestore
            .collection('categories')
            .doc(fileName)
            .set({'image': imageUrl, 'categoryName': categoryName});
        setState(() {
          _image==null;
          _formKey.currentState!.reset();
        });

        Fluttertoast.showToast(
          msg: 'Category uploaded successfully',
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white, // Set textColor for better visibility
          fontSize: 16.0,
        );
      }
    } catch (error) {
      print('An error occurred during category upload: $error');
      Fluttertoast.showToast(
        msg: 'An error occurred during category upload',
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } finally {
      setState(() {
        _image==null;
      });
      EasyLoading.dismiss();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.all(10),
              child: const Text(
                'Categories',
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
                        : Center(child: Text('Upload Category Image')),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: 400,
                    child: Column(
                      children: [
                        TextFormField(
                          onChanged: (value) {
                            categoryName = value;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              Fluttertoast.showToast(
                                  msg: 'Category Name Must Needed',
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 2,
                                  backgroundColor: Colors.white,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                              return "field can not be empty";
                            } else
                              null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Category Name',
                            hintText: 'Enter category name',
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 2, color: iconClr)),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 2, color: iconClr)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 3, color: Colors.green)),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  _pickImage();
                                },
                                child: Text('Upload Image')),
                            SizedBox(
                              width: 10,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  _uploadCategory();
                                },
                                child: Text('Save ')),
                          ],
                        )
                      ],
                    ),
                  ),
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
              child: AdminCategoryWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
