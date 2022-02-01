import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_application/new_post/new_post_screen.dart';
import 'package:social_application/shared/icons_broken.dart';
import 'package:social_application/social_cubit/social_cubit.dart';
import 'package:social_application/social_cubit/social_states.dart';
import 'package:social_application/widgets/functions.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is SocialGetUserSuccessState) {
          SocialCubit.get(context).getAllUsers();
        }
      },
      builder: (context, state) {
        var socialCubit = SocialCubit.get(context);
        return Scaffold(
          extendBody: true,
          appBar: AppBar(
            title: Text(
              socialCubit.titles[socialCubit.currentIndex],
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            actions: [
              IconButton(
                  onPressed: () {}, icon: const Icon(IconBroken.Notification)),
              IconButton(onPressed: () {}, icon: const Icon(IconBroken.Search)),
            ],
          ),
          body: socialCubit.screens[socialCubit.currentIndex],
          bottomNavigationBar: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            notchMargin: 3.0,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: socialCubit.currentIndex,
              selectedItemColor: Colors.blueGrey,
              unselectedItemColor: Colors.grey,
              onTap: (index) {
                socialCubit.changeBottomNav(index);
              },
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(IconBroken.Home), label: "Feeds"),
                BottomNavigationBarItem(
                    icon: Icon(IconBroken.Chat), label: "Chats"),
                BottomNavigationBarItem(
                    icon: Icon(IconBroken.Paper_Upload,
                        color: Colors.white, size: 0.0001),
                    label: "post"),
                BottomNavigationBarItem(
                    icon: Icon(IconBroken.User), label: "Users"),
                BottomNavigationBarItem(
                    icon: Icon(IconBroken.Setting), label: "Settings")
              ],
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniCenterDocked,
          floatingActionButton: SizedBox(
            height: 70,
            width: 70,
            child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: FloatingActionButton(
                  tooltip: 'Creat Post',
                  child: const Icon(IconBroken.Paper_Upload),
                  onPressed: () {
                    navigateTo(context, const NewPostScreen());
                  },
                )),
          ),
        );
      },
    );
  }
}
