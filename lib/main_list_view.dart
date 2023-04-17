import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'network/api/index_api.dart';
import 'main_list_child.dart';

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

  RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  Widget buildChild() {
    return ListView.builder(
      key: _contentKey,
      padding: EdgeInsets.only(left: 5, right: 5),
      itemBuilder: (c, i) => MainListViewChild(
        no: i,
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
        list = [];
        for (var i = 0; i < 10; i++) {
          list.add(i);
        }
        if (mounted) setState(() {});
        _refreshController.refreshCompleted();
      },
      onLoading: () async {
        for (var i = 0; i < 10; i++) {
          list.add(i);
        }
        if (mounted) setState(() {});
        _refreshController.loadComplete();
      },
    );
  }
}
