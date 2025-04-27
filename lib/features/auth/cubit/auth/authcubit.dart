import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/shared/local/cache_helper.dart';
import 'authstates.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  AuthCubit get(context) => BlocProvider.of(context);

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signIn({required String email, required String password}) async {
    emit(AuthLoading());
    String? token1= await FirebaseMessaging.instance.getToken();
    await _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((onValue) {
         print(token1);
          FirebaseFirestore.instance.collection("users").doc(onValue.user!.uid).update({
            "token":token1
          });
          CacheHelper.saveData(key: "login", value: true);
          emit(AuthSuccess());
        })
        .catchError((e) {
          emit(AuthFailure(error: e.toString()));
        });
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    emit(AuthLoading());

    await _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((v) async {
          CacheHelper.saveData(key: "name", value: name);
      String? token1 = await FirebaseMessaging.instance.getToken();

      await FirebaseFirestore.instance
              .collection('users')
              .doc(v.user!.uid)
              .set({
                'uid': v.user!.uid,
                'email': v.user!.email,
                'name': name,
                'token':token1,
                'profilePic': "https://www.tenforums.com/geek/gars/images/2/types/thumb_15951118880user.png"
              });
          emit(AuthSuccess());
        })
        .catchError((onError) {
          if (kDebugMode) {
            print(onError.toString());
          }
          emit(AuthFailure(error: onError.toString()));
        });
  }
}
