import 'package:cartzy_app/core/common/widget/custom_form_text_fiel.dart';
import 'package:cartzy_app/core/utils/validator_functions.dart';
import 'package:cartzy_app/feature/auth/controller/login/login_cubit.dart';
import 'package:cartzy_app/feature/auth/controller/register/register_cubit.dart';
import 'package:cartzy_app/feature/auth/view/register_screen.dart';
import 'package:cartzy_app/feature/home/controller/home_cubit.dart';
import 'package:cartzy_app/feature/home/view/home_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

import '../../../core/dialogs/app_dialogs.dart';
import '../../../core/dialogs/app_toasts.dart';
import '../../app_section/app_section.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String routeName = "LoginScreen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController(text: "ibrahim@gmail.com" );
  final passwordController = TextEditingController(text: "ibrahim200");
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit,LoginState>(
      listener: (context, state) {
        if(state is LoginLoading){
          AppDialogs.showLoadingDialog(context);
        }
        if(state is LoginError){
          Navigator.of(context).pop();
          AppToast.showToast(
              context: context,
              title: "Error",
              description: state.messageError,
              type: ToastificationType.error);
        }
        if(state is LoginSuccess){
          Navigator.of(context).pop();
          // AppToast.showToast(
          //     context: context,
          //     title: "Success",
          //     description: "Success",
          //     type: ToastificationType.success);
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => BlocProvider<HomeCubit>(
                create: (context) => HomeCubit(), child: AppSection()),
          ));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Login",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Color(0xff1F1F1F),
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30),
                Text(
                  "Email",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 5),
                CustomTextFormField(
                  controller: emailController,
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
                  controller: passwordController,
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
                  onPressed: ()async {
                    if (formKey.currentState!.validate()) {
                    await  context.read<LoginCubit>().login(email: emailController.text, password: passwordController.text);
                    }
                  },
                  color: Color(0xff212121),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xffFFFFFF),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButtonAnimator: FloatingActionButtonAnimator.noAnimation,
        floatingActionButton: MediaQuery.of(context).viewInsets.bottom == 0
            ? Align(
                alignment: Alignment.bottomCenter,
                child: Text.rich(
                  TextSpan(
                    text: "Don't have an account? ",
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xff6E6A7C),
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        //Navigator.of(context).pushNamed(LoginScreen.routeName);
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => BlocProvider<RegisterCubit>(
                              create: (context) => RegisterCubit(), child: RegisterScreen()),
                        ));
                      },
                    children: [
                      TextSpan(
                        text: "Sign Up",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xff212121),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : null,
      ),
    );
  }
}
