import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'layout/admin/admin_layout_screen_moudule.dart';
import 'layout/user/user_layout_screen.dart';
import 'models/language_constants.dart';
import 'modules/login/login_screen.dart';
import 'shared/bloc_observer.dart';
import 'shared/component/constants.dart';
import 'shared/styles/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


Future<void> main() async {
  Bloc.observer = SimpleBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final fb = FirebaseAuth.instance.currentUser;
  if (fb != null) {
    final bool? isAdmin = (await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get())["role"];

    runApp(MyApp(
      isAdmin: isAdmin ?? false,
    ));
  } else {
    runApp(const MyApp());
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key, this.isAdmin = true}) : super(key: key);
  final bool? isAdmin;

  @override
  State<MyApp> createState() => _MyAppState();
  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) => {setLocale(locale)});
    super.didChangeDependencies();
  }
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final fb = FirebaseAuth.instance.currentUser;
    bool auth = false;
    late Widget goWidget;
    if (fb != null) {
      goWidget = widget.isAdmin! ? const AdminLayoutScreenMoudule() : const UserLayoutScreen ();
      auth = true;
    }
    return MaterialApp(
      title: kDAppName,
      theme: ThemeData(
        primarySwatch: myColorSwatch,
        fontFamily: 'Almarai',
        textTheme: ThemeData.light().textTheme.copyWith(
              titleLarge: const TextStyle(
                fontSize: 20,
                fontFamily: 'Almarai',
                fontWeight: FontWeight.normal,
              ),
              headlineSmall: const TextStyle(
                fontSize: 26,
                fontFamily: 'Almarai',
                fontWeight: FontWeight.bold,
                color: kDprimaryColor,
              ),
            ),
      ),
      debugShowCheckedModeBanner: false,
      // localizationsDelegates: const [
      //   GlobalCupertinoLocalizations.delegate,
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      // ],
      // supportedLocales: const [
      //   Locale("ar", "EG"),
      //   Locale('en'),
      // ],
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale("ar", "EG"),
      // locale: _locale,
      home: auth ? goWidget : const LoginScreen(),
      
    );
  }
}
