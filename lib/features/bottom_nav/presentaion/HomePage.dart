import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/shared/local/cache_helper.dart';
import '../../auth/presentation/login.dart';
import '../cubit/user/userStates.dart';
import '../cubit/user/usercubit.dart';
import 'bootomscreens/status.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UsersCubit, UsersState>(
      builder: (BuildContext context, UsersState state) {
        var cubit = UsersCubit().get(context);
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => StoryScreen()),
              );
            },
            child: cubit.Icons1[cubit.index],
          ),
          appBar: AppBar(
              title: Text(cubit.Title[cubit.index]),
              actions: [
                PopupMenuButton<String>(
                  onSelected: (value) async {
                    if (value == 'Logout') {
                     await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).update({
                        "token":""
                      });
                      FirebaseAuth.instance.signOut().then((onValue){
                        CacheHelper.removeData(key: "login");
                        CacheHelper.removeData(key: "name");
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                      });
                    }

                  },
                  itemBuilder: (BuildContext context) => [
                    PopupMenuItem(
                      value: 'Logout',
                      child: Text('LogOut'),
                    ),
                  ],
                )

              ]
          ),
          body: cubit.Screens[cubit.index],
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Colors.green,
            unselectedItemColor: Colors.grey,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.chat),
                label: cubit.Title[0],
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.amp_stories),
                label: cubit.Title[1],
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.call_sharp),
                label: cubit.Title[2],
              ),
            ],
            currentIndex: cubit.index,
            onTap: (index) {
              cubit.changeindex(index);
            },
          ),
        );
      },
      listener: (BuildContext context, UsersState state) {},
    );
  }
}
