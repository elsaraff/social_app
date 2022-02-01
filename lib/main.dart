import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_application/core/bloc_observer.dart';
import 'package:social_application/core/cache_helper.dart';
import 'package:social_application/home_screen.dart';
import 'package:social_application/login/login_screen.dart';
import 'package:social_application/social_cubit/social_cubit.dart';
import 'package:social_application/widgets/functions.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  Bloc.observer = MyBlocObserver();

  await CacheHelper.init();

  uId = CacheHelper.getData(key: 'uId');

  Widget startWidget;

  if (uId != null) {
    startWidget = const HomeScreen();
  } else {
    //token = null
    startWidget = const LoginScreen();
  }

  runApp(MyApp(
    startWidget: startWidget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  const MyApp({Key key, this.startWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SocialCubit()
            ..getUserData()
            ..getPosts(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: 'saraff',
          primarySwatch: Colors.blueGrey,
        ),
        debugShowCheckedModeBanner: false,
        home: startWidget,
      ),
    );
  }
}
