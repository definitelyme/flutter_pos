import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_auth/firebase_auth.dart' hide AuthProvider;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

import 'package:flutter_pos/config/export.dart';
import 'package:flutter_pos/core/constants/export.dart';
import 'package:flutter_pos/core/domain/export.dart';
import 'package:flutter_pos/features/account/data/export.dart';
import 'package:flutter_pos/features/account/domain/export.dart';
import 'package:flutter_pos/features/auth/data/export.dart';
import 'package:flutter_pos/utils/utils.dart';

@LazySingleton(as: AuthDataSource)
class AuthRemoteDataSourceImpl implements AuthDataSource {
  final firebase_auth.FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;

  AuthRemoteDataSourceImpl({
    required this.firebaseAuth,
    required this.googleSignIn,
  });

  @override
  Future<Result<UserModel>> signInWithGoogle() async {
    try {
      await googleSignIn.initialize(
        clientId: PlatformWrapper().isIOS ? DefaultFirebaseOptions.ios.iosClientId : null,
        serverClientId: Constants.googleServerClientId,
      );

      final googleSignInAccount = await googleSignIn.attemptLightweightAuthentication();

      final googleSignInAuthentication = googleSignInAccount?.authentication;

      final googleSignInAuthorization = await googleSignInAccount?.authorizationClient.authorizationForScopes(
        Constants.authScopes,
      );

      final credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthorization?.accessToken,
        idToken: googleSignInAuthentication?.idToken,
      );

      final userCredential = await firebaseAuth.signInWithCredential(credential);

      if (userCredential.user == null) {
        return Result.failure(error: 'User data is null after sign-in.');
      }

      return Result.success(data: UserModel.fromFirebaseUser(userCredential.user!));
    } catch (e) {
      return Result.failure(error: e);
    }
  }

  @override
  Future<Result<UserModel>> signInWithTestAccount() async {
    try {
      final userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: testAccountEmail,
        password: testAccountPassword,
      );

      if (userCredential.user == null) {
        return Result.failure(error: 'User data is null after sign-in.');
      }

      return Result.success(data: UserModel.fromFirebaseUser(userCredential.user!, authProvider: AuthProvider.email));
    } catch (e) {
      return Result.failure(error: e);
    }
  }

  @override
  Future<Result<void>> signOut() async {
    try {
      await firebaseAuth.signOut();
      await googleSignIn.signOut();
      return Result.success(data: null);
    } catch (e) {
      return Result.failure(error: e);
    }
  }

  @override
  Future<Result<UserModel?>> getCurrentUser() async {
    try {
      final firebaseUser = firebaseAuth.currentUser;
      return Result.success(data: firebaseUser != null ? UserModel.fromFirebaseUser(firebaseUser) : null);
    } catch (e) {
      return Result.failure(error: e);
    }
  }
}
