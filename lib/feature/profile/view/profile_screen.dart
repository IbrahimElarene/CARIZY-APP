import 'package:cartzy_app/feature/profile/controller/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/common/widget/custom_form_text_fiel.dart';
import '../../../core/utils/validator_functions.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  var nameController = TextEditingController(text: "Ibrahim");
  final emailController = TextEditingController(text: "ibrahim@gmail.com");
  final passwordController = TextEditingController(text: "ibrahim200");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is GetProfileLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is GetProfileSuccess) {
              var cubit=context.read<ProfileCubit>();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30),
                  Text(
                    "Name",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 5),
                  CustomTextFormField(
                    controller: TextEditingController(text: cubit.user.name),
                    validator: Validator.validateName,
                    hintText: "Enter your name",
                    keyboardType: TextInputType.emailAddress,
                    action: TextInputAction.next,
                  ),
                  SizedBox(height: 30),

                  Text(
                    "Email",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 5),
                  CustomTextFormField(
                    enable: false,
                    controller:
                        TextEditingController(text: cubit.user.email),
                    validator: Validator.validateEmail,
                    hintText: "Enter your email",
                    keyboardType: TextInputType.emailAddress,
                    action: TextInputAction.next,
                  ),
                  SizedBox(height: 30),
                  Text(
                    "Password",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 5),
                  CustomTextFormField(
                    controller: TextEditingController(text: cubit.user.password),
                    validator: Validator.validatePassword,
                    hintText: "Enter your password",
                    isPassword: true,
                    keyboardType: TextInputType.emailAddress,
                    action: TextInputAction.next,
                  ),
                  SizedBox(height: 30),
                  MaterialButton(
                    minWidth: double.infinity,
                    height: 50,
                    onPressed: () async {
                      // if (formKey.currentState!.validate()) {
                      //   }
                    },
                    color: Color(0xff212121),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      "Update",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xffFFFFFF),
                      ),
                    ),
                  ),
                ],
              );
            }
            return Center(
                child: Text(
              'Error',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ));
          },
        ),
      ),
    );
  }
}
