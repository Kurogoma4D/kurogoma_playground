import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vsync_provider/vsync_provider.dart';

class TabViewPage extends StatelessWidget {
  const TabViewPage._({Key key}) : super(key: key);

  static Widget wrapped() {
    return MultiProvider(
      providers: [
        VsyncProvider(),
        ChangeNotifierProvider(
          create: (context) => TabViewPageController(
            locator: context.read,
            vsync: VsyncProvider.of(context),
          ),
        ),
      ],
      child: const TabViewPage._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tabController =
        context.select((TabViewPageController c) => c.tabController);
    final contents = context.select((TabViewPageController c) => c.contents);
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TabBar(
            isScrollable: true,
            controller: tabController,
            tabs: [
              for (final content in contents) _TabContent(content: content),
            ],
          ),
          Expanded(
            child: PageView(
              onPageChanged: (index) => tabController.animateTo(index),
              children: [
                for (final content in contents) _TabContent(content: content),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TabViewPageController extends ChangeNotifier {
  TabViewPageController({this.locator, TickerProvider vsync}) {
    tabController = TabController(vsync: vsync, length: contents.length);
  }

  final Locator locator;
  TabController tabController;
  final contents = List.generate(10, (index) => 'content#$index');

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
}

class _TabContent extends StatelessWidget {
  const _TabContent({Key key, this.content}) : super(key: key);

  final String content;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      child: Center(
        child: Text(
          content,
          style: TextStyle(color: Colors.black87),
        ),
      ),
    );
  }
}
