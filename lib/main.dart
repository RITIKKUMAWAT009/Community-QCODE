
import 'package:community/core/bindings/general_binding.dart';
import 'package:community/core/utils/theme/theme.dart';
import 'package:community/data/repositories/authentication/authentication_repository.dart';
import 'package:community/firebase_options.dart';
import 'package:community/modules/onBoarding/views/on_boarding.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


import 'modules/onBoarding/views/splash_view.dart';


Future<void> main() async{
WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  //TODO: init payment methode


  //Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((FirebaseApp value) => Get.put(AuthenticationRepository()));

  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return GetMaterialApp(
      title: 'Community QCODE',
themeMode: ThemeMode.system,
      darkTheme: RAppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      theme: RAppTheme.lightTheme,
initialBinding: GeneralBindings(),
      // home: const SignUpScreen(),
      home:const Scaffold(backgroundColor: Colors.blue,body: Center(child: SizedBox(child: CircularProgressIndicator(color: Colors.white,)),),),
      // home:const LoginScreen(),
    );
  }}


  /*
lib/
├── core/
│   ├── bindings/              # GetX bindings for dependencies
│   ├── constants/             # App-wide constants (e.g., theme, colors)
│   ├── utils/                 # Helper functions, extensions
│   ├── widgets/               # Reusable UI components
│
├── data/
│   ├── models/                # Data models (e.g., User, Post)
│   ├── repositories/          # Abstract classes for data operations
│   ├── services/              # Firebase, APIs, or local storage logic
│
├── modules/
│   ├── auth/                  # Authentication module
│   │   ├── controllers/       # Controllers for login/signup screens
│   │   ├── views/             # UI screens for login/signup
│   │   ├── widgets/           # Reusable auth-specific widgets
│   │   └── bindings/          # Bindings for auth controllers
│   │
│   ├── chat/                  # Chat feature module
│   │   ├── controllers/
│   │   ├── views/
│   │   ├── widgets/
│   │   └── bindings/
│   │
│   ├── feed/                  # Feed module
│   │   ├── controllers/
│   │   ├── views/
│   │   ├── widgets/
│   │   └── bindings/
│   │
│   ├── profile/               # Profile module
│   │   ├── controllers/
│   │   ├── views/
│   │   ├── widgets/
│   │   └── bindings/
│
├── routes/
│   ├── app_pages.dart         # GetX route management
│   └── app_routes.dart        # Defined route names
│
├── main.dart                  # App entry point
└── theme.dart                 # App-wide theme and styles

*/
