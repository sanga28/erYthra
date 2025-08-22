import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/bottom_nav.dart';
import '../services/auth_service.dart';
import '../services/firestore_service.dart';
import '../widgets/donor_card.dart';
import '../routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> donors = [];

  @override
  void initState() {
    super.initState();
    _loadNearbyDonors();
  }

  Future<void> _loadNearbyDonors() async {
    // For MVP: load all donors - ideally use geolocation filter
    final fs = FirestoreService();
    final list = await fs.findPotentialDonors('A+', null); // stub: pass group dynamically
    setState(() => donors = list);
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context);
    final name = auth.currentUser?.name ?? 'User';
    return Scaffold(
      appBar: AppBar(
        title: const Text('Erythra Dashboard'),
        actions: [
          IconButton(onPressed: () => Navigator.pushNamed(context, Routes.profile), icon: const Icon(Icons.settings)),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Row(children: [
              Expanded(child: Text('Hello, $name', style: Theme.of(context).textTheme.headline6)),
              ElevatedButton.icon(
                onPressed: () => Navigator.pushNamed(context, Routes.request),
                icon: const Icon(Icons.add),
                label: const Text('Request Blood'),
              ),
            ]),
          ),
          const Divider(),
          const Padding(padding: EdgeInsets.symmetric(horizontal: 12.0), child: Text('Nearby Donors', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
          Expanded(
            child: donors.isEmpty
                ? const Center(child: Text('No donors found yet.'))
                : ListView.builder(
              itemCount: donors.length,
              itemBuilder: (_, i) {
                final d = donors[i];
                return DonorCard(
                  name: d['name'] ?? 'Donor',
                  bloodGroup: d['bloodGroup'] ?? 'O+',
                  trustScore: d['trustScore'] ?? 0,
                  onTap: () {
                    Navigator.pushNamed(context, Routes.donorProfile, arguments: d);
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNav(currentIndex: 0),
    );
  }
}
