import 'package:dust_app/const/colors.dart';
import 'package:flutter/material.dart';

const regions = [
  '서울',
  '경기',
  '대구',
  '충남',
  '인천',
  '대전',
  '경북',
  '세종',
  '광주',
  '전북',
  '강원',
  '울산',
  '전남',
  '부산',
  '제주',
  '충북',
  '강남',
];

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

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
              selected: e == regions,
              onTap: () {},
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
