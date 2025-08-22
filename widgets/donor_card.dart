import 'package:flutter/material.dart';

class DonorCard extends StatelessWidget {
  final String name;
  final String bloodGroup;
  final int trustScore;
  final VoidCallback? onTap;
  const DonorCard({
    Key? key,
    required this.name,
    required this.bloodGroup,
    this.trustScore = 0,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).primaryColor,
          child: Text(bloodGroup, style: const TextStyle(color: Colors.white)),
        ),
        title: Text(name),
        subtitle: Text('Trust: $trustScore'),
        trailing: ElevatedButton(
          onPressed: onTap,
          child: const Text('Contact'),
        ),
      ),
    );
  }
}
