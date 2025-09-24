class PasswordValidator {
  static final RegExp minLength = RegExp(r'^.{8,}$');
  static final RegExp hasUppercase = RegExp(r'[A-Z]');
  static final RegExp hasDigit = RegExp(r'\d');
  static final RegExp hasSpecial = RegExp(r'[!@#\$&*~%^.,?_]');

  static String? validate(String password) {
    if (password.isEmpty) {
      return "Password cannot be empty.";
    } else if (!minLength.hasMatch(password)) {
      return "At least 8 characters required.";
    } else if (!hasUppercase.hasMatch(password)) {
      return "Must contain at least one uppercase letter.";
    } else if (!hasDigit.hasMatch(password)) {
      return "Must contain at least one digit.";
    } else if (!hasSpecial.hasMatch(password)) {
      return "Must contain at least one special character.";
    }
    return null;
  }

  static String strength(String password) {
    int score = 0;
    if (minLength.hasMatch(password)) score++;
    if (hasUppercase.hasMatch(password)) score++;
    if (hasDigit.hasMatch(password)) score++;
    if (hasSpecial.hasMatch(password)) score++;

    if (score <= 1) return "Weak";
    if (score == 2 || score == 3) return "Medium";
    return "Strong";
  }
}
