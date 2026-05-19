import '../models/user_model.dart';
import '../../../../core/error/failures.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> loginWithGoogle();
  Future<UserModel> signUp(String fullName, String email, String password);
  Future<void> forgotPassword(String email);
  Future<void> resendEmail(String email);
  Future<void> logout();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  // Simulating network delay since we are mocking
  @override
  Future<UserModel> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 2));
    if (email == 'test@test.com' && password == 'password') {
      return const UserModel(id: '1', email: 'test@test.com', fullName: 'Test User');
    } else {
      throw const AuthFailure('Invalid email or password');
    }
  }

  @override
  Future<UserModel> loginWithGoogle() async {
    await Future.delayed(const Duration(seconds: 1));
    return const UserModel(id: '2', email: 'google@test.com', fullName: 'Google User');
  }

  @override
  Future<UserModel> signUp(String fullName, String email, String password) async {
    await Future.delayed(const Duration(seconds: 2));
    return UserModel(id: '3', email: email, fullName: fullName);
  }

  @override
  Future<void> forgotPassword(String email) async {
    await Future.delayed(const Duration(seconds: 1));
    // Simulated success
  }

  @override
  Future<void> resendEmail(String email) async {
    await Future.delayed(const Duration(seconds: 1));
    // Simulated success
  }

  @override
  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }
}
