import 'package:test/test.dart';

import 'package:lunofono_bundle/lunofono_bundle.dart';

import 'data.dart';
import '../config/data.dart';

void testEqualityBundle(
  Menu rootMenu,
  InheritableConfig config,
  Menu otherRootMenu,
  InheritableConfig otherConfig,
) {
  group('Bundle', () {
    group('==', () {
      test('rootMenu', () {
        expect(Bundle(rootMenu), equals(Bundle(rootMenu)));
      });

      test('rootMenu, config', () {
        final original = Bundle(rootMenu, config: config);
        final clone = Bundle(rootMenu, config: config);
        expect(original, equals(clone));
      });
    });

    group('!=', () {
      test('rootMenu', () {
        final original = Bundle(rootMenu);
        final other = Bundle(otherRootMenu);
        expect(original, isNot(equals(other)));
      });

      test('config', () {
        final original = Bundle(rootMenu, config: config);
        final other = Bundle(rootMenu, config: otherConfig);
        expect(original, isNot(equals(other)));
      });

      test('rootMenu, config', () {
        final original = Bundle(rootMenu, config: config);
        final other = Bundle(otherRootMenu, config: otherConfig);
        expect(original, isNot(equals(other)));
      });
    });
  });
}

// GridMenu tests needs to be specific because there is a tight relationship
// between rows, columns and buttons, so they can't be interchanged freely.
void testEqualityGridMenu(GridMenu original) {
  group('GridMenu', () {
    group('==', () {
      test('rows, columns, buttons', () {
        final noConfig = GridMenu(
          rows: original.rows,
          columns: original.columns,
          buttons: original.buttons,
        );
        final clone = GridMenu(
          rows: original.rows,
          columns: original.columns,
          buttons: original.buttons,
        );
        expect(noConfig, equals(clone));
      });

      test('rows, columns, buttons, config', () {
        final clone = GridMenu(
          rows: original.rows,
          columns: original.columns,
          buttons: original.buttons,
          config: original.config,
        );
        expect(original, equals(clone));
      });
    });
  });
}

void testInequalityGridMenu() {
  group('GridMenu', () {
    group('!=', () {
      test('rows, columns', () {
        final original = GridMenu(
          rows: 1,
          columns: 2,
          buttons: [
            styledButtonRedCloseMenu,
            styledButtonGreenPlayAudio1,
          ],
        );
        final other = GridMenu(
          rows: 2,
          columns: 1,
          buttons: [
            styledButtonRedCloseMenu,
            styledButtonGreenPlayAudio1,
          ],
        );
        expect(original, isNot(equals(other)));
      });

      test('buttons', () {
        final original = GridMenu(
          rows: 1,
          columns: 1,
          buttons: [styledButtonGreenPlayAudio1],
        );
        final other = GridMenu(
          rows: 1,
          columns: 1,
          buttons: [
            styledButtonRedCloseMenu,
          ],
        );
        expect(original, isNot(equals(other)));
      });

      test('config', () {
        final original = GridMenu(
          rows: 1,
          columns: 1,
          buttons: [
            styledButtonRedCloseMenu,
          ],
        );
        final other = GridMenu(
          rows: 1,
          columns: 1,
          buttons: [
            styledButtonRedCloseMenu,
          ],
          config: inheritableConfig1o1r1,
        );
        expect(original, isNot(equals(other)));
      });

      test('rows, columns, buttons, config', () {
        final original = GridMenu(
          rows: 1,
          columns: 2,
          buttons: [
            styledButtonRedCloseMenu,
            styledButtonGreenPlayAudio1,
          ],
        );
        final other = GridMenu(
          rows: 1,
          columns: 1,
          buttons: [
            styledButtonRedCloseMenu,
          ],
          config: inheritableConfig1o1r1,
        );
        expect(original, isNot(equals(other)));
      });
    });
  });
}

void testEqualityStyledButton(
  Action action,
  Color backgroundColor,
  Action otherAction,
  Color otherBackgroundColor,
) {
  group('StyledButton', () {
    group('==', () {
      test('action, backgroundColor', () {
        final original = StyledButton(action, backgroundColor: backgroundColor);
        final clone = StyledButton(action, backgroundColor: backgroundColor);
        expect(clone, equals(original));
      });
    });

    group('!=', () {
      test('action', () {
        final original = StyledButton(action, backgroundColor: backgroundColor);
        final other =
            StyledButton(otherAction, backgroundColor: backgroundColor);
        expect(original, isNot(equals(other)));
      });

      test('backgroundColor', () {
        final original = StyledButton(action, backgroundColor: backgroundColor);
        final other =
            StyledButton(action, backgroundColor: otherBackgroundColor);
        expect(original, isNot(equals(other)));
      });

      test('action, backgroundColor', () {
        final original = StyledButton(action, backgroundColor: backgroundColor);
        final other =
            StyledButton(otherAction, backgroundColor: otherBackgroundColor);
        expect(original, isNot(equals(other)));
      });
    });
  });
}

void testEqualityShowMenuAction(Menu menu, Menu otherMenu) {
  group('ShowMenuAction', () {
    group('==', () {
      test('menu', () {
        expect(ShowMenuAction(menu), equals(ShowMenuAction(menu)));
      });
    });
    group('!=', () {
      test('menu', () {
        expect(ShowMenuAction(menu), isNot(equals(ShowMenuAction(otherMenu))));
      });
    });
  });
}

void testEqualityCloseMenuAction() {
  group('CloseMenuAction', () {
    group('==', () {
      test('menu', () {
        expect(CloseMenuAction(), equals(CloseMenuAction()));
      });
    });
  });
}

void testEqualityPlayContentAction(Playable content, Playable otherContent) {
  group('PlayContentAction', () {
    group('==', () {
      test('content', () {
        expect(PlayContentAction(content), equals(PlayContentAction(content)));
      });
      test('content', () {
        expect(PlayContentAction(content), equals(PlayContentAction(content)));
      });
    });
    group('!=', () {
      test('content', () {
        expect(PlayContentAction(content),
            isNot(equals(PlayContentAction(otherContent))));
      });
    });
  });
}
