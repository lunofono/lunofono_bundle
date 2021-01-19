import 'package:lunofono_bundle/lunofono_bundle.dart';

import '../config/data.dart';
import '../media/data.dart';

const colorRed = Color(0xFFFF0000);
const colorGreen = Color(0xFF00FF00);
const colorBlue = Color(0xFF0000FF);

const allColors = <Color>[
  colorRed,
  colorGreen,
  colorBlue,
];

final actionCloseMenu = CloseMenuAction();
final actionShowMenuGrid1x1 = ShowMenuAction(gridMenu1x1);
final actionPlayAudio1 = PlayContentAction(audio1);
final actionPlayImage1 = PlayContentAction(image1, loop: true);
final actionPlayVideo1 = PlayContentAction(video1, loop: false);

final allActions = <Action>[
  actionCloseMenu,
  actionShowMenuGrid1x1,
  actionPlayAudio1,
  actionPlayImage1,
  actionPlayVideo1,
];

final coloredButtonRedCloseMenu = ColoredButton(actionCloseMenu, colorRed);
final coloredButtonGreenPlayAudio1 =
    ColoredButton(actionPlayAudio1, colorGreen);
final coloredButtonBluePlayImage1 = ColoredButton(actionPlayImage1, colorBlue);
final coloredButtonRedPlayVideo1 = ColoredButton(actionPlayVideo1, colorRed);
final coloredButtonGreenShowMenuGrid1x1 =
    ColoredButton(actionShowMenuGrid1x1, colorGreen);

final allButtons = <Button>[
  coloredButtonRedCloseMenu,
  coloredButtonGreenPlayAudio1,
  coloredButtonBluePlayImage1,
  coloredButtonRedPlayVideo1,
  coloredButtonGreenShowMenuGrid1x1,
];

final gridMenu1x1 = GridMenu(
  rows: 1,
  columns: 1,
  buttons: <Button>[
    coloredButtonRedCloseMenu,
  ],
);

final gridMenu1x2 = GridMenu(
  rows: 1,
  columns: 2,
  buttons: <Button>[
    coloredButtonRedCloseMenu,
    coloredButtonGreenPlayAudio1,
  ],
  config: null,
);

final gridMenu2x1 = GridMenu(
  rows: 2,
  columns: 1,
  buttons: <Button>[
    coloredButtonBluePlayImage1,
    coloredButtonRedPlayVideo1,
  ],
  config: inheritedConfig,
);

final gridMenu2x2 = GridMenu(
  rows: 2,
  columns: 2,
  buttons: <Button>[
    coloredButtonRedCloseMenu,
    coloredButtonGreenPlayAudio1,
    coloredButtonBluePlayImage1,
    coloredButtonRedPlayVideo1,
  ],
  config: inheritableConfig1o1r1,
);

final gridMenu1x4 = GridMenu(
  rows: 1,
  columns: 4,
  buttons: <Button>[
    coloredButtonRedCloseMenu,
    coloredButtonGreenPlayAudio1,
    coloredButtonBluePlayImage1,
    coloredButtonRedPlayVideo1,
  ],
  config: inheritableConfig2o2r2,
);

final gridMenu5x1 = GridMenu(
  rows: 5,
  columns: 1,
  buttons: <Button>[
    coloredButtonRedCloseMenu,
    coloredButtonGreenPlayAudio1,
    coloredButtonBluePlayImage1,
    coloredButtonRedPlayVideo1,
    coloredButtonGreenShowMenuGrid1x1,
  ],
);

final allMenus = <GridMenu>[
  gridMenu1x1,
  gridMenu1x2,
  gridMenu2x1,
  gridMenu2x2,
  gridMenu1x4,
];

final bundle1 = Bundle(gridMenu1x1);
