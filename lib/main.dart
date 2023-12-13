import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hike_navigator/cubit/auth_cubit.dart';
import 'package:hike_navigator/cubit/destinations_cubit.dart';
import 'package:hike_navigator/cubit/destinations_saved_cubit.dart';
import 'package:hike_navigator/cubit/mountains_cubit.dart';
import 'package:hike_navigator/cubit/page_cubit.dart';
import 'package:hike_navigator/firebase_options.dart';
import 'package:hike_navigator/services/firebase_service.dart';
import 'package:hike_navigator/ui/pages/main_splash_page.dart';
import 'package:hike_navigator/ui/pages/second_splash_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<SharedPreferences> _preferences;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _preferences = SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PageCubit(),
        ),
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
        BlocProvider(
          create: (context) => MountainsCubit(),
        ),
        BlocProvider(
          create: (context) => DestinationsCubit(),
        ),
        BlocProvider(
          create: (context) => DestinationsSavedCubit(),
        ),
        Provider<FirebaseService>(
          create: (_) => FirebaseService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<FirebaseService>().authState,
          initialData: null,
        ),
      ],
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          print(state);
          if (state is AuthLoading && state.loading) {
            return Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return BuildApp(
              preferences: _preferences,
            );
          }
        },
      ),
    );
  }
}

class BuildApp extends StatelessWidget {
  final Future<SharedPreferences> preferences;
  const BuildApp({
    Key? key,
    required this.preferences,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: preferences,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Text('Some error has occured');
          } else if (snapshot.hasData) {
            final token = snapshot.data!.getString('token');
            if (token != null || firebaseUser != null) {
              return SecondSplashPage(
                preferences: snapshot.data,
              );
            } else {
              return const MainSplashPage();
            }
          } else {
            return const MainSplashPage();
          }
        },
      ),
    );
  }
}
