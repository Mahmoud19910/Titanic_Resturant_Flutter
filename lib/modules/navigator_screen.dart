import 'package:curved_nav_bar/curved_bar/curved_action_bar.dart';
import 'package:curved_nav_bar/fab_bar/fab_bottom_app_bar_item.dart';
import 'package:curved_nav_bar/flutter_curved_bottom_nav_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:resturantapp/modles/usersinfo.dart';
import 'package:resturantapp/modules/SignIn.dart';
import 'package:resturantapp/modules/search_screen.dart';


import '../controlers/home_controller.dart';
import '../modles/Google_SignIn.dart';
import '../shared/data_resource/local_database/floordatabase_controller.dart';
import 'favorite_screen.dart';
import 'home_screen.dart';
import 'orders_screen.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  var floorController = Get.put(FloorDataBaseController());
  var homeController=Get.put(HomeController());



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CurvedNavBar(
              actionButton: CurvedActionBar(
                  onTab: (value) {
                    /// perform action here
                    print(value);
                  },
                  activeIcon: Container(
                    width: 70,
                    height: 70,
                    padding: EdgeInsets.all(4),
                    decoration:
                    BoxDecoration(color: Colors.white, shape: BoxShape.circle,),
                    child: Stack(
                      alignment:Alignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(0),
                          decoration:
                          BoxDecoration(shape: BoxShape.circle,
                              gradient: LinearGradient(colors: [Color.fromRGBO(242, 221, 128, 1) , Color.fromRGBO(199, 143, 64   , 1)])),
                        ),
                        Image(image: AssetImage("assets/images/account.png"),height: 60,width: 60,)
                      ],
                    )
                  ),

                  text: "Account"),
              activeColor: Colors.black,
              navBarBackgroundColor: Color.fromRGBO(227, 227, 227, 1),

              inActiveColor: Colors.black45,

              appBarItems: [

                FABBottomAppBarItem(
                    activeIcon: Icon(
                      Icons.home_outlined,
                      color: Color.fromRGBO(240, 191, 108, 1),
                    ),
                    inActiveIcon: Icon(
                      Icons.home_outlined,
                      color: Colors.black26,
                    ),
                    text: 'Home'),
                FABBottomAppBarItem(
                    activeIcon: Icon(
                      Icons.wallet_giftcard,
                      color: Color.fromRGBO(240, 191, 108, 1),
                    ),
                    inActiveIcon: Icon(
                      Icons.wallet_giftcard,
                      color: Colors.black26,
                    ),
                    text: 'Wallet'),
                FABBottomAppBarItem(
                    activeIcon: Icon(
                      Icons.favorite_border_outlined,
                      color: Color.fromRGBO(240, 191, 108, 1),
                    ),
                    inActiveIcon: Icon(
                      Icons.favorite_border_outlined,
                      color: Colors.black26,
                    ),
                    text: 'Favorite'),
                FABBottomAppBarItem(
                    activeIcon: Icon(
                      Icons.search,
                      color: Color.fromRGBO(240, 191, 108, 1),
                    ),
                    inActiveIcon: Icon(
                      Icons.search,
                      color: Colors.black26,
                    ),
                    text: 'Search'),
              ],
              bodyItems: [
                HomeScreen(),
                OrdersScreen(),
                FavoriteScreen(),
               SearchScreen(),
              ],
              actionBarView: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                color: Colors.white,
                child: Center(child: Text("My Account")),
              ),


        ),
      ),
    );
  }
}
