// lib/services/auth_service.dart
// MOCK MODE — no Firebase dependency. Swap back to real Firebase later.
import '../models/user.dart';
import '../utils/constants.dart';

/// Mock AuthService for local testing without Firebase.
/// All sign-in / sign-up calls succeed instantly with a fake user.
class AuthService {
  AuthService._privateConstructor();
  static final AuthService instance = AuthService._privateConstructor();

  MockUser? _currentUser;
  MockUser? get currentUser => _currentUser;

  /// Simulate email sign-in.
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    _currentUser = MockUser(
      uid: 'mock-uid-001',
      email: email,
      role: _roleFromEmail(email),
    );
  }

  /// Simulate phone sign-in.
  Future<void> signInWithPhone({required String phone}) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    _currentUser = MockUser(
      uid: 'mock-uid-phone',
      email: phone,
      role: UserRole.creator,
    );
  }

  /// Simulate sign-up.
  Future<void> signUp({
    required String email,
    required String password,
    UserRole defaultRole = UserRole.creator,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    _currentUser = MockUser(
      uid: 'mock-uid-new',
      email: email,
      role: defaultRole,
    );
  }

  /// Simulate phone sign-up.
  Future<void> signUpWithPhone({required String phone}) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    _currentUser = MockUser(
      uid: 'mock-uid-phone-new',
      email: phone,
      role: UserRole.creator,
    );
  }

  Future<void> signOut() async {
    _currentUser = null;
  }

  Future<MockUser?> getCurrentUser() async {
    return _currentUser;
  }

  /// Helper: if the email contains "admin" → admin, "brand" → brand, else creator.
  UserRole _roleFromEmail(String email) {
    final lower = email.toLowerCase();
    if (lower.contains('admin')) return UserRole.admin;
    if (lower.contains('brand')) return UserRole.brand;
    return UserRole.creator;
  }
}
