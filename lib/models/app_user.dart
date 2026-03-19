import 'package:hive/hive.dart';

class AppUser {
  final String email;
  final String password;

  AppUser({
    required this.email,
    required this.password,
  });
}

class AppUserAdapter extends TypeAdapter<AppUser> {
  @override
  final int typeId = 1;

  @override
  AppUser read(BinaryReader reader) {
    final email = reader.readString();
    final password = reader.readString();
    return AppUser(email: email, password: password);
  }

  @override
  void write(BinaryWriter writer, AppUser obj) {
    writer.writeString(obj.email);
    writer.writeString(obj.password);
  }
}
