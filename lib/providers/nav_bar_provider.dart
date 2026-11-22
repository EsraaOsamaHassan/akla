
import 'package:flutter_riverpod/flutter_riverpod.dart';

final navBarProvider = NotifierProvider<NavBarNotifier, int>(
  NavBarNotifier.new,
);

class NavBarNotifier extends Notifier<int> {
  @override
  int build() => 0;

  void selectPage(int index) => state = index;
}
