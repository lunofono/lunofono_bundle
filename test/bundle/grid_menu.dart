import 'package:test/test.dart';

import 'package:lunofono_bundle/lunofono_bundle.dart';

void testGridMenu() {
  group('buttonAt()', () {
    test('4x2', () {
      final menu = GridMenu(
        rows: 4,
        columns: 2,
        buttons: [
          StyledButton(
            PlayContentAction(
              Audio(
                Uri.parse('assets/buttons/4294951175.opus'),
              ),
            ),
            Color(9090),
          ),
          StyledButton(
            PlayContentAction(
              Image(
                Uri.parse('assets/buttons/4294198070.jpg'),
              ),
            ),
            Color(9091),
          ),
          StyledButton(
            PlayContentAction(
              Audio(
                Uri.parse('assets/buttons/4294940672.opus'),
              ),
            ),
            Color(9190),
          ),
          StyledButton(
            PlayContentAction(
              Audio(
                Uri.parse('assets/buttons/4293467747.opus'),
              ),
            ),
            Color(9191),
          ),
          StyledButton(
            PlayContentAction(
              Video(
                Uri.parse('assets/buttons/4278228616.webm'),
              ),
            ),
            Color(9290),
          ),
          StyledButton(
            PlayContentAction(
              Audio(
                Uri.parse('assets/buttons/4288423856.opus'),
              ),
            ),
            Color(9291),
          ),
          StyledButton(
            PlayContentAction(
              Video(
                Uri.parse('assets/buttons/4280391411.webm'),
              ),
            ),
            Color(9390),
          ),
          StyledButton(
            PlayContentAction(
              Audio(
                Uri.parse('assets/buttons/4283215696.opus'),
              ),
            ),
            Color(9391),
          ),
        ],
      );
      for (var i = 0; i < menu.rows; i++) {
        for (var j = 0; j < menu.columns; j++) {
          final button = menu.buttonAt(i, j) as StyledButton;
          final expectedColor = Color(9000 + 100 * i + 90 + j);
          expect(button.color, equals(expectedColor),
              reason: ' Details: row=$i, col=$j, color=${button.color.value}, '
                  'expected=${expectedColor.value}');
        }
      }
    });
  });
}
