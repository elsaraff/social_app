import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_application/new_post/new_post_screen.dart';
import 'package:social_application/search/search.dart';
import 'package:social_application/shared/icons_broken.dart';
import 'package:social_application/social_cubit/social_cubit.dart';
import 'package:social_application/social_cubit/social_states.dart';
import 'package:social_application/widgets/functions.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
              IconButton(
                  onPressed: () {
                    searchController.clear();
                    socialCubit.search = [];
                    navigateTo(context, const SearchInput());
                  },
                  icon: const Icon(IconBroken.Search)),
            ],
          ),
          body: socialCubit.screens[socialCubit.currentIndex],
          bottomNavigationBar: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            child: BottomNavigationBar(
              selectedFontSize: 10,
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
                    icon: Icon(IconBroken.Paper_Upload, color: Colors.white),
                    label: "post"),
                BottomNavigationBarItem(
                    icon: Icon(IconBroken.User1), label: "Friends"),
                BottomNavigationBarItem(
                    icon: Icon(IconBroken.Setting), label: "Settings")
              ],
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniCenterDocked,
          floatingActionButton: SizedBox(
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
