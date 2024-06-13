import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'phone_auth_state.dart';

class PhoneAuthCubit extends Cubit<PhoneAuthState> {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  PhoneAuthCubit(this.firebaseAuth, this.firestore) : super(PhoneAuthInitial());

  Future<bool> checkTouristExists(String phoneNumber) async {
    final querySnapshot = await firestore
        .collection('tourist')
        .where('phoneNumber', isEqualTo: phoneNumber)
        .get();

    return querySnapshot.docs.isNotEmpty;
  }

  void sendOTP(String phoneNumber) async {
    emit(PhoneAuthLoading());

    // Check if the tourist exists in Firestore
    bool exists = await checkTouristExists(phoneNumber);
    if (!exists) {
      emit(PhoneAuthError('Phone number is not registered as a tourist.'));
      return;
    }

    await firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await firebaseAuth.signInWithCredential(credential);
        emit(PhoneAuthVerified());
      },
      verificationFailed: (FirebaseAuthException e) {
        emit(PhoneAuthError(e.message));
      },
      codeSent: (String verificationId, int? resendToken) {
        emit(PhoneAuthCodeSent(verificationId));
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  void verifyOTP(String verificationId, String smsCode) async {
    emit(PhoneAuthLoading());
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      await firebaseAuth.signInWithCredential(credential);
      emit(PhoneAuthVerified());
    } catch (e) {
      emit(PhoneAuthError(e.toString()));
    }
  }
}
