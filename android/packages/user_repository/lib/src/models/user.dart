import 'package:equatable/equatable.dart';

class MyUser extends Equatable{
  final String userId;
  final String email;
  final String name;

  const MyUser({
    required this.userId,
    required this.email,
    required this.name

});

  static const empty=MyUser(userId: '', email: '', name: '');

  MyUser copyWith({String? userId,String? email,String? name}){
    return MyUser(userId: (userId?? this.userId), email: email??this.email, name: name?? this.name
    );
  }

  @override
  List<Object> get props=> [userId,email,name];
}