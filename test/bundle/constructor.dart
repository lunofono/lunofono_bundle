import 'package:test/test.dart';

import 'package:lunofono_bundle/lunofono_bundle.dart';

void testConstructorBundle(
  Menu rootMenu,
  InheritableConfig config,
) {
  group('Bundle', () {
    group('success when', () {
      test('rootMenu', () {
        final bundle = Bundle(rootMenu);
        expect(bundle.rootMenu, equals(rootMenu));
        expect(bundle.config, equals(inheritedConfig));
      });

      test('rootMenu, null', () {
        final bundle = Bundle(rootMenu, config: null);
        expect(bundle.rootMenu, equals(rootMenu));
        expect(bundle.config, equals(inheritedConfig));
      });

      test('rootMenu, inheritedConfig', () {
        final bundle = Bundle(rootMenu, config: null);
        expect(bundle.rootMenu, equals(rootMenu));
        expect(bundle.config, equals(inheritedConfig));
      });

      test('rootMenu, config', () {
        final bundle = Bundle(rootMenu, config: config);
        expect(bundle.rootMenu, equals(rootMenu));
        expect(bundle.config, equals(config));
      });
    });

    group('assert when', () {
      test('null', () {
        expect(() => Bundle(null), throwsA(isA<AssertionError>()));
      });
    });
  });
}

void testConstructorGridMenu(
  int rows,
  int columns,
  List<Button> buttons,
  InheritableConfig config,
) {
  group('GridMenu', () {
    group('success when', () {
      test('rows, columns, buttons', () {
        final button = GridMenu(
          rows: rows,
          columns: columns,
          buttons: buttons,
        );
        expect(button.rows, equals(rows));
        expect(button.columns, equals(columns));
        expect(button.buttons, equals(buttons));
        expect(button.config, equals(inheritedConfig));
      });

      test('rows, columns, buttons, null', () {
        final button = GridMenu(
          rows: rows,
          columns: columns,
          buttons: buttons,
          config: null,
        );
        expect(button.rows, equals(rows));
        expect(button.columns, equals(columns));
        expect(button.buttons, equals(buttons));
        expect(button.config, equals(inheritedConfig));
      });

      test('rows, columns, buttons, inheritedConfig', () {
        final button = GridMenu(
          rows: rows,
          columns: columns,
          buttons: buttons,
          config: inheritedConfig,
        );
        expect(button.rows, equals(rows));
        expect(button.columns, equals(columns));
        expect(button.buttons, equals(buttons));
        expect(button.config, equals(inheritedConfig));
      });

      test('rows, columns, buttons, config', () {
        final button = GridMenu(
          rows: rows,
          columns: columns,
          buttons: buttons,
          config: config,
        );
        expect(button.rows, equals(rows));
        expect(button.columns, equals(columns));
        expect(button.buttons, equals(buttons));
        expect(button.config, equals(config));
      });
    });

    group('assert when', () {
      test('bad rows (null, 0)', () {
        expect(
            () => GridMenu(
                  rows: null,
                  columns: columns,
                  buttons: buttons,
                ),
            throwsA(isA<AssertionError>()));
        expect(
            () => GridMenu(
                  rows: 0,
                  columns: columns,
                  buttons: buttons,
                ),
            throwsA(isA<AssertionError>()));
      });

      test('bad columns (null, 0)', () {
        expect(
            () => GridMenu(
                  rows: rows,
                  columns: null,
                  buttons: buttons,
                ),
            throwsA(isA<AssertionError>()));
        expect(
            () => GridMenu(
                  rows: rows,
                  columns: 0,
                  buttons: buttons,
                ),
            throwsA(isA<AssertionError>()));
      });

      test('bad buttons (null, 0 lenght, not matching rows and columns)', () {
        expect(
            () => GridMenu(
                  rows: rows,
                  columns: columns,
                  buttons: null,
                ),
            throwsA(isA<AssertionError>()));
        expect(
            () => GridMenu(
                  rows: rows,
                  columns: columns,
                  buttons: [],
                ),
            throwsA(isA<AssertionError>()));
        expect(
            () => GridMenu(
                  rows: rows,
                  columns: columns,
                  buttons: List<Button>.from(buttons)..add(buttons.first),
                ),
            throwsA(isA<AssertionError>()));
      });
    });
  });
}

void testConstructorColoredButton(
  Action action,
  Color color,
) {
  group('ColoredButton', () {
    group('success when', () {
      test('action, color', () {
        final button = ColoredButton(action, color);
        expect(button.action, equals(action));
        expect(button.color, equals(color));
      });
    });

    group('assert when', () {
      test('action, null', () {
        expect(
            () => ColoredButton(action, null), throwsA(isA<AssertionError>()));
      });
      test('null, color', () {
        expect(
            () => ColoredButton(null, color), throwsA(isA<AssertionError>()));
      });
      test('null, null', () {
        expect(() => ColoredButton(null, null), throwsA(isA<AssertionError>()));
      });
    });
  });
}

void testConstructorShowMenuAction(
  Menu menu,
) {
  group('ShowMenuAction', () {
    group('success when', () {
      test('menu', () {
        final action = ShowMenuAction(menu);
        expect(action.menu, equals(menu));
      });
    });

    group('assert when', () {
      test('null', () {
        expect(() => ShowMenuAction(null), throwsA(isA<AssertionError>()));
      });
    });
  });
}

void testConstructorCloseMenuAction() {
  group('CloseMenuAction', () {
    group('success when', () {
      test('content', () {
        final action = CloseMenuAction();
        expect(action, isNot(equals(null)));
      });
    });
  });
}

void testConstructorPlayContentAction(
  Playable content,
) {
  group('PlayContentAction', () {
    group('success when', () {
      test('content', () {
        final action = PlayContentAction(content);
        expect(action.content, equals(content));
        expect(action.shouldLoop, equals(false));
      });
      test('content, loop: false', () {
        final action = PlayContentAction(content, loop: false);
        expect(action.content, equals(content));
        expect(action.shouldLoop, equals(false));
      });
      test('content, loop: true', () {
        final action = PlayContentAction(content, loop: true);
        expect(action.content, equals(content));
        expect(action.shouldLoop, equals(true));
      });
    });

    group('assert when', () {
      test('content null', () {
        expect(() => PlayContentAction(null), throwsA(isA<AssertionError>()));
      });
    });
  });
}
