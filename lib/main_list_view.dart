import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'network/api/index_api.dart';
import 'main_card.dart';

class MainListView extends StatefulWidget {
  const MainListView({super.key});

  @override
  State<MainListView> createState() => _MainListView();
}

class _MainListView extends State<MainListView> {
  List<dynamic> list = [];
  int _page = 1;
  IndexApi api = IndexApi();
  GlobalKey _contentKey = GlobalKey();
  GlobalKey _refresherKey = GlobalKey();

  var logger = Logger();

  Map<String, dynamic> query = {};

  RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  Widget buildChild() {
    return ListView.builder(
      key: _contentKey,
      padding: EdgeInsets.only(left: 10, right: 10),
      itemBuilder: (c, i) => MainCard(
        img: list[i]["posterUrl"],
        title: list[i]["number"],
        address: list[i]["title"],
        rating: '5',
      ),
      itemCount: list.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: _refreshController,
      enablePullUp: true,
      child: buildChild(),
      header: WaterDropMaterialHeader(),
      footer: ClassicFooter(
        loadStyle: LoadStyle.ShowWhenLoading,
        completeDuration: Duration(milliseconds: 500),
      ),
      onRefresh: () async {
        _page = 1;
        query = {...query, "page": _page};
        api.request(
            query: query,
            successCallBack: (data) {
              list = data["data"];
              if (mounted) setState(() {});
              _refreshController.refreshCompleted();
            },
            errorCallBack: (error) {
              logger.e(error);
              _refreshController.refreshFailed();
            });
      },
      onLoading: () async {
        _page++;
        query = {...query, "page": _page};
        api.request(
            query: query,
            successCallBack: (data) {
              //增加数据
              list = [...list, ...data["data"]];

              if (mounted) setState(() {});
              _refreshController.loadComplete();
            },
            errorCallBack: (error) {
              logger.e(error);
              _refreshController.loadFailed();
              _page--;
            });
      },
    );
  }
}
