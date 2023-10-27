import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_php/components/crud.dart';
import 'package:flutter_php/components/valid.dart';
import 'package:flutter_php/constant/linkapi.dart';
import 'package:flutter_php/main.dart';

import '../../components/customtextform.dart';


class Login extends StatefulWidget {

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isLoading =false;
  Crud crud = Crud();
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController Email = TextEditingController();
  TextEditingController Password = TextEditingController();

  login() async{

    if(formstate.currentState!.validate()){
      isLoading=true;
      setState(() {

      });
      var response = await crud.postRequest(
          linkLogin,
          {
            "email":Email.text, 
            "password":Password.text
            });
      isLoading=false;
      setState(() {

      });
    if(response?['status'] == "success" ){
      sharedPref.setString("id", response['data']['id'].toString());
      sharedPref.setString("username", response['data']['username']);
      sharedPref.setString("email", response['data']['email']);
      sharedPref.setString("password", response['data']['password']);
      Navigator.of(context).pushNamedAndRemoveUntil("Home", (route) => false);
    }else
      {
        // ignore: use_build_context_synchronously
        AwesomeDialog(
            context: context,
            title: "تنبيه",
            body: const Text(" البريد الالكترونى او كلمة المرور خطأ او الحساب غير موجود"),
        ).show();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        child: isLoading==true ? Center(child: CircularProgressIndicator(),) :
        ListView(
          children: [
            Form(
              key: formstate,
                child: Column(
                  children: [
                    Image.asset('images/notes.jpg',width: 200,height: 200,),
                    CustomTextFormSign(
                      valid: (value) {
                        return ValidInput(value!, 10, 20);
                      },
                      mycontroller: Email,
                      hint: 'Email',
                    ),
                    CustomTextFormSign(
                        valid: (value) {
                          return ValidInput(value!, 6, 16);
                        },
                        mycontroller: Password,
                        hint: 'Password'
                    ),
                    MaterialButton(
                        color: Colors.blue,
                        textColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                            horizontal: 70,
                            vertical: 10
                        ),
                        onPressed: ()async{
                          await login();
                        },
                      child: Text('Login'),
                    ),
                    Container(
                      height: 10,
                    ),
                    InkWell(
                        child: Text("Sign Up"),
                    onTap: () {
                      Navigator.of(context).pushNamed('Signup');
                    },),
                  ],
                ),
            ),
          ],
        ),
      ),
    );
  }
}
