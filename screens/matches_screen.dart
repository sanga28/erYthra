import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/donor_card.dart';
import '../services/firestore_service.dart';
import '../widgets/bottom_nav.dart';

class MatchesScreen extends StatefulWidget {
  const MatchesScreen({Key? key}) : super(key: key);

  @override
  State<MatchesScreen> createState() => _MatchesScreenState();
}

class _MatchesScreenState extends State<MatchesScreen> {
  List<Map<String, dynamic>> donors = [];

  @override
  void initState() {
    super.initState();
    _loadMatches();
  }

  Future<void> _loadMatches() async {
    final fs = FirestoreService();
    final res = await fs.findPotentialDonors('A+', null);
    setState(() => donors = res);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Matched Donors')),
      body: donors.isEmpty
          ? const Center(child: Text('No matches yet'))
          : ListView.builder(
        itemCount: donors.length,
        itemBuilder: (_, i) {
          final d = donors[i];
          return DonorCard(name: d['name'] ?? 'Donor', bloodGroup: d['bloodGroup'] ?? 'O+', trustScore: d['trustScore'] ?? 0);
        },
      ),
      bottomNavigationBar: const BottomNav(currentIndex: 2),
    );
  }
}
