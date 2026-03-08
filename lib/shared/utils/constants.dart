/// Global constants: spacing, regexes, keys, etc.
class AppConstants {
  AppConstants._();

  static const double spacingXs = 4.0;
  static const double spacingSm = 8.0;
  static const double spacingMd = 16.0;
  static const double spacingLg = 24.0;
  static const double spacingXl = 32.0;

  static const double radiusSm = 8.0;
  static const double radiusMd = 12.0;
  static const double radiusLg = 16.0;
  static const double radiusPill = 999.0;
}

enum UserRole { creator, admin }

enum CreatorType {
  collegeStudent,
  schoolStudent16Plus,
  independent,
}

extension CreatorTypeX on CreatorType {
  String get label {
    switch (this) {
      case CreatorType.collegeStudent:
        return 'College Student';
      case CreatorType.schoolStudent16Plus:
        return 'School Student 16+';
      case CreatorType.independent:
        return 'Independent';
    }
  }
}
