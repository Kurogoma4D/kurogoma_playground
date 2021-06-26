import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'page_state_controller.dart';

class DrawerMenu extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return ListView(
      children: [
        for (final page in Pages.values)
          ListTile(
            title: Text(describeEnum(page)),
            onTap: () {
              Navigator.of(context).pop();
              context
                  .read(pageStateControllerProvider.notifier)
                  .setPage(page.index);
            },
          ),
      ],
    );
  }
}
