import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PreventableFocusNode extends FocusNode {
  bool canFocus = true;

  @override
  bool get hasFocus => canFocus ? super.hasFocus : false;
}

class UnFocusClearText extends StatelessWidget {
  const UnFocusClearText._({Key? key}) : super(key: key);

  static Widget wrapped() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => UnFocusClearTextController()),
      ],
      child: const UnFocusClearText._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final inputTextController =
        context.select((UnFocusClearTextController c) => c.inputTextController);
    final focus = context.select((UnFocusClearTextController c) => c.focus);
    final text = context.select((UnFocusClearTextController c) => c.inputText);
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.7),
      body: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 0.4, sigmaY: 0.4),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: TextFormField(
              controller: inputTextController,
              focusNode: focus,
              decoration: InputDecoration(
                suffixIcon: text.isEmpty
                    ? null
                    : IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () => context
                            .read<UnFocusClearTextController>()
                            .clearSearchText(),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class UnFocusClearTextController extends ChangeNotifier {
  UnFocusClearTextController({this.locator}) {
    _focus.addListener(_onFocusChange);
    _inputTextController = TextEditingController();

    _inputTextController!.addListener(() {
      inputText = _inputTextController!.text;
      notifyListeners();
    });
  }

  final Locator? locator;
  PreventableFocusNode _focus = PreventableFocusNode();
  PreventableFocusNode get focus => _focus;
  TextEditingController? _inputTextController;
  TextEditingController? get inputTextController => _inputTextController;
  String inputText = '';

  void _onFocusChange() {
    if (!_focus.canFocus) return;

    print('hasFocus: ${_focus.hasFocus}');
  }

  void clearSearchText() async {
    // フォーカス及びリスナーが動かないようにロック
    _focus.canFocus = false;

    // キーワードのリセット
    inputText = '';
    _inputTextController!.clear();
    notifyListeners();

    // rebuild後のコールバックだとフォーカスされてしまうためディレイ
    await Future.delayed(Duration(milliseconds: 350));
    _focus.canFocus = true;
    _focus.unfocus();
  }
}
