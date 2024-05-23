import 'package:barcode/pages/sign_up.dart';
import 'package:barcode/widgets/text_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sign_in_button/sign_in_button.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? user;
  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();

  bool circular = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _auth.authStateChanges().listen((event) {
      setState(() {
        user = event;
      });
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    pwdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: user != null
          ? userInfo()
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Sign In",
                  style: GoogleFonts.poppins(
                    fontSize: 35,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SignInText("Email", emailController, false),
                SizedBox(
                  height: 15,
                ),
                SignInText("Password", pwdController, true),
                SizedBox(
                  height: 15,
                ),
                button("Sign In"),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an Account?",
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => SignupPage()),
                            (route) => false);
                      },
                      child: Text(
                        " Sign up.",
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "-- or --",
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                _googleSignInButton(),
                SizedBox(
                  height: 12,
                ),
                _githubSignInButton(),
                SizedBox(
                  height: 12,
                ),
                _yahooSignInButton(),
              ],
            ),
    );
  }

  Widget button(String label) {
    return InkWell(
      onTap: () async {
        setState(() {
          circular = true;
        });

        try {
          firebase_auth.UserCredential userCredential =
              await firebaseAuth.signInWithEmailAndPassword(
                  //kuahon niya ang unsa may gi input nmo sa first
                  email: emailController.text,
                  password: pwdController.text);
          final sb = SnackBar(content: Text("User Login Successful!"));
          ScaffoldMessenger.of(context).showSnackBar(sb);
          setState(() {
            circular = false;
            user = userCredential.user;
          });

          //INTENT NI SYA IF JAVA ANDROID STUDIO SPEAKING
          //NAVIGATE TO NEXT PAGE DEPENDING SA IMO I SET NGA NEEXT PAGE
          // Navigator.pushAndRemoveUntil(
          //     context,
          //     MaterialPageRoute(builder: (builder) => HomePage()),
          //     (route) => false);
        } catch (e) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('User Not Found!')));
          setState(() {
            circular = false;
          });
        }
      },
      child: Container(
        width: 100,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Color.fromARGB(255, 4, 150, 38),
        ),
        child: Center(
          child: circular
              ? CircularProgressIndicator()
              : Text(
                  label,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
        ),
      ),
    );
  }

  Widget userInfo() {
    if (user == null) {
      return Container();
    }

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text("Welcome!"),
          Text(user!.email ?? ""),
          Text(user!.displayName ?? ""),
          MaterialButton(
            color: Colors.red,
            child: const Text("Sign Out"),
            onPressed: () {
              FirebaseAuth.instance.signOut();
              setState(() {
                user = null;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _googleSignInButton() {
    return Center(
      child: SizedBox(
        height: 50,
        child: SignInButtonBuilder(
          backgroundColor: Colors.red, // Set the background color to green
          onPressed: () {
            handleGoogleSignIn();
          },
          text: 'Sign in with Google',
          icon: FontAwesomeIcons.google,
        ),
      ),
    );
  }

  Widget _githubSignInButton() {
    return Center(
      child: SizedBox(
        height: 50,
        child: SignInButtonBuilder(
          backgroundColor:
              Colors.grey.shade900, // Set the background color to green
          onPressed: () {
            signInWithGithub();
          },
          text: 'Sign in with Github',
          icon: FontAwesomeIcons.github,
        ),
      ),
    );
  }

  Widget _yahooSignInButton() {
    return Center(
      child: SizedBox(
        height: 50,
        child: SignInButtonBuilder(
          backgroundColor:
              Colors.purple.shade900, // Set the background color to green
          onPressed: () {
            signInWithYahoo();
          },
          text: 'Sign in with Yahoo',
          icon: FontAwesomeIcons.yahoo,
        ),
      ),
    );
  }

  void handleGoogleSignIn() async {
    try {
      GoogleAuthProvider _googleAuthProvide = GoogleAuthProvider();
      final result =
          await FirebaseAuth.instance.signInWithPopup(_googleAuthProvide);
      final userCredential = result.user;
      setState(() {
        user = userCredential;
      });
    } catch (error) {
      print(error);
    }
  }

  //GITHUB
  Future<void> signInWithGithub() async {
    try {
      //added the github scope to the GithubAuthProvider
      final provider = GithubAuthProvider();
      provider.addScope('repo');
      final result = await FirebaseAuth.instance.signInWithPopup(provider);
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(result.credential!);
      setState(() {
        user = userCredential.user;
      });
    } catch (e) {
      print(e);
    }
  }

//YAHOO
  Future<void> signInWithYahoo() async {
    try {
      final provider = YahooAuthProvider();
      final result = await FirebaseAuth.instance.signInWithPopup(provider);
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(result.credential!);
      setState(() {
        user = userCredential.user;
      });
    } catch (e) {
      print(e);
    }
  }
}
