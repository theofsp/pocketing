import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/child.dart';

class ChildService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  String get _uid => FirebaseAuth.instance.currentUser!.uid;

  CollectionReference<Map<String, dynamic>> get _childrenRef =>
      _db.collection('users').doc(_uid).collection('children');

  Future<void> addChild(Child child) async {
    await _childrenRef.add(child.toMap());
  }

  Stream<List<Child>> getChildren() {
    return _childrenRef.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Child.fromMap(doc.id, doc.data())).toList();
    });
  }

  Future<void> updateChild(Child child) async {
    await _childrenRef.doc(child.id).update(child.toMap());
  }

  Future<void> deleteChild(String childId) async {
    await _childrenRef.doc(childId).delete();
  }

  // FUNGSI BARU: Cek apakah orang tua ini sudah punya minimal 1 anak terdaftar
  Future<bool> hasChildren() async {
    final list = await getChildren().first;
    return list.isNotEmpty;
  }
}