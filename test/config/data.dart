import 'package:lunofono_bundle/lunofono_bundle.dart';

final orientation1 = Orientation.landscape;
final orientation2 = Orientation.automatic;

final reactions1TapPrevious = <Trigger, Reaction>{
  Trigger.tap: Reaction.previous,
};
final reactions2TapNext = <Trigger, Reaction>{
  Trigger.tap: Reaction.next,
};

final inheritableConfig1o1r1 = InheritableConfig(
  orientation: orientation1,
  reactions: reactions1TapPrevious,
);
final inheritableConfig2o2r2 = InheritableConfig(
  orientation: orientation2,
  reactions: reactions2TapNext,
);
