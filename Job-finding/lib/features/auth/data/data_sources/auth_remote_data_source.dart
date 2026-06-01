import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../models/user_model.dart';
import '../../../../core/error/failures.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> loginWithGoogle();
  Future<UserModel> signUp(String fullName, String email, String password);
  Future<void> logout();
  Future<UserModel?> getCurrentUser();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;

  AuthRemoteDataSourceImpl({
    required this.firebaseAuth,
    required this.googleSignIn,
  });

  @override
  Future<UserModel> login(String email, String password) async {
    try {
      final credential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user == null) {
        throw const AuthFailure('Login failed: User is null');
      }
      return UserModel(
        id: credential.user!.uid,
        email: credential.user!.email ?? '',
        fullName: credential.user!.displayName ?? '',
        profilePhoto: credential.user!.photoURL,
      );
    } on FirebaseAuthException catch (e) {
      throw AuthFailure(e.message ?? 'Authentication error');
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<UserModel> loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        throw const AuthFailure('Google Sign-In cancelled');
      }
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await firebaseAuth.signInWithCredential(credential);
      if (userCredential.user == null) {
        throw const AuthFailure('Google Sign-In failed');
      }

      return UserModel(
        id: userCredential.user!.uid,
        email: userCredential.user!.email ?? '',
        fullName: userCredential.user!.displayName ?? '',
        profilePhoto: userCredential.user!.photoURL,
      );
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<UserModel> signUp(String fullName, String email, String password) async {
    try {
      final credential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user == null) {
        throw const AuthFailure('Registration failed');
      }
      
      await credential.user!.updateDisplayName(fullName);
      
      return UserModel(
        id: credential.user!.uid,
        email: credential.user!.email ?? '',
        fullName: fullName,
        profilePhoto: credential.user!.photoURL,
      );
    } on FirebaseAuthException catch (e) {
      throw AuthFailure(e.message ?? 'Registration error');
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<void> logout() async {
    await googleSignIn.signOut();
    await firebaseAuth.signOut();
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    final user = firebaseAuth.currentUser;
    if (user == null) return null;
    return UserModel(
      id: user.uid,
      email: user.email ?? '',
      fullName: user.displayName ?? '',
      profilePhoto: user.photoURL,
    );
  }
}
