import 'package:KRPG/custom_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:indexed_list_view/indexed_list_view.dart';
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
    final indexedController =
        context.select((TabViewPageController c) => c.indexedController);
    final contents = context.select((TabViewPageController c) => c.contents);
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 32,
            child: IndexedListView.builder(
              scrollDirection: Axis.horizontal,
              controller: indexedController,
              itemBuilder: (context, index) {
                final clampedIndex = index % contents.length;
                return InkWell(
                  onTap: () => context
                      .read<TabViewPageController>()
                      .onTapContent(index, MediaQuery.of(context).size.width),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: _TabContent(
                      content: contents[clampedIndex],
                    ),
                  ),
                );
              },
            ),
          ),
          InfiniteScrollTabBar(
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
    indexedController = IndexedScrollController();
  }

  final Locator locator;
  TabController tabController;
  IndexedScrollController indexedController;
  final contents = List.generate(10, (index) => '#' * index + 'yey');

  void onTapContent(int index, double width) {
    final screenCenter = width / 2;
    final textPainter = TextPainter(
      text: TextSpan(text: contents[index % contents.length]),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    final offset = textPainter.width / 2 + 16 - screenCenter;
    indexedController.animateToIndexAndOffset(
      index: index,
      offset: offset,
      duration: Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    indexedController.dispose();
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
