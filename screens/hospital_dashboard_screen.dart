import 'package:flutter/material.dart';
import '../widgets/bottom_nav.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HospitalDashboardScreen extends StatelessWidget {
  const HospitalDashboardScreen({Key? key}) : super(key: key);

  Stream<QuerySnapshot> getRequestsStream() {
    return FirebaseFirestore.instance.collection('requests').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hospital Dashboard')),
      body: StreamBuilder<QuerySnapshot>(
        stream: getRequestsStream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          final docs = snapshot.data!.docs;
          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (_, i) {
              final data = docs[i].data() as Map<String, dynamic>;
              return ListTile(
                title: Text('${data['bloodGroup']} — ${data['urgency']}'),
                subtitle: Text('Status: ${data['status'] ?? 'open'}'),
                trailing: ElevatedButton(
                  onPressed: () {
                    // Approve/Assign placeholder
                    FirebaseFirestore.instance.collection('requests').doc(docs[i].id).update({'status': 'assigned'});
                  },
                  child: const Text('Assign'),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: const BottomNav(currentIndex: 0),
    );
  }
}
