import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:md_composer_flutter/services/auth_services.dart';

class AvatarBase extends ConsumerWidget {
  const AvatarBase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.read(authViewModelProvider).user;
    String? name;
    if (user?.displayName != null) {
      name = user?.displayName;
    } else {
      name = user?.email?.split('@')[0];
    }
    String? avatarImageUrl = 'https://ui-avatars.com/api/?name=$name';
    if (user?.photoURL != null) {
      avatarImageUrl = user?.photoURL!;
    }
    // print('avatarImageUrl $avatarImageUrl');
    return CircleAvatar(
      maxRadius: 36,
      minRadius: 24,
      backgroundImage: NetworkImage(avatarImageUrl!),
    );
  }
}
