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

void testConstructorStyledButton(
  Action action,
  Color backgroundColor,
  Uri foregroundImage,
) {
  group('StyledButton', () {
    group('success when', () {
      test('action', () {
        final button = StyledButton(action);
        expect(button.action, equals(action));
        expect(button.backgroundColor, isNull);
        expect(button.foregroundImage, isNull);
      });
      test('action, backgroundColor', () {
        final button = StyledButton(action, backgroundColor: backgroundColor);
        expect(button.action, equals(action));
        expect(button.backgroundColor, equals(backgroundColor));
        expect(button.foregroundImage, isNull);
      });
      test('action, foregroundImage', () {
        final button = StyledButton(action, foregroundImage: foregroundImage);
        expect(button.action, equals(action));
        expect(button.backgroundColor, isNull);
        expect(button.foregroundImage, equals(foregroundImage));
      });
      test('action, backgroundColor, foregroundImage', () {
        final button = StyledButton(action,
            backgroundColor: backgroundColor, foregroundImage: foregroundImage);
        expect(button.action, equals(action));
        expect(button.backgroundColor, equals(backgroundColor));
        expect(button.foregroundImage, equals(foregroundImage));
      });
    });

    group('assert when', () {
      test('null, backgroundColor', () {
        expect(() => StyledButton(null, backgroundColor: backgroundColor),
            throwsA(isA<AssertionError>()));
      });
      test('null', () {
        expect(() => StyledButton(null), throwsA(isA<AssertionError>()));
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
      });
      test('content', () {
        final action = PlayContentAction(content);
        expect(action.content, equals(content));
      });
    });

    group('assert when', () {
      test('content null', () {
        expect(() => PlayContentAction(null), throwsA(isA<AssertionError>()));
      });
    });
  });
}
