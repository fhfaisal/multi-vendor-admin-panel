import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:multi_vendor_admin/widget_setting/color_collections.dart';

class AdminBannerWidget extends StatelessWidget {

  final Stream<QuerySnapshot> _bannersStream =
  FirebaseFirestore.instance.collection('banners').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _bannersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(color: iconClr),
          );
        }

        return GridView.builder(
          itemCount: snapshot.data!.docs.length,
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 6, crossAxisSpacing: 8, mainAxisSpacing: 8,childAspectRatio: 0.2),
          itemBuilder: (context, index) {
            final bannerData = snapshot.data!.docs[index];
            final imageUrl = bannerData['image'].toString();

            return Column(
              children: [
                SizedBox(
                  height: 100,
                  width: 100,
                  child: Image.network(imageUrl),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
