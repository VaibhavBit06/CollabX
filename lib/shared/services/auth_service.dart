// lib/services/auth_service.dart
import '../models/user.dart';
import '../utils/constants.dart';

/// Stub that mimics Firebase Auth. Replace with real Firebase when ready.
class AuthService {
  AuthService._privateConstructor();
  static final AuthService instance = AuthService._privateConstructor();

  MockUser? _currentUser;

  /// Sync access for routing after sign-in (e.g. from login screen).
  MockUser? get currentUser => _currentUser;

  /// Email sign-in. Role from email: contains "admin" → admin, else → creator.
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 800));
    final role = email.toLowerCase().contains('admin')
        ? UserRole.admin
        : UserRole.creator;
    _currentUser = MockUser(
      uid: 'uid_${DateTime.now().millisecondsSinceEpoch}',
      email: email,
      role: role,
    );
  }

  /// Phone OTP sign-in. Creators only (admin uses email).
  Future<void> signInWithPhone({required String phone}) async {
    await Future<void>.delayed(const Duration(milliseconds: 800));
    _currentUser = MockUser(
      uid: 'phone_${DateTime.now().millisecondsSinceEpoch}',
      email: phone,
      role: UserRole.creator,
    );
  }

  /// Sign up with email. Creates creator role only.
  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 800));
    _currentUser = MockUser(
      uid: 'uid_${DateTime.now().millisecondsSinceEpoch}',
      email: email,
      role: UserRole.creator,
    );
  }

  /// Sign up with phone OTP. Creates creator role only.
  Future<void> signUpWithPhone({required String phone}) async {
    await Future<void>.delayed(const Duration(milliseconds: 800));
    _currentUser = MockUser(
      uid: 'phone_${DateTime.now().millisecondsSinceEpoch}',
      email: phone,
      role: UserRole.creator,
    );
  }

  Future<void> signOut() async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    _currentUser = null;
  }

  Future<MockUser?> getCurrentUser() async {
    await Future<void>.delayed(const Duration(milliseconds: 400));
    return _currentUser;
  }
}
