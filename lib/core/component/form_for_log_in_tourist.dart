import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:guru/logic/phone_authentication/phone_auth_cubit.dart';


class FormForLogInTourist extends StatelessWidget {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PhoneAuthCubit(FirebaseAuth.instance),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Phone Authentication'),
        ),
        body: BlocConsumer<PhoneAuthCubit, PhoneAuthState>(
          listener: (context, state) {
            if (state is PhoneAuthVerified) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Phone number verified')),
              );
            } else if (state is PhoneAuthError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message!)),
              );
            }
          },
          builder: (context, state) {
            if (state is PhoneAuthLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is PhoneAuthInitial || state is PhoneAuthError) {
              return _buildPhoneInput(context);
            } else if (state is PhoneAuthCodeSent) {
              return _buildCodeInput(context, state.verificationId);
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  Widget _buildPhoneInput(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _phoneController,
            decoration: InputDecoration(labelText: 'Phone number'),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              final phone = _phoneController.text.trim();
              context.read<PhoneAuthCubit>().sendOTP(phone);
            },
            child: Text('Send OTP'),
          ),
        ],
      ),
    );
  }

  Widget _buildCodeInput(BuildContext context, String verificationId) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _codeController,
            decoration: InputDecoration(labelText: 'SMS Code'),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              final code = _codeController.text.trim();
              context.read<PhoneAuthCubit>().verifyOTP(verificationId, code);
            },
            child: Text('Verify OTP'),
          ),
        ],
      ),
    );
  }
}
