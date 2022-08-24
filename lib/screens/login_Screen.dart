import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/cubit/app_cubit.dart';
import 'package:shop_app/cubit/app_states.dart';
import 'package:shop_app/network/local/caech_helper.dart';

import 'home_layout.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var formKey = GlobalKey<FormState>();
    var emailController = TextEditingController();
    var passController = TextEditingController();

    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context, state) {
          if(state is LoginSuccessedState)
          {
            if(state.model!.status??false)
            {
              CacheHelper.saveData(key: 'token', value: state.model!.data!.token).then((value)
              {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeLayout(),));
              });

              print(state.model!.message);

            }
            else{
              print(state.model!.message);
              Fluttertoast.showToast(
                  msg: "${state.model!.message}",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 5,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
            }


          }
        },
        builder: (context, state)
        {
          return Scaffold(
            appBar: AppBar(
              title: Text('Login Screen'),
            ),
            body:  Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.blue,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'login now to get our hot offers',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.blue,
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) return ' please enter an email ';
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                            prefixIcon: Icon(Icons.email),
                            label: Text('Email'),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        TextFormField(
                          controller: passController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: AppCubit().get(context).isPassword,
                          validator: (value) {
                            if (value!.isEmpty) return ' please enter an email ';
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.remove_red_eye_outlined),
                              onPressed: () {
                                AppCubit().get(context).changePasswordSecure();
                              },
                            ),
                            label: Text('Password'),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        state is! LoginLoadingState
                            ? MaterialButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              AppCubit().get(context).userLogin(
                                  email: emailController.text,
                                  password: passController.text);
                            }
                          },
                          color: Colors.blue,
                          minWidth: double.infinity,

                          //shape: CircleBorder(),
                          child: Text(
                            'LOGIN',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        )
                            : Center(child: CircularProgressIndicator()),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text('Dont\'t have an account ?'),
                            TextButton(
                              onPressed: () {},
                              child: Text('Register now'),
                            )
                          ],
                        )
                      ],
                    ),
                  ),

            ),
          ) ;
        },


      ),
    );
  }
}
