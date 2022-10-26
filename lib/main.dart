import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:color_calendar/widgets/calendar.dart';
import 'package:color_calendar/widgets/colors.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseUIAuth.configureProviders([
    EmailAuthProvider(),
  ]);
  runApp(ChangeNotifierProvider(
      create: (context) => ApplicationState(),
      builder: ((context, child) => const App())));
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/sign-in',
      routes: {
        '/home': (context) {
          return const HomePage();
        },
        '/sign-in': ((context) {
          return SignInScreen(
            actions: [
              ForgotPasswordAction(((context, email) {
                Navigator.of(context)
                    .pushNamed('/forgot-password', arguments: {'email': email});
              })),
              AuthStateChangeAction(((context, state) {
                if (state is SignedIn || state is UserCreated) {
                  var user = (state is SignedIn)
                      ? state.user
                      : (state as UserCreated).credential.user;
                  if (user == null) {
                    return;
                  }
                  if (state is UserCreated) {
                    user.updateDisplayName(user.email!.split('@')[0]);
                  }
                  if (!user.emailVerified) {
                    user.sendEmailVerification();
                    const snackBar = SnackBar(
                        content: Text(
                            'Please check your email to verify your email address'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                  Navigator.of(context).pushReplacementNamed('/home');
                }
              })),
            ],
          );
        }),
        '/forgot-password': ((context) {
          final arguments = ModalRoute
              .of(context)
              ?.settings
              .arguments
          as Map<String, dynamic>?;

          return ForgotPasswordScreen(
            email: arguments?['email'] as String,
            headerMaxExtent: 200,
          );
        }),
        '/profile': ((context) {//Not used right now
          return ProfileScreen(
            providers: [],
            actions: [
              SignedOutAction(
                ((context) {
                  Navigator.of(context).pushReplacementNamed('/home');
                }),
              ),
            ],
          );
        })
      },
      title: 'Color your calendar',
      theme: ThemeData(
        buttonTheme: Theme
            .of(context)
            .buttonTheme
            .copyWith(
          highlightColor: Colors.deepPurple,
        ),
        primarySwatch: Colors.deepPurple,
        textTheme: GoogleFonts.robotoTextTheme(
          Theme
              .of(context)
              .textTheme,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int edit = 0;

  List<Color> currentColors = [
    Colors.yellow,
    Colors.green,
    Colors.black,
    Colors.blueGrey,
    Colors.red
  ];

  void changeEdit(int i) =>
      setState(() {
        edit = i;
      });

  void changeColors(Color colors) =>
      setState(() => currentColors[edit] = colors);
  List<String> currentText = ["Super", "Good", "Funny", "Bad", "Really bad"];

  Map<DateTime, int> moods = {};

  void changeMoods(Map<DateTime, int> x) => setState(() => moods.addAll(x));

  Future<Map<DateTime, int>?> mood = Firestore.getMoods();

  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationState>(
        builder: (context, appState, child) =>
            FutureBuilder(
                future: mood,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return Column(
                      children: const [
                        SizedBox(
                          width: 60,
                          height: 60,
                          child: CircularProgressIndicator(),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 16),
                          child: Text('Awaiting result...'),
                        ),
                      ],
                    );
                  }else{
                    return Scaffold(
                        appBar: AppBar(
                          title: const Text('Color your calendar'), //todo: edit
                        ),
                        body: Column(
                            children: [
                              Container(
                                  margin: const EdgeInsets.only(bottom: 5),
                                  child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Calendar(
                                        pickerColor: currentColors,
                                        texts: currentText,
                                        moods: snapshot.data,
                                      ))),
                              ColorPicker(
                                pickerColor: currentColors,
                                onColorChanged: changeColors,
                                onEditChanged: changeEdit,
                                texts: currentText,
                              ),
                            ],
                        )
                    );}
                  }
                ));
  }
}

class ApplicationState extends ChangeNotifier {
  ApplicationState() {
    init();
  }

  bool _loggedIn = false;

  bool get loggedIn => _loggedIn;

  Future<void> init() async {

    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _loggedIn = true;
      } else {
        _loggedIn = false;
      }
      notifyListeners();
    });
  }
}

class Firestore {
  static Future<Map<DateTime, int>?> getMoods() async {
    DocumentSnapshot snap = await (FirebaseFirestore.instance
        .collection("days")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get());
    if(snap.exists){
      Map<String, dynamic> temp = snap["map"];
      Map<DateTime, int> mood = {};
      temp.forEach((key, value) {mood.putIfAbsent(Timestamp.fromMillisecondsSinceEpoch(int.parse(key)).toDate().toUtc() , () => int.parse(value.toString()));});
      // print(mood); //DEBUG ONLY
      return mood;
    }
  }
//todo: save
}
