import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<UserEvent>((event, emit) {});
  }
}


// this class is for user data such as

// get username for statscreens
// get user stats
// get user milestones

// all these above functions will call use userRepository to get data

// ? network error handling 
// user repo will check if offline data is availible it will send to user,
// and will also send a GET req to get user's updated milestones if any,
// if finds updated data it will update otherwise not

// ? the offline data is disabled meaning user can only see it but not interact
// ? with it.