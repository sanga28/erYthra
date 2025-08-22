import 'package:flutter/material.dart';

class DonorProfileScreen extends StatelessWidget {
  const DonorProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final donor = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    if (donor == null) {
      return Scaffold(body: Center(child: Text('No donor data')));
    }

    return Scaffold(
      appBar: AppBar(title: Text(donor['name'] ?? 'Donor')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          CircleAvatar(radius: 40, backgroundColor: Theme.of(context).primaryColor, child: Text(donor['bloodGroup'] ?? 'O+')),
          const SizedBox(height: 12),
          Text(donor['name'] ?? 'Donor', style: Theme.of(context).textTheme.headline6),
          const SizedBox(height: 8),
          Text('Blood group: ${donor['bloodGroup'] ?? 'O+'}'),
          Text('Trust score: ${donor['trustScore'] ?? 0}'),
          const SizedBox(height: 16),
          ElevatedButton.icon(onPressed: () {/* start chat or call */}, icon: const Icon(Icons.message), label: const Text('Contact')),
        ]),
      ),
    );
  }
}
