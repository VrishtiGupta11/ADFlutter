import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  void authenticateUser(BuildContext context) async{
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: iDController.text.trim(),
          password: passwordController.text.trim(),
      );

      print("User ID is: "+ userCredential.user!.uid.toString());

      if(userCredential.user!.uid.toString().isNotEmpty){
        // login Success
        Navigator.pushReplacementNamed(context, '/home');
      } else{
          setState(() {
            showLoader = false;
          });
      }

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        snackBarPage();
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        snackBarPage();
      }
    }
  }

  snackBarPage(){
    final snackBar = SnackBar(
      content: Text('Incorrect Username or Password'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }


  TextEditingController iDController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  var obscure = true;
  var showLoader = false;

  toggle(){
    setState(() {
      obscure = !obscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.green,
                        Colors.greenAccent,
                      ],
                      tileMode: TileMode.clamp,
                    )
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height/2,
                color: Colors.white,
              ),
            ],
          ),
          Align(
            alignment: Alignment.center,
            child: Card(
              margin: EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height/2,
                  margin: EdgeInsets.all(16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset("assets/news.png", fit: BoxFit.fill,),
                        SizedBox(height: 4,),
                        Text("Enter Details to proceed.", style: TextStyle(fontSize: 16, color: Colors.green, fontWeight: FontWeight.w500),),
                        SizedBox(height: 12,),
                        TextFormField(
                          controller: iDController,
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.grey[900],
                          ),
                          keyboardType: TextInputType.emailAddress,
                          autofocus: false,
                          enabled: true,
                          validator: (value) {
                            if(value!.isEmpty){
                              return 'Login ID is required';
                            }else if(value.trim().length == 0){
                              return 'Login ID is required';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            filled: true,
                            // fillColor: Colors.transparent,
                            labelText: 'Login ID',
                            alignLabelWithHint: true,
                            labelStyle: TextStyle(color: Colors.green),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,
                                style: BorderStyle.solid,
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,
                                style: BorderStyle.solid,
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,
                                style: BorderStyle.solid,
                                color: Colors.red,
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,
                                style: BorderStyle.solid,
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,
                                style: BorderStyle.solid,
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            contentPadding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                          ),
                        ),
                        SizedBox(height: 10,),
                        TextFormField(
                          controller: passwordController,
                          obscureText: obscure,
                          style: TextStyle(
                              fontSize: 17.0, color: Colors.grey.shade900),
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.words,
                          autofocus: false,
                          enabled: true,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Password is required. Please Enter.';
                            } else if (value.trim().length < 6) {
                              return 'Password must be 6 characters.';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            filled: true,
                            alignLabelWithHint: true,
                            labelText: "Password",
                            labelStyle: TextStyle(color: Colors.green),
                            // fillColor: Colors.transparent,
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4.0),
                                borderSide: BorderSide(
                                    width: 1,
                                    style: BorderStyle.solid,
                                    color: Colors.grey)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4.0),
                                borderSide: BorderSide(
                                    width: 1,
                                    style: BorderStyle.solid,
                                    color: Colors.black)),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4.0),
                                borderSide: BorderSide(
                                    width: 1,
                                    style: BorderStyle.solid,
                                    color: Colors.red)),
                            disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4.0),
                                borderSide: BorderSide(
                                    width: 1,
                                    style: BorderStyle.solid,
                                    color: Colors.grey)),
                            border: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(4.0),
                                borderSide: BorderSide(
                                    width: 1,
                                    style: BorderStyle.solid,
                                    color: Colors.grey)),
                            contentPadding: EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
                            suffixIcon: IconButton(
                              color: Colors.green,
                              icon: Icon(obscure? Icons.visibility_off: Icons.visibility),
                              onPressed: (){
                                toggle();
                              },
                            ),
                        ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.only(top: 10, bottom: 4),
                          child: TextButton(
                            child: Text("Login", style: TextStyle(fontSize: 16, color: Colors.white),),
                            onPressed: (){
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  showLoader = true;
                                  authenticateUser(context);
                                });
                              }
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.green,
                              elevation: 10
                            ),
                          ),
                        ),
                        SizedBox(height: 4),
                        InkWell(
                          onTap: (){
                            Navigator.pushNamed(context, "/register");
                          },
                          child: Text(
                            'New User? Register Here',
                            style: TextStyle(
                              fontSize: 18.0, color: Colors.green, fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }


}
