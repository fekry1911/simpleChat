import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/component_widgets/reuse/reuse.dart';
import '../../../chat/presentation/chatDetails.dart';
import '../../cubit/user/userStates.dart';
import '../../cubit/user/usercubit.dart';


class Chats extends StatelessWidget {
   Chats({super.key});



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UsersCubit, UsersState>(
        listener: (context, state) {
          if (state is UsersFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.error}')),
            );
          }
        },
        builder: (context, state) {
          if (state is UsersLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UsersSuccess) {
            if (state.users.isEmpty) {
              return const Center(child: Text('No Users Found'));
            }
            return ListView.builder(
              itemCount: state.users.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.image_not_supported),
                  title: Text(state.users[index].name),
                  subtitle: Text(state.users[index].email),
                  onTap: () {
                    Navigateto(context: context, ScreenName: ChatScreen(otherUser: state.users[index],));
                  },
                );
              },
            );
          } else {
            return const SizedBox();
          }
        },
      );
  }
}
/*CircleAvatar(
                    backgroundImage: NetworkImage(state.users[index].profilePic),
                  )*/