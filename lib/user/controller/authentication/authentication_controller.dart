import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class AuthenticationController extends ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  final _storage = FirebaseStorage.instance;
  final _store = FirebaseFirestore.instance;

  get auth => _auth;
  get storage => _storage;
  get store => _store;

  Future signIn(String phoneNumber) async {
    final register = await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException exception) {},
      codeSent: (String verificationId, int? token) {},
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

}
