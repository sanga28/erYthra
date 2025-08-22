import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';
import '../models/request_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // collections
  CollectionReference get usersRef => _db.collection('users');
  CollectionReference get requestsRef => _db.collection('requests');

  Future<void> createUser(AppUser user) async {
    await usersRef.doc(user.uid).set(user.toMap());
  }

  Future<Map<String, dynamic>?> getUser(String uid) async {
    final snap = await usersRef.doc(uid).get();
    if (snap.exists) return Map<String, dynamic>.from(snap.data() as Map);
    return null;
  }

  Future<void> updateUser(String uid, Map<String, dynamic> updates) async {
    await usersRef.doc(uid).update(updates);
  }

  Future<String> createRequest(BloodRequest request) async {
    final doc = requestsRef.doc();
    final req = request.toMap()..['id'] = doc.id;
    await doc.set(req);
    return doc.id;
  }

  Stream<List<Map<String, dynamic>>> streamOpenRequests() {
    return requestsRef.where('status', isEqualTo: 'open').snapshots().map((snap) {
      return snap.docs.map((d) => Map<String, dynamic>.from(d.data() as Map)).toList();
    });
  }

  Future<List<Map<String, dynamic>>> findPotentialDonors(String bloodGroup, GeoPoint location, {double radiusKm = 10}) async {
    // Simple stub: return donors with same bloodGroup
    final q = await usersRef.where('bloodGroup', isEqualTo: bloodGroup).get();
    return q.docs.map((d) => Map<String, dynamic>.from(d.data() as Map)).toList();
  }

  Future<void> assignDonorToRequest(String requestId, String donorId) async {
    await requestsRef.doc(requestId).update({
      'assignedDonorId': donorId,
      'status': 'assigned',
    });
  }
}
