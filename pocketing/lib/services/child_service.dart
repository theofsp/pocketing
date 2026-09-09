import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/child.dart';

class ChildService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Ambil ID orang tua yang sedang login
  String get _uid => FirebaseAuth.instance.currentUser!.uid;

  // Alamat folder tempat data anak-anak si orang tua ini disimpan
  CollectionReference<Map<String, dynamic>> get _childrenRef =>
      _db.collection('users').doc(_uid).collection('children');

  // FUNGSI 1: Simpan data anak BARU ke Firestore
  Future<void> addChild(Child child) async {
    await _childrenRef.add(child.toMap());
  }

  // FUNGSI 2: Ambil SEMUA data anak milik orang tua yang login
  Stream<List<Child>> getChildren() {
    return _childrenRef.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => Child.fromMap(doc.id, doc.data()))
          .toList();
    });
  }

  // FUNGSI 3: Update data anak yang sudah ada (misal ubah saldo)
  Future<void> updateChild(Child child) async {
    await _childrenRef.doc(child.id).update(child.toMap());
  }

  // FUNGSI 4: Hapus data anak
  Future<void> deleteChild(String childId) async {
    await _childrenRef.doc(childId).delete();
  }
}