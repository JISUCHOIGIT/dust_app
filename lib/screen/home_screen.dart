import 'package:dust_app/component/card_title.dart';
import 'package:dust_app/component/main_app_bar.dart';
import 'package:dust_app/component/main_card.dart';
import 'package:dust_app/component/main_stat.dart';
import 'package:dust_app/const/colors.dart';
import 'package:flutter/material.dart';

import '../component/category_card.dart';
import '../component/hourly_card.dart';
import '../component/main_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ts = TextStyle(
      color: Colors.white,
      fontSize: 30.0,
    );

    return Scaffold(
      backgroundColor: primary_color,
      drawer: MainDrawer(),
      body: CustomScrollView(
        slivers: [
          MainAppBar(),
          // sliver안에 child widget 사용 가능
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CategoryCard(),
                SizedBox(
                  height: 16.0,
                ),
                HourlyCard(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
