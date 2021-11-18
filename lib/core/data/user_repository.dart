import 'package:lab_coffee/core/data/user_data_source.dart';
import 'package:lab_coffee/core/domain/entities/user.dart';

class UserRepository {

  final UserDataSource _userDataSource ;

  const UserRepository({
    userDataSource
  }): _userDataSource = userDataSource ;

  Future<User> login() {
    return _userDataSource.login() ;
  }
}