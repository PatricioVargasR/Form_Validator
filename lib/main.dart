import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark(),
      home:const HomePage() ,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // Llave global
  // final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _formKey = GlobalKey<FormState>();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  void _submit(){
    final isValid = _formKey.currentState!.validate();
    if(!isValid){
      return;
    }
    _formKey.currentState!.save();
  }

  saveData() async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString("email", emailController.text.trim());
  }
  readData() async{
    final SharedPreferences prefs = await _prefs;
    final String? email = prefs.getString("email");
    print(email);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Page",
              style: TextStyle(color: Colors.yellowAccent)),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: Form(
        key: _formKey,
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 50,
          ),
          const Center(child: Text("Login Page", style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.redAccent),
          )),
         const SizedBox(
            height: 50,
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                // Método para validar formulario
                onFieldSubmitted: (value){
                  print(value);
                },
                validator: (value){
                  if(value!.isEmpty||
                      !RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value)){
                    return "Please enter your email";
                  }
                  return null;
                },
                controller: emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  hintText: "Enter a correct email",
                  labelText: "Email"),
              ),
          ),
          const SizedBox(
            height: 50,
          ),
            Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              onFieldSubmitted: (value){
                print(value);
              },
              validator: (value){
                if(value!.isEmpty || value.length<8){
                  return "Please enter a correct password";
                }
                return null;
              },
              obscureText: true,
              controller: passwordController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  hintText: "Enter your password",
                  labelText: "Password"),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50.0, right: 50.0),
          child: ElevatedButton(
              onPressed: () {
                _submit();
                final isValid = _formKey.currentState!.validate()??false;
                if(isValid){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LandingPage(
                              userEmail: emailController.text.trim(),
                            )),
                  ).then((res){
                    emailController.clear();
                    passwordController.clear();
                  }); // Proceso futuro que pasará después de la ejecución de otro
                }
              },
              child: const Text(
                "Login",
                style: TextStyle(fontSize: 20),
              )),
          )
        ],
        )
      ));
  }
}
