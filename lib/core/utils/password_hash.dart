import 'dart:convert';
import 'package:crypto/crypto.dart';

String hashPassword(String password) {
  // Erstelle einen Salt (zusätzliche Sicherheit)
  final salt = 'your_secret_salt_here';
  final bytes = utf8.encode(password + salt);
  final hash = sha256.convert(bytes);
  return hash.toString();
}
