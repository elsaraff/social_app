import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_application/social_cubit/social_cubit.dart';
import 'package:social_application/social_cubit/social_states.dart';
import 'package:social_application/widgets/functions.dart';

var searchController = TextEditingController();

class SearchInput extends StatelessWidget {
  const SearchInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var search = SocialCubit.get(context).search;

        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                          offset: const Offset(12, 26),
                          blurRadius: 50,
                          spreadRadius: 0,
                          color: Colors.grey.withOpacity(.1)),
                    ]),
                    child: TextField(
                      controller: searchController,
                      autofocus: true,
                      onChanged: (value) {
                        SocialCubit.get(context).getSearch(value);
                      },
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.blueGrey,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Search',
                        hintStyle: TextStyle(color: Colors.grey),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ConditionalBuilder(
                      condition: search.isNotEmpty,
                      builder: (context) => ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            if (SocialCubit.get(context).currentIndex == 1) {
                              return buildProfileItem(search[index], context,
                                  isChat: true);
                            } else {
                              return buildProfileItem(search[index], context);
                            }
                          },
                          separatorBuilder: (context, index) => Container(
                                color: Colors.blueGrey,
                                width: double.infinity,
                                height: 0.5,
                              ),
                          itemCount: search.length),
                      fallback: (context) => const Center(
                        child: Column(
                          children: [
                            SizedBox(height: 10),
                            Text(
                              'Enter Text To Search',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
