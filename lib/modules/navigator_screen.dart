import 'package:curved_nav_bar/curved_bar/curved_action_bar.dart';
import 'package:curved_nav_bar/fab_bar/fab_bottom_app_bar_item.dart';
import 'package:curved_nav_bar/flutter_curved_bottom_nav_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:resturantapp/controlers/vavigatorscreen_controller.dart';
import 'package:resturantapp/modles/usersinfo.dart';
import 'package:resturantapp/modules/SignIn.dart';
import 'package:resturantapp/modules/profile_screen.dart';
import 'package:resturantapp/modules/search_screen.dart';
import 'package:resturantapp/shared/componenets/componenet.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';

import '../controlers/home_controller.dart';
import '../modles/Google_SignIn.dart';
import '../shared/data_resource/local_database/floordatabase_controller.dart';
import 'favorite_screen.dart';
import 'home_screen.dart';
import 'orders_screen.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  var navigatorController = Get.put(NavigatorScreenController());

  int _counter = 0;
  bool isOpened = false;

  final GlobalKey<SideMenuState> _sideMenuKey = GlobalKey<SideMenuState>();
  final GlobalKey<SideMenuState> _endSideMenuKey = GlobalKey<SideMenuState>();

  toggleMenu([bool end = false]) {
    if (end) {
      final _state = _endSideMenuKey.currentState!;
      if (_state.isOpened) {
        _state.closeSideMenu();
      } else {
        _state.openSideMenu();
      }
    } else {
      final _state = _sideMenuKey.currentState!;
      if (_state.isOpened) {
        _state.closeSideMenu();
      } else {
        _state.openSideMenu();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SideMenu(
      key: _endSideMenuKey,
      inverse: false,
      // end side menu
      background: Colors.white60,
      type: SideMenuType.slideNRotate,
      menu: Padding(
        padding: const EdgeInsets.only(right: 1.0),
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              Container(
                height: 148,
                width: double.infinity,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color.fromRGBO(242, 221, 128, 1),
                          Color.fromRGBO(199, 143, 64, 1)
                        ]),
                borderRadius: BorderRadius.only(topRight: Radius.circular(20))),
                child: Image.asset(
                  'assets/images/mainlogo.png',
                ),
                
              ),
              Container(
                height: MediaQuery.of(context).size.height-226,
              color: Colors.white60,
              child: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Column(children: [
                  SizedBox(height: 20,),

                  InkWell(
                    onTap: (){
                      if(navigatorController.isClickedOrder.value==true){
                        print("the value  =  ${navigatorController.isClickedOrder.value}");
                        navigatorController.changeStatusOnClickTheOrders(false);
                      }else{
                        print("the value  =  ${navigatorController.isClickedOrder.value}");

                        navigatorController.changeStatusOnClickTheOrders(true);
                      }
                    },
                    child: Obx(()=>Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          RotatedBox(quarterTurns: navigatorController.isClickedOrder.value ? 3 : 6, child:   Icon(Icons.arrow_back_ios_new),)
                          ,Icon(Icons.list_alt_sharp),
                          SizedBox(width: 20,),
                          getDefaultText(text: "Orders",
                              fontSize: 18,
                              color: Colors.black,
                              setShadow: true,
                              fontWeight: FontWeight.w500),
                        ],),
                    ),
                  ),

                  Obx( ()=>Container(
                      height: navigatorController.isClickedOrder.value ? 112 : 0,
                      child:Column(
                          children: [
                            RadioListTile(
                                title:Text("Families section"),
                                value:"family" ,
                                groupValue: navigatorController.valueRadioOrders.value,
                                onChanged: (value){
                                  navigatorController.onChangeRadioOrders(value.toString());
                                  Get.offAllNamed("/family");
                                }),

                            RadioListTile(
                                title:Text("Youth section"),
                                value:"Youth",
                                groupValue: navigatorController.valueRadioOrders.value,
                                onChanged: (value){
                                  navigatorController.onChangeRadioOrders(value.toString());
                                }),
                          ],
                        ),

                    ),
                  ),

                  SizedBox(height: 20,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,

                    children: [
                      Icon(Icons.settings),
                      SizedBox(width: 20,),
                      getDefaultText(text: "Settings",
                          fontSize: 18,
                          color: Colors.black,
                          setShadow: true,
                          fontWeight: FontWeight.w500),
                  ],),
                  SizedBox(height: 20,),

                  InkWell(
                    onTap: (){

                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,

                      children: [
                        Icon(Icons.app_settings_alt_rounded),
                        SizedBox(width: 20,),
                        getDefaultText(text: "About",
                            fontSize: 18,
                            color: Colors.black,
                            setShadow: true,
                            fontWeight: FontWeight.w500),


                      ],),
                  ),
                  SizedBox(height: 20,),

                  InkWell(
                    onTap: (){
                      GoogleSignInAuth.signOut();
                      Get.offAllNamed("/signIn");
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.login_sharp),
                        SizedBox(width: 20,),
                        getDefaultText(text: "Log Out",
                            fontSize: 18,
                            color: Colors.black,
                            setShadow: true,
                            fontWeight: FontWeight.w500),

                    ],),
                  ),
                ],),
              ),),
            ],
          ),
        ),
      ),
      onChange: (_isOpened) {
        // setState(() => isOpened = _isOpened);
      },
      child: IgnorePointer(
        ignoring: isOpened,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                    Color.fromRGBO(242, 221, 128, 1),
                    Color.fromRGBO(199, 143, 64, 1)
                  ])),
            ),
            centerTitle: true,
            actions: [
              Center(
                child: Stack(
                  alignment: Alignment.topLeft,
                  children: [
                    Icon(Icons.notifications_outlined,
                        size: 31, color: Colors.white),
                    CircleAvatar(
                      radius: 8,
                      backgroundColor: Colors.red,
                      child: Text(
                        "1",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Title
                getDefaultText(
                  text: "Titanic ",
                  fontSize: 20,
                  color: Colors.black,
                  setShadow: true,
                  fontWeight: FontWeight.w500,
                ),

                Image.asset(
                  'assets/images/mainlogo.png',
                  height: 60,
                  width: 60,
                ),
                // Title
                getDefaultText(
                  text: "Resturant",
                  fontSize: 20,
                  color: Colors.black,
                  setShadow: true,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
            // Notifications
            leading:  IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => toggleMenu(true),
            )
          ),
          body: SafeArea(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,

              child: CurvedNavBar(
                actionButton: CurvedActionBar(
                    onTab: (value) {
                      /// perform action here
                      print("Value print ${value.toString()}");
                      navigatorController.onClickAccount();
                    },
                    activeIcon: Container(
                        width: 70,
                        height: 70,
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(0),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(colors: [
                                    Color.fromRGBO(242, 221, 128, 1),
                                    Color.fromRGBO(199, 143, 64, 1)
                                  ])),
                            ),
                            Image(
                              image: AssetImage(
                                  "assets/images/account.png"),
                              height: 60,
                              width: 60,
                            )
                          ],
                        )),
                    text: "Account"),
                activeColor: Colors.black,
                navBarBackgroundColor:
                Color.fromRGBO(227, 227, 227, 1),
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
                      text: "Home"),
                  FABBottomAppBarItem(
                      activeIcon: Icon(
                        Icons.wallet_giftcard,
                        color: Color.fromRGBO(240, 191, 108, 1),
                      ),
                      inActiveIcon: Icon(
                        Icons.wallet_giftcard,
                        color: Colors.black26,
                      ),
                      text: "Orders"),
                  FABBottomAppBarItem(
                      activeIcon: Icon(
                        Icons.favorite_border_outlined,
                        color: Color.fromRGBO(240, 191, 108, 1),
                      ),
                      inActiveIcon: Icon(
                        Icons.favorite_border_outlined,
                        color: Colors.black26,
                      ),
                      text: "Favorite"),
                  FABBottomAppBarItem(
                      activeIcon: Icon(
                        Icons.search,
                        color: Color.fromRGBO(240, 191, 108, 1),
                      ),
                      inActiveIcon: Icon(
                        Icons.search,
                        color: Colors.black26,
                      ),
                      text: "Search"),
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
          ),
        ),
      ),
    );
  }


}
