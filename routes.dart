import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/request_screen.dart';
import 'screens/matches_screen.dart';
import 'screens/donor_profile_screen.dart';
import 'screens/hospital_dashboard_screen.dart';
import 'screens/profile_screen.dart';

class Routes {
  static const splash = '/';
  static const login = '/login';
  static const home = '/home';
  static const request = '/request';
  static const matches = '/matches';
  static const donorProfile = '/donor';
  static const hospital = '/hospital';
  static const profile = '/profile';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      splash: (_) => const SplashScreen(),
      login: (_) => const LoginScreen(),
      home: (_) => const HomeScreen(),
      request: (_) => const RequestScreen(),
      matches: (_) => const MatchesScreen(),
      donorProfile: (_) => const DonorProfileScreen(),
      hospital: (_) => const HospitalDashboardScreen(),
      profile: (_) => const ProfileScreen(),
    };
  }
}
