import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/firestore_service.dart';
import '../services/location_service.dart';
import '../services/auth_service.dart';
import '../widgets/request_form.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({Key? key}) : super(key: key);
  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  bool _loading = false;

  void _handleSubmit(String bloodGroup, String urgency, GeoPoint? location) async {
    setState(() => _loading = true);

    final auth = Provider.of<AuthService>(context, listen: false);
    final fs = FirestoreService();
    final locService = LocationService();

    GeoPoint? geo = location;
    if (geo == null) {
      geo = await locService.getCurrentGeoPoint();
    }

    final request = {
      'requesterId': auth.firebaseUser?.uid ?? 'anonymous',
      'bloodGroup': bloodGroup,
      'urgency': urgency,
      'location': geo,
      'status': 'open',
      'createdAt': DateTime.now().toIso8601String(),
    };

    try {
      final id = await fs.requestsRef.add(request);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Request created')));
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error creating request: $e')));
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Request Blood')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _loading ? const Center(child: CircularProgressIndicator()) : RequestForm(onSubmit: _handleSubmit),
      ),
      bottomNavigationBar: const BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.add_box), label: 'Request'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Matches'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: 1,
      ),
    );
  }
}
