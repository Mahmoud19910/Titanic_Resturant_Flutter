import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_tab_view/infinite_scroll_tab_view.dart';


class FavoriteScreen extends StatefulWidget {
   FavoriteScreen({Key? key}) : super(key: key);



   @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}


class _FavoriteScreenState extends State<FavoriteScreen> {

  List<String> list=["gsdg" , "sgsg" ,"egseg" , "efef"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: InfiniteScrollTabView(
          contentLength: list.length,
          onTabTap: (index) {
            debugPrint('tapped $index');
          },
          tabBuilder: (index, isSelected) => Text(
            list[index],
            style: TextStyle(
              color: isSelected ? Colors.pink : Colors.black54,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          separator: const BorderSide(color: Colors.black12, width: 2.0),
          onPageChanged: (index) => debugPrint('page changed to $index.'),
          indicatorColor: Colors.pink,
          pageBuilder: (context, index, _) {
            return SizedBox.expand(
              child: Center(
                child: Text(
                 list[index],
                  style: Theme.of(context).textTheme.headline3!.copyWith(

                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}






















