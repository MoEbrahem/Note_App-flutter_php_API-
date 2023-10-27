import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_php/components/crud.dart';
import 'package:flutter_php/components/valid.dart';

import '../../components/customtextform.dart';
import '../../constant/linkapi.dart';


class SignUp extends StatefulWidget {

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  GlobalKey<FormState> formstate = GlobalKey();
  bool isLoading = false ;
  Crud _crud =Crud();
  TextEditingController username = TextEditingController();
  TextEditingController Email = TextEditingController();
  TextEditingController Password = TextEditingController();

  signUpResponse() async {
    if(formstate.currentState!.validate()){
    isLoading=true ;
    setState(() {});
    var response = await _crud.postRequest(
      linkSignUp, 
    {
      "email" : Email.text,
      "username":username.text,
      "password":Password.text
    }
    );
    isLoading=false ;
    setState(() {
    });
    if(response?['status'] == "success"){
      Navigator.of(context).pushNamedAndRemoveUntil("Success",(route) => false);
    }else
      {
        Navigator.of(context).pushNamedAndRemoveUntil("Fails", (route) => false);
        print("Sign Up Fails");
      }
  }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading==true ? Center(child: CircularProgressIndicator(),)
          : Container(
              padding: EdgeInsets.all(10),
              child: ListView(
                children: [
                Form(
                  key: formstate,
                  child: Column(
                    children: [
                      Image.asset('images/mine.jpg',width: 200,height: 200,),

                      CustomTextFormSign(
                        mycontroller: username,
                        hint: 'Username',
                        valid: (value){
                          return ValidInput(value!, 3, 20);
                        },
                      ),
                      CustomTextFormSign(
                        mycontroller: Email,
                        hint: 'Email',
                        valid: (value){
                          return ValidInput(value!, 5, 40);
                        },
                      ),
                      CustomTextFormSign(
                          mycontroller: Password,
                          hint: 'Password',
                          valid: (value){
                             return ValidInput(value!, 8, 15);
                },

                      ),
                      MaterialButton(
                        color: Colors.blue,
                        textColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 70,
                            vertical: 10
                        ),
                        onPressed: () async{

                             await signUpResponse();
                        },
                        child: Text('SignUp'),
                      ),
                      Container(height: 10,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already have account ? "),
                          SizedBox(width: 20,),

                          InkWell(
                          child:const Text("Login"),
                          onTap: (){
                            Navigator.of(context).pushReplacementNamed('login');
                          },
                        ),

                      ],)

                    ],
                  ),
            ),
          ],
        ),
      ),

    );
  }
}
