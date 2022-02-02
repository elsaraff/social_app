import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_application/core/bloc_observer.dart';
import 'package:social_application/core/cache_helper.dart';
import 'package:social_application/home_screen.dart';
import 'package:social_application/login/login_screen.dart';
import 'package:social_application/social_cubit/social_cubit.dart';
import 'package:social_application/widgets/functions.dart';
import 'package:social_application/widgets/show_toast.dart';

Future<void> firebaseMessagingBackGroundHandler(RemoteMessage message) async {
  debugPrint('onBackgroundMessage ' + message.data.toString());
  showToast(text: 'onBackgroundMessage', state: ToastStates.success);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  var token = await FirebaseMessaging.instance.getToken();
  debugPrint('FirebaseMessaging Token ' + token.toString());

  FirebaseMessaging.onMessage.listen((event) {
    debugPrint('onMessage event.data ' + event.data.toString());
    showToast(text: 'onMessage', state: ToastStates.success);
  });

  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    debugPrint('onMessageOpenedApp  event.data ' + event.data.toString());
    showToast(text: 'onMessageOpenedApp', state: ToastStates.success);
  });

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackGroundHandler);

  Bloc.observer = MyBlocObserver();

  await CacheHelper.init();

  uId = CacheHelper.getData(key: 'uId');
  firstTime = CacheHelper.getData(key: 'firstTime');

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
