import 'package:test/test.dart';

import 'package:lunofono_bundle/lunofono_bundle.dart';

void testCopyWithBundle(
  Bundle original,
  Menu newRootMenu,
  InheritableConfig newConfig,
) {
  group('${original.runtimeType} success when', () {
    final originalRootMenu = original.rootMenu;
    final originalConfig = original.config;

    void expectUnchangedOriginalNotSame(dynamic copy) {
      expect(copy, isNot(same(original)));
      expect(original.rootMenu, equals(originalRootMenu));
      expect(original.config, equals(originalConfig));
    }

    test('no arguments', () {
      final copy = original.copyWith();
      expectUnchangedOriginalNotSame(copy);
      // should make an exact copy
      expect(copy, equals(original));
    });

    test('rootMenu: $newRootMenu', () {
      final copy = original.copyWith(rootMenu: newRootMenu);
      expectUnchangedOriginalNotSame(copy);
      // should not touch other members
      expect(copy.config, equals(original.config));
      // should update copy's rootMenu
      expect(copy.rootMenu, equals(newRootMenu));
    });

    test('config: $newConfig', () {
      final copy = original.copyWith(config: newConfig);
      expectUnchangedOriginalNotSame(copy);
      // should not touch other members
      expect(copy.rootMenu, equals(original.rootMenu));
      // should update copy's rootMenu
      expect(copy.config, equals(newConfig));
    });

    test('rootMenu: $newRootMenu, config: $newConfig', () {
      final copy = original.copyWith(rootMenu: newRootMenu, config: newConfig);
      expectUnchangedOriginalNotSame(copy);
      // should update copy's rootMenu
      expect(copy.rootMenu, equals(newRootMenu));
      expect(copy.config, equals(newConfig));
    });
  });
}

void testCopyWithGridMenu(
  GridMenu original,
  GridMenu newMenu,
  InheritableConfig newConfig,
) {
  group('${original.runtimeType}', () {
    group('success when', () {
      final originalRows = original.rows;
      final originalColumns = original.columns;
      final originalButtons = original.buttons;
      final originalConfig = original.config;

      void expectUnchangedOriginalNotSame(dynamic copy) {
        expect(copy, isNot(same(original)));
        expect(original.rows, equals(originalRows));
        expect(original.columns, equals(originalColumns));
        expect(original.buttons, equals(originalButtons));
        expect(original.config, equals(originalConfig));
      }

      test('no arguments', () {
        final copy = original.copyWith();
        expectUnchangedOriginalNotSame(copy);
        // should make an exact copy
        expect(copy, equals(original));
      });

      test('swap rows and columns', () {
        final copy = original.copyWith(
          rows: original.columns,
          columns: original.rows,
        );
        expectUnchangedOriginalNotSame(copy);
        // should not touch other members
        expect(copy.buttons, equals(original.buttons));
        expect(copy.config, equals(original.config));
        // should update copy's rootMenu
        expect(copy.rows, equals(original.columns));
        expect(copy.columns, equals(original.rows));
      });

      test('change buttons', () {
        final newButtons = List<Button>.from(original.buttons)
          ..removeLast()
          ..add(original.buttons.first);
        final copy = original.copyWith(buttons: newButtons);
        expectUnchangedOriginalNotSame(copy);
        // should not touch other members
        expect(copy.rows, equals(original.rows));
        expect(copy.columns, equals(original.columns));
        expect(copy.config, equals(original.config));
        // should update copy's rootMenu
        expect(copy.buttons, equals(newButtons));
      });

      test('config', () {
        final copy = original.copyWith(config: newConfig);
        expectUnchangedOriginalNotSame(copy);
        // should not touch other members
        expect(copy.rows, equals(original.rows));
        expect(copy.columns, equals(original.columns));
        expect(copy.buttons, equals(original.buttons));
        // should update copy's rootMenu
        expect(copy.config, equals(newConfig));
      });

      test('rows, columns, buttons, config', () {
        final copy = original.copyWith(
          rows: newMenu.rows,
          columns: newMenu.columns,
          buttons: newMenu.buttons,
          config: newMenu.config,
        );
        expectUnchangedOriginalNotSame(copy);
        // should update copy's rootMenu
        expect(copy.rows, equals(newMenu.rows));
        expect(copy.columns, equals(newMenu.columns));
        expect(copy.buttons, equals(newMenu.buttons));
        expect(copy.config, equals(newMenu.config));
      });
    });
    group('asserts when', () {
      test('rows: 0', () {
        expect(
            () => original.copyWith(rows: 0), throwsA(isA<AssertionError>()));
      });
      test('columns: 0', () {
        expect(() => original.copyWith(columns: 0),
            throwsA(isA<AssertionError>()));
      });
      test('buttons: []', () {
        expect(() => original.copyWith(buttons: []),
            throwsA(isA<AssertionError>()));
      });
      test("buttons don't matching rows and columns)", () {
        final newButtons = List<Button>.from(original.buttons)
          ..add(original.buttons.first);
        expect(() => original.copyWith(buttons: newButtons),
            throwsA(isA<AssertionError>()));
      });
    });
  });
}

void testCopyWithStyledButton(
  StyledButton original,
  Action newAction,
  Color newBackgroundColor,
) {
  group('${original.runtimeType} success when', () {
    final originalAction = original.action;
    final originalColor = original.backgroundColor;

    void expectUnchangedOriginalNotSame(dynamic copy) {
      expect(copy, isNot(same(original)));
      expect(original.action, equals(originalAction));
      expect(original.backgroundColor, equals(originalColor));
    }

    test('no arguments', () {
      final copy = original.copyWith();
      expectUnchangedOriginalNotSame(copy);
      // should make an exact copy
      expect(copy, equals(original));
    });

    test('action: $newAction', () {
      final copy = original.copyWith(action: newAction);
      expectUnchangedOriginalNotSame(copy);
      // should not touch other members
      expect(copy.backgroundColor, equals(original.backgroundColor));
      // should update copy's action
      expect(copy.action, equals(newAction));
    });

    test('backgroundColor: $newBackgroundColor', () {
      final copy = original.copyWith(backgroundColor: newBackgroundColor);
      expectUnchangedOriginalNotSame(copy);
      // should not touch other members
      expect(copy.action, equals(original.action));
      // should update copy's action
      expect(copy.backgroundColor, equals(newBackgroundColor));
    });

    test('action: $newAction, backgroundColor: $newBackgroundColor', () {
      final copy = original.copyWith(
          action: newAction, backgroundColor: newBackgroundColor);
      expectUnchangedOriginalNotSame(copy);
      // should update copy's action
      expect(copy.action, equals(newAction));
      expect(copy.backgroundColor, equals(newBackgroundColor));
    });
  });
}

void testCopyWithShowMenuAction(
  ShowMenuAction original,
  Menu newMenu,
) {
  group('${original.runtimeType} success when', () {
    final originalMenu = original.menu;

    void expectUnchangedOriginalNotSame(dynamic copy) {
      expect(copy, isNot(same(original)));
      expect(original.menu, equals(originalMenu));
    }

    test('no arguments', () {
      final copy = original.copyWith();
      expectUnchangedOriginalNotSame(copy);
      // should make an exact copy
      expect(copy, equals(original));
    });

    test('menu: $newMenu', () {
      final copy = original.copyWith(menu: newMenu);
      expectUnchangedOriginalNotSame(copy);
      // should update copy's menu
      expect(copy.menu, equals(newMenu));
    });
  });
}

void testCopyWithCloseMenuAction(
  CloseMenuAction original,
) {
  group('${original.runtimeType} success when', () {
    void expectUnchangedOriginalNotSame(dynamic copy) {
      expect(copy, isNot(same(original)));
      expect(copy, equals(original));
    }

    test('no arguments', () {
      final copy = original.copyWith();
      expectUnchangedOriginalNotSame(copy);
      // should make an exact copy
      expect(copy, equals(original));
    });
  });
}

void testCopyWithPlayContentAction(
  PlayContentAction original,
  Playable newContent,
) {
  group('${original.runtimeType} success when', () {
    final originalContent = original.content;

    void expectUnchangedOriginalNotSame(dynamic copy) {
      expect(copy, isNot(same(original)));
      expect(original.content, equals(originalContent));
    }

    test('no arguments', () {
      final copy = original.copyWith();
      expectUnchangedOriginalNotSame(copy);
      // should make an exact copy
      expect(copy, equals(original));
    });

    test('content: $newContent', () {
      final copy = original.copyWith(content: newContent);
      expectUnchangedOriginalNotSame(copy);
      // should update copy's content
      expect(copy.content, equals(newContent));
    });
  });
}
