import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

import 'package:lunofono_bundle/lunofono_bundle.dart';

void main() {
  group('ImageButton', () {
    test('equality works', () {
      final action1 = _MockAction();
      final action2 = _MockAction();
      final uri1 = Uri.parse('some/image1.png');
      final uri2 = Uri.parse('some/image2.png');

      final button1 = ImageButton(action1, uri1);
      final button2 = ImageButton(action1, uri1);
      expect(button1, equals(button2));

      final button3 = ImageButton(action1, uri2);
      expect(button1, isNot(equals(button3)));

      final button4 = ImageButton(action2, uri1);
      expect(button1, isNot(equals(button4)));

      final button5 = ImageButton(action2, uri2);
      expect(button1, isNot(equals(button5)));

      expect(button3, isNot(equals(button4)));
      expect(button3, isNot(equals(button5)));
      expect(button4, isNot(equals(button5)));
    });

    test('copyWith works', () {
      final button = ImageButton(_MockAction(), Uri.parse('image.pn'));
      final clone = button.copyWith();
      expect(clone, equals(button));

      final cloneAction = _MockAction();
      final cloneUri = Uri.parse('clone.png');
      final clone2 = button.copyWith(action: cloneAction, imageUri: cloneUri);
      expect(clone2, isNot(equals(button)));
      expect(clone2.action, same(cloneAction));
      expect(clone2.imageUri, same(cloneUri));
    });

    test('toString works', () {
      expect(ImageButton(_MockAction(), Uri.parse('image.png')).toString(),
          'ImageButton(action: _MockAction, imageUri: image.png)');
    });
  });
}

class _MockAction extends Mock implements Action {
  @override
  String toString() => '$runtimeType';
}
