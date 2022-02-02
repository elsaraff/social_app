import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_application/chats/chats_screen.dart';
import 'package:social_application/core/cache_helper.dart';
import 'package:social_application/core/dio_helper.dart';
import 'package:social_application/feeds/feeds_screen.dart';
import 'package:social_application/login/login_screen.dart';
import 'package:social_application/models/comment_model.dart';
import 'package:social_application/models/like_model.dart';
import 'package:social_application/models/message_model.dart';
import 'package:social_application/models/post_model.dart';
import 'package:social_application/models/user_model.dart';
import 'package:social_application/new_post/new_post_screen.dart';
import 'package:social_application/settings/settings_screen.dart';
import 'package:social_application/social_cubit/social_states.dart';
import 'package:social_application/users/users_screen.dart';
import 'package:social_application/widgets/functions.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialIntialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  SocialUserModel userModel;

  void getUserData() {
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      //debugPrint(value.data().toString());
      userModel = SocialUserModel.fromJson(value.data());
      emit(SocialGetUserSuccessState());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

  int currentIndex = 0;

  List<String> titles = [
    'Home',
    'Chats',
    '',
    'Users',
    'Settings',
  ];

  List<Widget> screens = [
    const FeedsScreen(),
    const ChatsScreen(),
    const NewPostScreen(),
    const UsersScreen(),
    const SettingsScreen(),
  ];
  void changeBottomNav(int index) {
    if (index == 1) {
      getAllUsers();
    }
    if (index == 2) {
      newPost();
    } else {
      currentIndex = index;
      emit(SocialChangeBottomNavState());
    }
  }

  void newPost() {
    emit(SocialNewPostState());
  }

/*____________________________________________________________________________*/

  void updateUser({
    @required String name,
    @required String phone,
    @required String bio,
    String image,
    String cover,
  }) {
    SocialUserModel model = SocialUserModel(
      name: name,
      bio: bio,
      phone: phone,
      uId: userModel.uId,
      email: userModel.email,
      image: image ?? userModel.image,
      cover: cover ?? userModel.cover,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
      updatePostsData();
      getPosts();
    }).catchError((error) {
      emit(SocialUserUpdateErrorState());
    });
  }

  var picker = ImagePicker();
  File profileImage;

  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    } else {
      debugPrint('No image selected.');
      emit(SocialProfileImagePickedErrorState());
    }
  }

  void uploadProfileImage({
    @required String name,
    @required String phone,
    @required String bio,
  }) {
    emit(SocialUserUpdateLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage.path).pathSegments.last}')
        .putFile(profileImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUser(name: name, bio: bio, phone: phone, image: value);
        removeProfileImage();
      }).catchError((error) {
        emit(SocialUploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadProfileImageErrorState());
    });
  }

  void removeProfileImage() {
    profileImage = null;
    emit(SocialRemoveProfileImageState());
  }

  File coverImage;
  Future<void> getCoverImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialCoverImagePickedSuccessState());
    } else {
      debugPrint('No image selected.');
      emit(SocialCoverImagePickedErrorState());
    }
  }

  void uploadCoverImage({
    @required String name,
    @required String phone,
    @required String bio,
  }) {
    emit(SocialUserUpdateLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage.path).pathSegments.last}')
        .putFile(coverImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUser(name: name, bio: bio, phone: phone, cover: value);
        removeCoverImage();
      }).catchError((error) {
        emit(SocialUploadCoverImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadCoverImageErrorState());
    });
  }

  void removeCoverImage() {
    coverImage = null;
    emit(SocialRemoveCoverImageState());
  }

  void creatPost({
    @required String dateTime,
    @required String time,
    String text,
    String postImage,
  }) {
    emit(SocialCreatPostLoadingState());

    PostModel model = PostModel(
      uId: userModel.uId,
      name: userModel.name,
      image: userModel.image,
      dateTime: dateTime,
      time: time,
      text: text,
      postImage: postImage ?? '',
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(SocialCreatPostSuccessState());
    }).catchError((error) {
      emit(SocialCreatPostErrorState());
    });
  }

  File postImage;

  Future<void> getPostImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialPostImagePickedSuccessState());
    } else {
      debugPrint('No image selected.');
      emit(SocialPostImagePickedErrorState());
    }
  }

  void uploadPostImage({
    @required String dateTime,
    @required String time,
    String text,
  }) {
    emit(SocialCreatPostLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage.path).pathSegments.last}')
        .putFile(postImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        creatPost(
          dateTime: dateTime,
          time: time,
          text: text,
          postImage: value,
        );
      }).catchError((error) {
        emit(SocialCreatPostErrorState());
      });
    }).catchError((error) {
      emit(SocialCreatPostErrorState());
    });
  }

  void removePostImage() {
    postImage = null;
    emit(SocialRemovePostImageState());
  }

  List<SocialUserModel> allUsers = [];
  List<PostModel> posts = [];
  List<PostModel> myPosts = [];
  List<String> postsId = [];
  List<String> likedPosts = [];
  Map<String, int> postsLikes = ({});
  Map<String, int> postsComments = ({});

  Future<void> getPosts() async {
    allUsers = [];
    posts = [];
    myPosts = [];
    postsId = [];
    likedPosts = [];
    postsLikes = ({});
    postsComments = ({});

    FirebaseFirestore.instance
        .collection('posts')
        .orderBy('time', descending: true)
        .get()
        .then((value) {
      for (var element in value.docs) {
        if (element.data()['uId'] == FirebaseAuth.instance.currentUser.uid) {
          myPosts.add(PostModel.fromJson(element.data()));
        }
        element.reference.collection('comments').get().then((value) {
          //debugPrint('postId ' + element.id.toString());
          //debugPrint('postsComments ' + value.docs.length.toString());

          postsComments.addAll({element.id: value.docs.length});
        });
        element.reference.collection('likes').get().then((value) {
          //debugPrint('postId ' + element.id.toString());
          //debugPrint('postsLikes ' + value.docs.length.toString());

          for (var e in value.docs) {
            //debugPrint('likeID ' + e.id.toString());
            //debugPrint('uId ' + e.data()['uId'].toString());

            if (e.data()['uId'] == userModel.uId) {
              likeId = e.id.toString();
              likedPosts.add(element.id);
            }
          }

          postsLikes.addAll({element.id: value.docs.length});
          postsId.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
          emit(SocialGetPostsSuccessState());
        }).catchError((error) {
          emit(SocialGetPostsErrorState(error.toString()));
          debugPrint(error.toString());
        });
      }
      //emit(SocialGetPostsSuccessState());
    }).catchError((error) {
      emit(SocialGetPostsErrorState(error.toString()));
      debugPrint(error.toString());
    });
  }

  void deletePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .delete()
        .then((value) {
      emit(SocialDeletePostSuccessState());
      getPosts();
    }).catchError((error) {
      emit(SocialDeletePostErrorState(error.toString()));
    });
  }

  List<CommentModel> postComments = [];

  void getPostComments(String postId) {
    postComments = [];
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .orderBy('time')
        .get()
        .then((value) {
      for (var element in value.docs) {
        postComments.add(CommentModel.fromJson(element.data()));
      }
      emit(SocialGetPostCommentsSuccessState());
    }).catchError((error) {
      emit(SocialGetPostCommentsErrorState(error.toString()));
    });
  }

  List<LikeModel> postLikes = [];

  void getPostLikes(String postId) {
    postLikes = [];
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .orderBy('time')
        .get()
        .then((value) {
      for (var element in value.docs) {
        postLikes.add(LikeModel.fromJson(element.data()));
      }
      emit(SocialGetPostLikesSuccessState());
    }).catchError((error) {
      emit(SocialGetPostLikesErrorState(error.toString()));
    });
  }

  String likeId = '';
  void likePost(String postId, String time) {
    LikeModel model = LikeModel(
      postId: postId,
      uId: userModel.uId,
      name: userModel.name,
      image: userModel.image,
      like: true,
      time: time,
    );
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .add(model.toMap())
        .then((value) {
      likeId = value.id;
      likedPosts.add(postId);
      debugPrint(likedPosts.toString());
      emit(SocialLikePostSuccessState());
      getSinglePost(postId);
    }).catchError((error) {
      emit(SocialLikePostErrorState(error.toString()));
    });
  }

  void dislikePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(likeId)
        .delete()
        .then((value) {
      debugPrint('likeId deleted');
      likedPosts.remove(postId);
      debugPrint(likedPosts.toString());
      getPostLikes(postId);
      getSinglePost(postId);
      emit(SocialDisLikePostSuccessState());
    }).catchError((error) {
      emit(SocialDisLikePostErrorState(error.toString()));
    });
  }

  void commentOnPost({
    @required String postId,
    @required String uId,
    @required String name,
    @required String image,
    @required String comment,
    @required String dateTime,
    @required String time,
  }) {
    CommentModel model = CommentModel(
      postId: postId,
      uId: uId,
      name: userModel.name,
      image: userModel.image,
      comment: comment,
      dateTime: dateTime,
      time: time,
    );
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .add(model.toMap())
        .then((value) {
      //debugPrint('the comment id is ${value.id}');
      FirebaseFirestore.instance
          .collection('posts')
          .doc(postId)
          .collection('comments')
          .doc(value.id)
          .update({'commentId': value.id});

      emit(SocialCommentOnPostSuccessState());
      getSinglePost(postId);
    }).catchError((error) {
      emit(SocialCommentOnPostErrorState(error.toString()));
    });
  }

  void getSinglePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .get()
        .then((value) {
      value.reference.collection('likes').get().then((value) {
        postsLikes[postId] = value.docs.length;
        emit(SocialGetSinglePostLikesSuccess());
      });
      value.reference.collection('comments').get().then((value) {
        postsComments[postId] = value.docs.length;
        emit(SocialGetSinglePostCommentsSuccess());
      });
      emit(SocialGetSinglePostSuccess());
    }).catchError((error) {
      emit(SocialGetSinglePostError());
      debugPrint(error.toString());
    });
  }

  void getAllUsers() {
    if (allUsers.isEmpty) {
      FirebaseFirestore.instance.collection('users').get().then((value) {
        for (var element in value.docs) {
          if (element.data()['uId'] != userModel.uId) {
            allUsers.add(SocialUserModel.fromJson(element.data()));
          }
        }
        emit(SocialGetAllUsersSuccessState());
      }).catchError((error) {
        emit(SocialGetAllUsersErrorState(error.toString()));
        debugPrint(error.toString());
      });
    }
  }

  void sendMessage({
    @required String receiverId,
    @required String dateTime,
    @required String text,
    @required String time,
  }) {
    MessageModel messageModel = MessageModel(
      senderId: userModel.uId,
      receiverId: receiverId,
      dateTime: dateTime,
      time: time,
      text: text,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SocialSendMessageSuccess());
    }).catchError((error) {
      emit(SocialSendMessageError(error.toString()));
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel.uId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(receiverId)
          .collection('token')
          .get()
          .then((value) {
        var element = value.docs.elementAt(0);
        var receiverToken = element.data()['token'];
        //debugPrint(receiverToken.toString());
        //debugPrint(text);
        //debugPrint(userModel.name);
        messageNotification(
            receiverToken: receiverToken,
            message: text,
            sender: userModel.name);
      });
      emit(SocialSendMessageSuccess());
    }).catchError((error) {
      emit(SocialSendMessageError(error.toString()));
    });
  }

  List<MessageModel> messages = [];

  void getMessages({
    @required String receiverId,
  }) {
    emit(SocialGetMessageLoading());

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('time')
        .snapshots()
        .listen((event) {
      messages = [];
      for (var element in event.docs) {
        messages.add(MessageModel.fromJson(element.data()));
      }
      emit(SocialGetMessageSuccess());
    });
  }

  void updatePostsData() {
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      for (var element in value.docs) {
        if (element.data()['uId'] == FirebaseAuth.instance.currentUser.uid) {
          element.reference.update(
              {'name': userModel.name, 'image': userModel.image}).then((value) {
            emit(SocialUpdatePostsDataSuccessState());
          }).catchError((error) {
            emit(SocialUpdatePostsDataErrorState(error.toString()));
          });
        }

        element.reference.collection('comments').get().then((value) {
          for (var element in value.docs) {
            if (element.data()['uId'] ==
                FirebaseAuth.instance.currentUser.uid) {
              element.reference.update({
                'name': userModel.name,
                'image': userModel.image
              }).then((value) {
                emit(SocialUpdatePostsDataSuccessState());
              }).catchError((error) {
                emit(SocialUpdatePostsDataErrorState(error.toString()));
              });
            }
          }
        }).catchError((error) {
          emit(SocialUpdatePostsDataErrorState(error.toString()));
        });

        element.reference.collection('likes').get().then((value) {
          for (var element in value.docs) {
            if (element.data()['uId'] ==
                FirebaseAuth.instance.currentUser.uid) {
              element.reference.update({
                'name': userModel.name,
                'image': userModel.image
              }).then((value) {
                emit(SocialUpdatePostsDataSuccessState());
              }).catchError((error) {
                emit(SocialUpdatePostsDataErrorState(error.toString()));
              });
            }
          }
        }).catchError((error) {
          emit(SocialUpdatePostsDataErrorState(error.toString()));
        });
      }
    }).catchError((error) {
      emit(SocialUpdatePostsDataErrorState(error.toString()));
    });
  }

  void logOut(context) {
    CacheHelper.removeData(key: 'uId').then((value) {
      if (value) {
        firstTime = false;
        CacheHelper.saveData(key: 'firstTime', value: firstTime);

        currentIndex = 0;
        //debugPrint(uId.toString());      //uId.toString()
        FirebaseAuth.instance.signOut();
        uId = CacheHelper.getData(key: 'uId');
        //debugPrint(uId.toString());     //null

        navigateAndFinish(context, const LoginScreen());
      }
    });
  }
}
