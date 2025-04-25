class AuthValidator {
  static String? validateEmail(String value) {
    if (value.isEmpty) return 'Email cannot be empty';
    return null;
  }

  static String? validatePassword(String value) {
    if (value.length < 6) return 'Password must be at least 6 characters';
    return null;
  }
}