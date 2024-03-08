import 'package:flutter/material.dart';
import 'firebase/authentication.dart';



class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xFF095659),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50.0),
              bottomRight: Radius.circular(50.0),
            ),
          ),
          toolbarHeight: 100,
          flexibleSpace: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  height: 85,
                  width: 110,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/logo.png'), fit: BoxFit.cover),
                  ),
                ),
              )
            ],
          ),
        ),
        body: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  const SizedBox(
                    height: 50,
                  ),
                  const Text('Wordology',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SignupForm(),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: <Widget>[
                      const SizedBox(width: 30),
                      const Text('Already signed up?',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Go to Login page',
                            style: TextStyle(fontSize: 20, color: Colors.blue)),
                      )


                    ],
                  )
                ]
            )
        )
    );

  }
}

class SignupForm extends StatefulWidget {
  SignupForm({Key? key}) : super(key: key);

  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();

  String? email;
  String? password;

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
                prefixIcon: Icon(Icons.email_outlined),
                labelText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(100.0),
                  ),
                )
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            onSaved: (val) {
              email = val;
            },
          ),

          const SizedBox(
            height: 20,
          ),

          TextFormField(
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.lock_outline),
              labelText: 'Password',
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(100.0),
                ),
              ),
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                child: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                ),
              ),
            ),
            obscureText: _obscureText,

            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            onSaved: (val) {
              password = val;
            },

          ),

          const SizedBox(height: 30),

          SizedBox(
              height: 54,
              width: 184,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    AuthenticationHelper()
                        .signUp(email: email!, password: password!)
                        .then((result) {
                      if (result == null) {
                        print("signed up successfully.");
                        // email = '';
                        // password = '';
                        // Navigator.pushReplacement(context,
                        //     MaterialPageRoute(builder: (context) => RoutePage()));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                              result,
                              style: const TextStyle(fontSize: 16),
                            )
                        ));
                      }

                    });

                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF095659),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(24.0))
                    )
                ),
                child: const Text(
                  'Sign up',
                  style:  TextStyle(fontSize: 24, color: Colors.white),
                ),

              )
          )






        ],
      ),
    );
  }

}







// import 'package:flutter/material.dart';
// import 'firebase/authentication.dart';
//
//
//
// class Signup extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         automaticallyImplyLeading: false,
//         backgroundColor: const Color(0xFF095659),
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//             bottomLeft: Radius.circular(50.0),
//             bottomRight: Radius.circular(50.0),
//           ),
//         ),
//         toolbarHeight: 100,
//         flexibleSpace: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Center(
//               child: Container(
//                 height: 85,
//                 width: 110,
//                 decoration: const BoxDecoration(
//                   image: DecorationImage(
//                       image: AssetImage('assets/logo.png'), fit: BoxFit.cover),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: <Widget>[
//             const SizedBox(
//               height: 50,
//             ),
//             const Text('Wordology',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
//             // Padding(
//             //   padding: const EdgeInsets.all(16.0),
//             //   child: SignupForm(),
//             // ),
//
//
//           ],
//         )
//       )
//     );
//
//   }
// }
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
