import 'package:lab_coffee/core/domain/user.dart';

abstract class UserRepository {
  Future<User> login();
}