import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dust_app/component/card_title.dart';
import 'package:dust_app/component/main_app_bar.dart';
import 'package:dust_app/component/main_card.dart';
import 'package:dust_app/component/main_stat.dart';
import 'package:dust_app/const/colors.dart';
import 'package:dust_app/const/data.dart';
import 'package:dust_app/const/status_level.dart';
import 'package:dust_app/repository/stat_repostiory.dart';
import 'package:dust_app/utils/data_utils.dart';
import 'package:flutter/material.dart';

import '../component/category_card.dart';
import '../component/hourly_card.dart';
import '../component/main_drawer.dart';
import '../const/regions.dart';
import '../model/stat_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String region = regions[0];

  Future<Map<ItemCode, List<StatModel>>> fetchData() async {
    Map<ItemCode, List<StatModel>> stats = {};

    List<Future> futures = [];

    for (ItemCode itemCode in ItemCode.values) {
      // 미세먼지 종류 가져오기
      futures.add(
        StatRepository.fetchData(
          itemCode: itemCode, // 미세먼지 외에 모든 미세먼지 종류 가져올 수 있음
        ),
      );
    }

    final results = await Future.wait(futures);

    for(int i = 0; i < results.length; i ++) {
      final key = ItemCode.values[i];
      final value = results[i];

      stats.addAll({
        key : value,
      });
    }

    return stats;
  }

  @override
  Widget build(BuildContext context) {
    final ts = TextStyle(
      color: Colors.white,
      fontSize: 30.0,
    );

    return Scaffold(
      backgroundColor: primary_color,
      drawer: MainDrawer(
        selectedRegions: region,
        onRegionTap: (region) {
          setState(() {
            this.region = region;
          });
          Navigator.of(context).pop();
        },
      ),
      body: FutureBuilder<Map<ItemCode, List<StatModel>>>(
          future: fetchData(),
          builder: (context, snapshot) {
            // 에러가 있는 경우
            if (snapshot.hasError) {
              return Center(
                child: Text('에러가 있습니다.'),
              );
            }

            // 데이터가 없을 경우
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            // 에러도 없고 데이터가 있는 경우
            Map<ItemCode, List<StatModel>> stats = snapshot.data!;
            StatModel pm10RecentStat = stats[ItemCode.PM10]![0];

            // 1 - 5, 6 - 10, 11 - 15
            // 7
            final status = DataUtils.getStatusItemCodeAndValue(
              value: pm10RecentStat.seoul,
              itemCode: ItemCode.PM10,
            );
            //print(pm10RecentStat.seoul);

            return CustomScrollView(
              slivers: [
                MainAppBar(
                  region: region,
                  stat: pm10RecentStat,
                  status: status,
                ),
                // sliver 안에 child widget 사용 가능
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
            );
          }),
    );
  }
}
