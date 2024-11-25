import 'package:mongo_dart/mongo_dart.dart';

import '../utils/password_hash.dart';


class DatabaseService {
  static const String connectionString = 'mongodb://127.0.0.1:27017/loginSystem';
  static const String collectionName = 'users';

  static Db? _db;

  static Future<void> connect() async {
    try {
      _db = await Db.create(connectionString);
      await _db!.open();
      print('Connected to MongoDB successfully');
    } catch (e) {
      print('Connection error: $e');
      _db = null;
      rethrow;
    }
  }

  static Future<void> registerUser(String username, String email, String password) async {
    if (_db == null) {
      throw Exception('Database connection not established');
    }

    try {
      // Überprüfe ob Benutzer bereits existiert
      var existingUser = await _db!.collection(collectionName).findOne({
        '\$or': [
          {'username': username},
          {'email': email}
        ]
      });

      if (existingUser != null) {
        if (existingUser['username'] == username) {
          throw Exception('Username already exists');
        } else {
          throw Exception('Email already exists');
        }
      }

      // Hash das Passwort vor dem Speichern
      String hashedPassword = hashPassword(password);

      await _db!.collection(collectionName).insertOne({
        'username': username,
        'email': email,
        'password': hashedPassword,
        'created_at': DateTime.now(),
      });
      
      print('User registered successfully');
    } catch (e) {
      print('Registration error: $e');
      rethrow;
    }
  }

  static Future<bool> loginUser(String username, String password) async {
    if (_db == null) {
      throw Exception('Database connection not established');
    }

    try {
      // Hash das eingegebene Passwort zum Vergleich
      String hashedPassword = hashPassword(password);

      var user = await _db!.collection(collectionName).findOne({
        'username': username,
        'password': hashedPassword,
      });
      
      return user != null;
    } catch (e) {
      print('Login error: $e');
      rethrow;
    }
  }
}
