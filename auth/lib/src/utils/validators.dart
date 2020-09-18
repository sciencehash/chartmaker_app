class Validators {
  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );
  static final RegExp _passwordRegExp = RegExp(
    // r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%\^&\*])(?=.{8,})',
  );

  static bool isValidName(String name) {
    return name.trim().isNotEmpty;
  }

  static bool isValidEmail(String email) {
    return _emailRegExp.hasMatch(email.trim());
  }

  static bool isValidPassword(String password) {
    return _passwordRegExp.hasMatch(password.trim());
  }
}