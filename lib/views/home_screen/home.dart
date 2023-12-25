import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/controllers/home_controller.dart';
import 'package:emart_seller/views/home_screen/home_screen.dart';
import 'package:emart_seller/views/orders_screen/orders_screen.dart';
import 'package:emart_seller/views/products_screen/products_screen.dart';
import 'package:emart_seller/views/profile_screen/profile_screen.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());
    var navScreens = [
      const HomeScreen(),
      const ProductsScreen(),
      const OrdersScreen(),
      const ProfileScreen(),
    ];
    var bottomNavbar = [
      const BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: dashboard,
      ),
      BottomNavigationBarItem(icon: Image.asset(icProducts, color: darkGrey, width: 24), label: products),
      BottomNavigationBarItem(icon: Image.asset(icOrders, color: darkGrey, width: 24), label: orders),
      BottomNavigationBarItem(icon: Image.asset(icGeneralSettting, color: darkGrey, width: 24), label: settings),
    ];
    return Scaffold(
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
            onTap: (index) {
              controller.navIndex.value = index;
            },
            currentIndex: controller.navIndex.value,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: purpleColor,
            unselectedItemColor: darkGrey,
            items: bottomNavbar),
      ),
      body: Column(
        children: [
          Obx(() => Expanded(child: navScreens.elementAt(controller.navIndex.value))),
        ],
      ),
    );
  }
}
