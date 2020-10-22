import 'package:lunofono_bundle/lunofono_bundle.dart';

import '../config/data.dart';

final bool1 = true;
final bool2 = false;

final uri1 = Uri.parse('http://example.com/1');
final uri2 = Uri.parse('http://example.com/2');

final duration1 = Duration(hours: 1);
final duration2 = Duration(hours: 2);

final audio1 = Audio(uri1, maxDuration: duration1);
final image1 = Image(uri1, maxDuration: duration1);
final video1 = Video(uri1, maxDuration: duration1);

final audibleList1a1v1 = <Audible>[audio1, video1];
final audibleList2a1 = <Audible>[audio1];

final visualizableList1i1v1 = <Visualizable>[image1, video1];
final visualizableList2v1 = <Visualizable>[video1];

final audibleTrack1 = AudibleMultiMediumTrack(audibleList1a1v1);
final audibleTrack2 = AudibleMultiMediumTrack(audibleList2a1);

final visualizableTrack1 = VisualizableMultiMediumTrack(visualizableList1i1v1);
final visualizableTrack2 = VisualizableMultiMediumTrack(visualizableList2v1);

final audibleBgTrack1 = AudibleBackgroundMultiMediumTrack(
  audibleList1a1v1,
  loop: bool1,
);
final audibleBgTrack2 = AudibleBackgroundMultiMediumTrack(
  audibleList2a1,
  loop: bool2,
);

final visualizableBgTrack1 =
    VisualizableBackgroundMultiMediumTrack(visualizableList1i1v1, loop: bool1);
final visualizableBgTrack2 =
    VisualizableBackgroundMultiMediumTrack(visualizableList2v1, loop: bool2);

final multiMedium1a1 = MultiMedium(
  audibleTrack1,
  maxDuration: duration1,
);
final multiMedium2v1 = MultiMedium(
  visualizableTrack1,
  maxDuration: duration1,
);
final multiMedium3a1v1 = MultiMedium(
  audibleTrack1,
  backgroundTrack: visualizableBgTrack1,
  maxDuration: duration1,
);
final multiMedium4v1a2 = MultiMedium(
  visualizableTrack1,
  backgroundTrack: audibleBgTrack2,
  maxDuration: duration1,
);
final multiMedium5a2 = MultiMedium(
  audibleTrack2,
  maxDuration: duration1,
);
final multiMedium6v2 = MultiMedium(
  visualizableTrack2,
  maxDuration: duration1,
);
final multiMedium7a2v2 = MultiMedium(
  audibleTrack2,
  backgroundTrack: visualizableBgTrack2,
  maxDuration: duration1,
);
final multiMedium8v2a1 = MultiMedium(
  visualizableTrack2,
  backgroundTrack: audibleBgTrack1,
  maxDuration: duration1,
);

final mediumList1 = <Medium>[
  multiMedium1a1,
  multiMedium2v1,
  multiMedium3a1v1,
  multiMedium4v1a2,
];
final mediumList2 = <Medium>[
  multiMedium5a2,
  multiMedium6v2,
  multiMedium7a2v2,
  multiMedium8v2a1,
];

final playList1 = PlayList(
  mediumList1,
  config: inheritableConfig1o1r1,
);
