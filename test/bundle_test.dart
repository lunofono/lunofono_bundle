import 'package:test/test.dart';

import 'package:lunofono_bundle/lunofono_bundle.dart';

import 'bundle/constructor.dart';
import 'bundle/copy_with.dart';
import 'bundle/data.dart';
import 'bundle/equality.dart';
import 'bundle/grid_menu.dart';
import 'bundle/to_string.dart';
import 'config/data.dart';
import 'media/data.dart';

void main() {
  group('Constructing', () {
    testConstructors();
  });
  group('Equality for', () {
    testEquality();
  });
  group('copyWith() for', () {
    testCopyWith();
  });
  group('toString() for', () {
    testToString();
  });
  group('GridMenu', () {
    testGridMenu();
  });
}

void testConstructors() {
  for (final menu in allMenus) {
    testConstructorBundle(menu, inheritableConfig1o1r1);
  }

  for (final menu in allMenus) {
    testConstructorGridMenu(menu.rows, menu.columns, menu.buttons, menu.config);
  }

  for (final action in allActions) {
    for (final color in allColors) {
      testConstructorStyledButton(action, color, Uri.parse('some/image.png'));
    }
  }

  for (final menu in allMenus) {
    testConstructorShowMenuAction(menu);
  }

  testConstructorCloseMenuAction();

  testConstructorPlayContentAction(playList1);
}

void testEquality() {
  testEqualityBundle(
    gridMenu1x1,
    inheritableConfig1o1r1,
    gridMenu5x1,
    inheritableConfig2o2r2,
  );

  for (final menu in allMenus) {
    testEqualityGridMenu(menu);
  }
  testInequalityGridMenu();

  testEqualityStyledButton(
    actionCloseMenu,
    colorRed,
    actionPlayAudio1,
    colorBlue,
  );

  testEqualityShowMenuAction(gridMenu1x1, gridMenu1x2);
  testEqualityShowMenuAction(gridMenu2x1, gridMenu1x2);
  testEqualityShowMenuAction(gridMenu1x1, gridMenu2x2);

  testEqualityCloseMenuAction();

  testEqualityPlayContentAction(audio1, image1);
  testEqualityPlayContentAction(image1, video1);
  testEqualityPlayContentAction(video1, playList1);
}

void testCopyWith() {
  testCopyWithBundle(
    Bundle(gridMenu5x1, config: inheritableConfig1o1r1),
    gridMenu2x2,
    inheritableConfig2o2r2,
  );

  testCopyWithGridMenu(gridMenu5x1, gridMenu2x2, inheritableConfig1o1r1);

  testCopyWithStyledButton(
    styledButtonRedCloseMenu,
    actionPlayAudio1,
    colorBlue,
  );

  testCopyWithShowMenuAction(actionShowMenuGrid1x1, gridMenu2x2);

  testCopyWithCloseMenuAction(actionCloseMenu);

  testCopyWithPlayContentAction(actionPlayAudio1, playList1);
}
