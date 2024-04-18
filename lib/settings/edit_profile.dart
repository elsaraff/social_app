import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_application/shared/icons_broken.dart';
import 'package:social_application/social_cubit/social_cubit.dart';
import 'package:social_application/social_cubit/social_states.dart';
import 'package:social_application/widgets/custom_text_form_field.dart';
import 'package:social_application/widgets/functions.dart';

var formKey = GlobalKey<FormState>();
var nameController = TextEditingController();
var bioController = TextEditingController();
var phoneController = TextEditingController();

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var socialCubit = SocialCubit.get(context);
        var userModel = SocialCubit.get(context).userModel!;

        nameController.text = userModel.name;
        bioController.text = userModel.bio;
        phoneController.text = userModel.phone;

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(
                IconBroken.Arrow___Left,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: const Text('Edit Profile'),
            titleSpacing: 5.0,
          ),
          body: ConditionalBuilder(
              condition: true,
              fallback: (context) =>
                  const Center(child: CircularProgressIndicator()),
              builder: (context) => SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 210,
                              child: Stack(
                                alignment: AlignmentDirectional.bottomCenter,
                                children: [
                                  Align(
                                    alignment: AlignmentDirectional.topCenter,
                                    child: Stack(
                                      alignment: AlignmentDirectional.topEnd,
                                      children: [
                                        InkWell(
                                          child: Container(
                                              height: 180,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                          topRight:
                                                              Radius.circular(
                                                                  4),
                                                          topLeft:
                                                              Radius.circular(
                                                                  4)),
                                                  image: DecorationImage(
                                                    image: (coverImage == null
                                                            ? NetworkImage(
                                                                userModel.cover)
                                                            : FileImage(
                                                                coverImage!))
                                                        as ImageProvider,
                                                    fit: BoxFit.cover,
                                                  ))),
                                          onTap: () {
                                            socialCubit.getCoverImage();
                                          },
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            width: 35,
                                            height: 35,
                                            color: Colors.white.withOpacity(.5),
                                            child: IconButton(
                                                padding: EdgeInsets.zero,
                                                onPressed: () {
                                                  socialCubit.getCoverImage();
                                                },
                                                icon: const Icon(
                                                  IconBroken.Camera,
                                                  size: 30,
                                                )),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Stack(
                                    alignment: AlignmentDirectional.bottomEnd,
                                    children: [
                                      CircleAvatar(
                                        radius: 59,
                                        backgroundColor: Colors.white,
                                        child: InkWell(
                                          child: CircleAvatar(
                                              radius: 55,
                                              backgroundImage:
                                                  (profileImage == null
                                                          ? NetworkImage(
                                                              userModel.image)
                                                          : FileImage(
                                                              profileImage!))
                                                      as ImageProvider),
                                          onTap: () {
                                            socialCubit.getProfileImage();
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 20.0, bottom: 10),
                                        child: CircleAvatar(
                                          backgroundColor:
                                              Colors.white.withOpacity(.5),
                                          radius: 15,
                                          child: IconButton(
                                              padding: EdgeInsets.zero,
                                              onPressed: () {
                                                socialCubit.getProfileImage();
                                              },
                                              icon: const Icon(
                                                IconBroken.Camera,
                                                size: 25,
                                              )),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            if (profileImage != null || coverImage != null)
                              Row(
                                children: [
                                  if (profileImage != null)
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Container(
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: Colors.blueGrey),
                                              child: MaterialButton(
                                                child: const Text(
                                                    'Update Profile Picture',
                                                    style: TextStyle(
                                                        color: Colors.white)),
                                                onPressed: () {
                                                  socialCubit
                                                      .uploadProfileImage(
                                                          name: nameController
                                                              .text,
                                                          phone: phoneController
                                                              .text,
                                                          bio: bioController
                                                              .text);
                                                },
                                              )),
                                          const SizedBox(height: 5),
                                          if (state
                                              is SocialUserUpdateLoadingState)
                                            const LinearProgressIndicator(),
                                        ],
                                      ),
                                    ),
                                  if (profileImage != null &&
                                      coverImage != null)
                                    const SizedBox(width: 10),
                                  if (coverImage != null)
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Container(
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: Colors.blueGrey),
                                              child: MaterialButton(
                                                child: const Text(
                                                    'Update Cover Picture',
                                                    style: TextStyle(
                                                        color: Colors.white)),
                                                onPressed: () {
                                                  socialCubit.uploadCoverImage(
                                                      name: nameController.text,
                                                      phone:
                                                          phoneController.text,
                                                      bio: bioController.text);
                                                },
                                              )),
                                          const SizedBox(height: 5),
                                          if (state
                                              is SocialUserUpdateLoadingState)
                                            const LinearProgressIndicator(),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            const SizedBox(height: 15),
                            customTextFormField(
                              controller: nameController,
                              type: TextInputType.name,
                              prefix: IconBroken.User,
                              label: 'Name',
                              validate: (value) {
                                if (value.isEmpty) {
                                  return "Name is empty ";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 15),
                            TextFormField(
                              controller: bioController,
                              keyboardType: TextInputType.multiline,
                              minLines: 1,
                              maxLines: 4,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(IconBroken.Info_Square),
                                labelText: 'Bio',
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Bio is empty ";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 15),
                            customTextFormField(
                                controller: phoneController,
                                type: TextInputType.phone,
                                validate: (String value) {
                                  if (value.isEmpty) {
                                    return "Phone is Empty";
                                  }
                                  return null;
                                },
                                label: 'Phone Number',
                                prefix: IconBroken.Call),
                            const SizedBox(height: 15),
                            Column(children: [
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.blueGrey),
                                child: MaterialButton(
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        socialCubit.updateUser(
                                            name: nameController.text,
                                            phone: phoneController.text,
                                            bio: bioController.text);
                                      }
                                    },
                                    child: const Text(
                                      'Update Your Information',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    )),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  const Expanded(
                                      flex: 4,
                                      child: Text(
                                        'Subscribe our Announcement',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      )),
                                  const SizedBox(width: 5),
                                  Expanded(
                                    flex: 1,
                                    child: CupertinoSwitch(
                                      activeColor: Colors.blueGrey[200],
                                      onChanged: (value) {
                                        SocialCubit.get(context).switchValue();
                                        debugPrint(value.toString());
                                      },
                                      value:
                                          SocialCubit.get(context).announcement,
                                    ),
                                  ),
                                ],
                              ),
                            ])
                          ],
                        ),
                      ),
                    ),
                  )),
        );
      },
    );
  }
}
