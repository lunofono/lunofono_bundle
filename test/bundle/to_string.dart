import 'package:test/test.dart';

import 'package:lunofono_bundle/lunofono_bundle.dart';

class ToStringMixin {
  @override
  String toString() => '$runtimeType';
}

class FakeAction extends Action with ToStringMixin {}

class FakeButton extends Button with ToStringMixin {
  FakeButton() : super(FakeAction());
}

class FakeColor extends Color with ToStringMixin {
  FakeColor() : super(0);
}

class FakeInheritableConfig extends InheritableConfig with ToStringMixin {}

class FakeMenu extends Menu with ToStringMixin {}

class FakePlayable extends Playable with ToStringMixin {}

void testToString() {
  test('Bundle', () {
    final bundle = Bundle(FakeMenu(), config: FakeInheritableConfig());
    expect(bundle.toString(),
        'Bundle(rootMenu: FakeMenu, config: FakeInheritableConfig)');
  });

  test('GridMenu', () {
    final menu = GridMenu(
      rows: 1,
      columns: 1,
      buttons: [FakeButton()],
      config: FakeInheritableConfig(),
    );
    expect(
        menu.toString(),
        'GridMenu(rows: 1, columns: 1, buttons: [FakeButton], '
        'config: FakeInheritableConfig)');
  });

  test('StyledButton', () {
    final button = StyledButton(FakeAction(), FakeColor());
    expect(button.toString(),
        'StyledButton(action: FakeAction, color: FakeColor)');
  });

  test('ShowMenuAction', () {
    final action = ShowMenuAction(FakeMenu());
    expect(action.toString(), 'ShowMenuAction(menu: FakeMenu)');
  });

  test('CloseMenuAction', () {
    final action = CloseMenuAction();
    expect(action.toString(), 'CloseMenuAction()');
  });

  test('PlayContentAction', () {
    final action = PlayContentAction(FakePlayable(), loop: true);
    expect(
        action.toString(),
        'PlayContentAction(content: FakePlayable, '
        'shouldLoop: true)');
  });
}
