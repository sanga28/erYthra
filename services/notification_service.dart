// Stub for push notifications. Implement firebase_messaging in production.
import 'package:flutter/material.dart';

class NotificationService {
  Future<void> init() async {
    // configure firebase_messaging & local notifications
  }

  Future<void> sendLocalNotification(String title, String body) async {
    // implement local notification or FCM message send
  }
}
