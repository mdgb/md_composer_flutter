///HOMEPAGE MENE YAHA PAR HE BOTTOMNAVIGATION USE KIYA HAI
///KYUNKI CODE CHHOTA HAI ISLIYE
import 'package:flutter/material.dart';
import 'package:md_composer_flutter/services/auth_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomePage extends ConsumerStatefulWidget {
  final int index;
  HomePage({required String tab, Key? key})
      : index = indexFrom(tab),
        super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
  static int indexFrom(String tab) {
    switch (tab) {
      case 'cart':
        return 1;
      case 'profile':
        return 2;
      case 'shopping':
      default:
        return 0;
    }
  }
}

class _HomePageState extends ConsumerState<HomePage> {
  late int _selectedIndex;
  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.index;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _selectedIndex = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 54, 26, 103),
      appBar: AppBar(
        leading: Icon(
          Icons.menu,
          color: Theme.of(context).primaryColor,
        ),
        title: Text(
          "Home Page",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () async {
              await ref.read(authViewModelProvider).logout();
              // ignore: use_build_context_synchronously
              context.go('/login');
            },
            icon: const Icon(Icons.logout_outlined),
          ),
        ],
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const [
      //     BottomNavigationBarItem(icon: Icon(Icons.shop), label: 'Shop'),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.shopping_cart), label: 'Cart'),
      //     BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      //   ],
      //   backgroundColor: Colors.blue,
      //   currentIndex: _selectedIndex,
      //   selectedItemColor: Colors.white,
      //   onTap: (index) {
      //     setState(
      //       () {
      //         _selectedIndex = index;
      //         switch (index) {
      //           case 0:
      //             context.go('/shop');
      //             break;
      //           case 1:
      //             context.go('/cart');
      //             break;
      //           case 2:
      //             context.go('/profile');
      //             break;
      //         }
      //       },
      //     );
      //   },
      // ),
      // body: IndexedStack(
      //   index: _selectedIndex,
      //   children: const [Shopping(), Cart(), Profile()],
      // ),
    );
  }
}
