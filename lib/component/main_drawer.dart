import 'package:dust_app/const/colors.dart';
import 'package:flutter/material.dart';

import '../const/regions.dart';

typedef OnRegionTap = void Function(String region);

class MainDrawer extends StatelessWidget {
  final OnRegionTap onRegionTap;
  final String selectedRegions;

  const MainDrawer({
    required this.onRegionTap,
    required this.selectedRegions,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: dark_color,
      child: ListView(
        children: [
          DrawerHeader(
            child: Text(
              '지역선택',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
          ),
          // children 리스트 자체 , 그래서 리스트 안에 리스트틀 넣으면 castcade ... 사용해야 함
          ...regions.map(
            (e) => ListTile(
              tileColor: Colors.white,
              // 선택시 배경 색상
              selectedTileColor: lightColor,
              // 선택시 글자 색상
              selectedColor: Colors.black,
              // selected : boolean <false, true>
              selected: e == selectedRegions,
              onTap: () {
                onRegionTap(e);
              },
              title: Text(
                e,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
