import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'phone_auth_state.dart';

class PhoneAuthCubit extends Cubit<PhoneAuthState> {
  final FirebaseAuth _firebaseAuth;

  PhoneAuthCubit(this._firebaseAuth) : super(PhoneAuthInitial());

  void sendOTP(String phoneNumber) async {
    emit(PhoneAuthLoading());
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _firebaseAuth.signInWithCredential(credential);
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
      await _firebaseAuth.signInWithCredential(credential);
      emit(PhoneAuthVerified());
    } catch (e) {
      emit(PhoneAuthError(e.toString()));
    }
  }
}
