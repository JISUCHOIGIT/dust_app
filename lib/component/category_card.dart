import 'package:dust_app/component/card_title.dart';
import 'package:dust_app/component/main_card.dart';
import 'package:flutter/material.dart';

import '../const/colors.dart';
import 'main_stat.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // SizedBox -> height 지정
      height: 160,
      child: MainCard(
        // LayoutBuilde => Layout 넓이 조정 가능
        // constraint를 받아서 넓이 조정 가능
        child: LayoutBuilder(
          builder: (context, constraint) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CardTitle(title: '종류별 통계'),
                Expanded(
                  // Scroll 가능 위젯 + Column 안에 있으면
                  // Expanded 사용해야 함
                  // 최상 top 위젯에 SizedBox -> height 지정
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    physics: PageScrollPhysics(),
                    children: List.generate(
                      20,
                      (index) => MainStat(
                          width: constraint.maxWidth / 3,
                          category: '미세먼지${index}',
                          imgPath: 'asset/img/best.png',
                          level: '최고',
                          stat: '0㎍/㎥'),
                    ).toList(),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
