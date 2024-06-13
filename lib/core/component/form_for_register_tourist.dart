import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guru/core/component/custom_text_form_field.dart';
import 'package:guru/core/component/form_for_log_in_tourist.dart';
import 'package:guru/core/component/show_list_payment_dialog.dart';
import 'package:guru/core/utils/colors_app.dart';
import 'package:guru/core/utils/custom_text_button.dart';
import 'package:guru/core/utils/styles.dart';
import 'package:guru/logic/tourist/add_tourist_cubit.dart';
import 'package:guru/logic/tourist/add_tourist_state.dart';
import 'package:lottie/lottie.dart';

class FormForRegisterTourist extends StatelessWidget {
  final String tourGuideName;
  const FormForRegisterTourist({super.key,required this.tourGuideName});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Register As Tourist"),
          centerTitle: true,
        ),
        body: BlocListener<AddTouristCubit, TouristState>(
          listener: (context, state) {
            if (state is TouristLoading) {
              // Show loading indicator
              showDialog(
                context: context,
                builder: (context) => const Center(child: CircularProgressIndicator()),
              );
            } else if (state is TouristSuccess) {
              // Hide loading indicator and show success message
              Navigator.pop(context); // To dismiss the loading dialog
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Tourist added successfully!')),
              );
            } else if (state is TouristFailure) {
              // Hide loading indicator and show error message
              Navigator.pop(context); // To dismiss the loading dialog
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error: ${state.error}')),
              );
            }
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Lottie.asset("images/reg.json", height: 250),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 1, 61, 58),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(tourGuideName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: Form(
                    key: context.read<AddTouristCubit>().formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        CustomTextFormField(
                          controller: context.read<AddTouristCubit>().touristNameController,
                          hintText: "Enter Your Name",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            if (value.length < 3) {
                              return 'Name must be at least 3 characters long';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                       /* CustomTextFormField(
                          controller: context
                              .read<AddTouristCubit>()
                              .emailController,
                          hintText: "Enter Your Email",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                .hasMatch(value)) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                        ),*/
                        CustomTextFormField(
                          controller: context.read<AddTouristCubit>().touristPhoneNumberController,
                          hintText: "Enter Your Phone Number",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your phone number';
                            }
                           /* if (value.length != 10) {
                              // Adjust length as per your requirement
                              return 'Phone number must be exactly 10 digits';
                            }*/
                          /*  if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                              return 'Phone number must contain only digits';
                            }*/
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.all(3),
                          child: AppTextButton(
                            buttonText: 'Create',
                            textStyle: Styles.font14LightGreyRegular(context),
                            backgroundColor: ColorsApp.darkPrimary,
                            onPressed: () {
                              if (context.read<AddTouristCubit>().formKey.currentState!.validate()) {
                                context.read<AddTouristCubit>().addTourist();
                              }
                            },
                          ),
                        ),
                      InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return FormForLogInTourist(
                                  );
                                },
                              ),
                            );
                          },

                          child: const  Text("Log In"))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
