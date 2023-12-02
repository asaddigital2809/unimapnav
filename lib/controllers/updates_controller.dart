import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class UpdatesController extends GetxController{
  final StreamController<List<DocumentSnapshot>> _controller = StreamController.broadcast();

  Stream<List<DocumentSnapshot>> get stream => _controller.stream;
  @override
  onInit(){
    super.onInit();
    getStreamUpdates();
  }

  getStreamUpdates() async{
    FirebaseFirestore.instance.collection('posts').orderBy(
        'createdAt', descending: true
    ).snapshots().listen((snapshot) {
      _controller.add(snapshot.docs);
    }, onError: (error) {
      _controller.addError(error);
    });

  }
}