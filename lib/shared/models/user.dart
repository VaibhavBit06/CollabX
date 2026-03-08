// lib/models/user.dart
import '../utils/constants.dart';

class MockUser {
  final String uid;
  final String email;
  final UserRole role;

  const MockUser({
    required this.uid,
    required this.email,
    required this.role,
  });
}
