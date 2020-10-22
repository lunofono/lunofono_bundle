import 'package:test/test.dart';

import 'package:lunofono_bundle/lunofono_bundle.dart';

import 'config/data.dart';

void main() {
  group('Reactions', () {
    for (final value in Trigger.values) {
      test('inheritedReactions is complete', () {
        expect(inheritedReactions[value], equals(Reaction.inherited),
            reason: '     Key: $value');
      });
    }
    test('noReactions is just an empty map', () {
      expect(noReactions, equals(<Trigger, Reaction>{}));
      expect(noReactions, equals(const <Trigger, Reaction>{}));
    });
  });

  group('InheritableConfig', () {
    testInheritableConfig(
      orientation1,
      reactions1TapPrevious,
      orientation2,
      reactions2TapNext,
    );

    test('toString()', () {
      final config = InheritableConfig(
        reactions: <Trigger, Reaction>{Trigger.tap: Reaction.next},
        orientation: Orientation.landscape,
      );
      expect(
          config.toString(),
          'InheritableConfig(reactions: {Trigger.tap: Reaction.next}, '
          'orientation: Orientation.landscape)');
    });
  });
}

void testInheritableConfig(
  Orientation orientation,
  Map<Trigger, Reaction> reactions,
  Orientation newOrientation,
  Map<Trigger, Reaction> newReactions,
) {
  group('Constructing', () {
    group('success when', () {
      test('[defaults]', () {
        final config = InheritableConfig();
        expect(config.orientation, equals(Orientation.inherited));
        expect(config.reactions, equals(inheritedReactions));
      });

      test('orientation', () {
        final config = InheritableConfig(orientation: orientation);
        expect(config.orientation, equals(orientation));
        expect(config.reactions, equals(inheritedReactions));
      });

      test('reactions', () {
        final config = InheritableConfig(reactions: reactions);
        expect(config.orientation, equals(Orientation.inherited));
        expect(config.reactions, equals(reactions));
      });

      test('orientation, reactions', () {
        final config = InheritableConfig(
          orientation: orientation,
          reactions: reactions,
        );
        expect(config.orientation, equals(orientation));
        expect(config.reactions, equals(reactions));
      });
    });
  });

  group('equality', () {
    group('success when', () {
      test('no arguments', () {
        expect(InheritableConfig(), equals(InheritableConfig()));
      });

      test('orientation', () {
        final original = InheritableConfig(orientation: orientation);
        final copy = InheritableConfig(orientation: orientation);
        expect(copy, equals(original));
      });

      test('reactions', () {
        final original = InheritableConfig(reactions: reactions);
        final copy = InheritableConfig(reactions: reactions);
        expect(copy, equals(original));
      });

      test('orientation, reactions', () {
        final original = InheritableConfig(
          orientation: orientation,
          reactions: reactions,
        );
        final copy = InheritableConfig(
          orientation: orientation,
          reactions: reactions,
        );
        expect(copy, equals(original));
      });
    });
  });

  group('inequality', () {
    group('success when', () {
      test('orientation', () {
        final original = InheritableConfig(orientation: orientation);
        final copy = InheritableConfig(orientation: newOrientation);
        expect(copy, isNot(equals(original)));
      });

      test('reactions', () {
        final original = InheritableConfig(reactions: reactions);
        final copy = InheritableConfig(reactions: newReactions);
        expect(copy, isNot(equals(original)));
      });

      test('orientation, reactions', () {
        final original = InheritableConfig(
          orientation: orientation,
          reactions: reactions,
        );
        final copy = InheritableConfig(
          orientation: newOrientation,
          reactions: newReactions,
        );
        expect(copy, isNot(equals(original)));
      });
    });
  });

  group('copyWith()', () {
    final original = InheritableConfig(
      orientation: orientation,
      reactions: reactions,
    );
    group('success when', () {
      void expectUnchangedOriginalNotSame(InheritableConfig copy) {
        expect(copy, isNot(same(original)));
        expect(original.orientation, equals(orientation));
        expect(original.reactions, equals(reactions));
      }

      test('no arguments', () {
        final copy = original.copyWith();
        expectUnchangedOriginalNotSame(copy);
        // should make an exact copy
        expect(copy, equals(original));
      });

      test('orientation: $newOrientation', () {
        final copy = original.copyWith(orientation: newOrientation);
        expectUnchangedOriginalNotSame(copy);
        // should not touch other members
        expect(copy.reactions, equals(original.reactions));
        // should update copy's orientation
        expect(copy.orientation, equals(newOrientation));
      });

      test('orientation: $newOrientation, reactions: null', () {
        final copy = original.copyWith(
          orientation: newOrientation,
          reactions: null,
        );
        expectUnchangedOriginalNotSame(copy);
        // should not touch other members
        expect(copy.reactions, equals(original.reactions));
        // should update copy's orientation
        expect(copy.orientation, equals(newOrientation));
      });

      test('reactions: $newReactions', () {
        final copy = original.copyWith(reactions: newReactions);
        expectUnchangedOriginalNotSame(copy);
        // should not touch other members
        expect(copy.orientation, equals(original.orientation));
        // should update copy's orientation
        expect(copy.reactions, equals(newReactions));
      });

      test('orientation: null, reactions: $newReactions', () {
        final copy = original.copyWith(
          orientation: null,
          reactions: newReactions,
        );
        expectUnchangedOriginalNotSame(copy);
        // should not touch other members
        expect(copy.orientation, equals(original.orientation));
        // should update copy's orientation
        expect(copy.reactions, equals(newReactions));
      });

      test('orientation: $newOrientation, reactions: $newReactions', () {
        final copy = original.copyWith(
          orientation: newOrientation,
          reactions: newReactions,
        );
        expectUnchangedOriginalNotSame(copy);
        // should update copy's orientation and reactions
        expect(copy.orientation, equals(newOrientation));
        expect(copy.reactions, equals(newReactions));
      });
    });
  });
}
