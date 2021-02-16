import 'package:flutter/material.dart' show Colors;

import 'package:lunofono_bundle/lunofono_bundle.dart';

// This defines a simple bundle with a main menu that have only one button,
// which plays a multi-medium with a 2 sounds in the main track and one image in
// the background track.
final bundle = Bundle(
  GridMenu(
    rows: 1,
    columns: 1,
    buttons: [
      StyledButton(
        PlayContentAction(
          MultiMedium(
            AudibleMultiMediumTrack(
              <Audible>[
                Audio(Uri.parse('./path/to/sound.mp3')),
                Audio(Uri.parse('https://example.com/sound.mp3')),
              ],
            ),
            backgroundTrack: VisualizableBackgroundMultiMediumTrack(
              <Visualizable>[
                Image(Uri.parse('https://example.com/image.jpg')),
              ],
            ),
          ),
        ),
        Colors.amber,
      ),
    ],
  ),
);
