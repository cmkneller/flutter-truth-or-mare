import 'package:flutter/material.dart';

class CustomiseAppBar extends StatelessWidget implements PreferredSizeWidget{
  const CustomiseAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.grey,
      elevation: 0,
      title: const Text(
        "ADD",
      ),
      bottom: const TabBar(
        labelColor: Colors.black,
        unselectedLabelColor: Colors.white,
        indicatorSize: TabBarIndicatorSize.label,
        indicator: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            color: Colors.white),
        tabs: [
          Tab(
            child: Align(
              alignment: Alignment.center,
              child: Text("Truth"),
            ),
          ),
          Tab(
            child: Align(
              alignment: Alignment.center,
              child: Text("Dare"),
            ),
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(120);
  }
