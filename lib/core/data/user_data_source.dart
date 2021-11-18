import 'package:lab_coffee/core/domain/entities/user.dart';

abstract class UserDataSource {

  Future<User> login() ;

}