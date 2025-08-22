import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RequestForm extends StatefulWidget {
  final Function(String bloodGroup, String urgency, GeoPoint? location) onSubmit;
  const RequestForm({Key? key, required this.onSubmit}) : super(key: key);

  @override
  State<RequestForm> createState() => _RequestFormState();
}

class _RequestFormState extends State<RequestForm> {
  final _formKey = GlobalKey<FormState>();
  String _bloodGroup = 'A+';
  String _urgency = 'medium';
  GeoPoint? _location; // optional for now

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(children: [
        DropdownButtonFormField<String>(
          value: _bloodGroup,
          items: ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-']
              .map((g) => DropdownMenuItem(value: g, child: Text(g)))
              .toList(),
          onChanged: (v) => setState(() => _bloodGroup = v!),
          decoration: const InputDecoration(labelText: 'Blood Group'),
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<String>(
          value: _urgency,
          items: ['low', 'medium', 'high']
              .map((u) => DropdownMenuItem(value: u, child: Text(u.capitalize())))
              .toList(),
          onChanged: (v) => setState(() => _urgency = v!),
          decoration: const InputDecoration(labelText: 'Urgency'),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              widget.onSubmit(_bloodGroup, _urgency, _location);
            }
          },
          child: const Text('Request Blood'),
        ),
      ]),
    );
  }
}

extension StringCap on String {
  String capitalize() => isEmpty ? this : '${this[0].toUpperCase()}${substring(1)}';
}
