import 'package:test/test.dart';

import 'package:lunofono_bundle/lunofono_bundle.dart';

void testCopyWithSingleMedium({
  required dynamic original,
  Uri? newResource,
  Duration? newMaxDuration,
}) {
  assert(original is SingleMedium);
  group('${original.runtimeType} success when', () {
    final originalResource = original.resource as Uri?;
    final originalMaxDuration = original.maxDuration as Duration?;

    void expectUnchangedOriginalNotSame(dynamic copy) {
      expect(copy, isNot(same(original)));
      expect(original.resource, equals(originalResource));
      expect(original.maxDuration, equals(originalMaxDuration));
    }

    test('no arguments', () {
      final copy = original.copyWith() as SingleMedium?;
      expectUnchangedOriginalNotSame(copy);
      // should make an exact copy
      expect(copy, equals(original));
    });

    test('resource: $newResource', () {
      final copy = original.copyWith(resource: newResource) as SingleMedium;
      expectUnchangedOriginalNotSame(copy);
      // should not touch other members
      expect(copy.maxDuration, equals(original.maxDuration));
      // should update copy's resource
      expect(copy.resource, equals(newResource));
    });

    test('maxDuration: $newMaxDuration', () {
      final copy =
          original.copyWith(maxDuration: newMaxDuration) as SingleMedium;
      expectUnchangedOriginalNotSame(copy);
      // should not touch other members
      expect(copy.resource, equals(original.resource));
      // should update copy's resource
      expect(copy.maxDuration, equals(newMaxDuration));
    });

    test('resource: $newResource, maxDuration: $newMaxDuration', () {
      final copy = original.copyWith(
        resource: newResource,
        maxDuration: newMaxDuration,
      ) as SingleMedium;
      expectUnchangedOriginalNotSame(copy);
      // should update copy's resource
      expect(copy.resource, equals(newResource));
      expect(copy.maxDuration, equals(newMaxDuration));
    });
  });
}

void testCopyWithMultiMediumTrack<P extends Playable>({
  required dynamic
      original, // dynamic because MultiMediumTrack has no copyWith method
  List<P>? newMedia,
}) {
  assert(original is MultiMediumTrack);
  group('${original.runtimeType}', () {
    group('success when', () {
      final originalMedia = original.media as List<SingleMedium>?;

      void expectUnchangedOriginalNotSame(dynamic copy) {
        expect(copy, isNot(same(original)));
        expect(original.media, equals(originalMedia));
      }

      test('no arguments', () {
        final copy = original.copyWith() as MultiMediumTrack?;
        expectUnchangedOriginalNotSame(copy);
        // should make an exact copy
        expect(copy, equals(original));
      });

      test('media: $newMedia', () {
        final copy = original.copyWith(media: newMedia) as MultiMediumTrack;
        expectUnchangedOriginalNotSame(copy);
        // should update copy's media
        expect(copy.media, equals(newMedia));
      });
    });

    group('asserts when', () {
      test('media has no elements', () {
        expect(() => original.copyWith(media: <P>[]),
            throwsA(isA<AssertionError>()));
      });
    });
  });
}

void testCopyWithBackgroundMultiMediumTrack<P extends Playable>({
  // dynamic because BackgroundMultiMediumTrack has no copyWith method
  required dynamic original,
  List<P>? newMedia,
  bool? newIsLooping,
}) {
  assert(original is BackgroundMultiMediumTrack);
  group('${original.runtimeType}', () {
    group('success when', () {
      final originalMedia = original.media as List<SingleMedium>?;
      final originalIsLooping = original.isLooping as bool?;

      void expectUnchangedOriginalNotSame(dynamic copy) {
        expect(copy, isNot(same(original)));
        expect(original.media, equals(originalMedia));
        expect(original.isLooping, equals(originalIsLooping));
      }

      test('no arguments', () {
        final copy = original.copyWith() as BackgroundMultiMediumTrack?;
        expectUnchangedOriginalNotSame(copy);
        // should make an exact copy
        expect(copy, equals(original));
      });

      test('media: $newMedia', () {
        final copy =
            original.copyWith(media: newMedia) as BackgroundMultiMediumTrack;
        expectUnchangedOriginalNotSame(copy);
        // should not touch other members
        expect(copy.isLooping, equals(original.isLooping));
        // should update copy's media
        expect(copy.media, equals(newMedia));
      });

      test('isLooping: $newIsLooping', () {
        final copy = original.copyWith(isLooping: newIsLooping)
            as BackgroundMultiMediumTrack;
        expectUnchangedOriginalNotSame(copy);
        // should not touch other members
        expect(copy.media, equals(original.media));
        // should update copy's media
        expect(copy.isLooping, equals(newIsLooping));
      });

      test('media: $newMedia, isLooping: $newIsLooping', () {
        final copy = original.copyWith(
          media: newMedia,
          isLooping: newIsLooping,
        ) as BackgroundMultiMediumTrack;
        expectUnchangedOriginalNotSame(copy);
        // should update copy's media
        expect(copy.media, equals(newMedia));
        expect(copy.isLooping, equals(newIsLooping));
      });
    });

    group('asserts when', () {
      test('media has no elements', () {
        expect(() => original.copyWith(media: <P>[]),
            throwsA(isA<AssertionError>()));
      });
    });
  });
}

void testCopyWithMultiMedium<T1 extends MultiMediumTrack,
    T2 extends BackgroundMultiMediumTrack>({
  MultiMedium? original,
  T1? newMainTrack,
  T2? newBackgroundTrack,
  bool? newIsSyncingTracks,
  Duration? newMaxDuration,
  String? description,
}) {
  final desc = description == null ? '' : ' ($description)';
  group('${original.runtimeType}$desc', () {
    group('success when', () {
      final originalMainTrack = original!.mainTrack;
      final originalBackgroundTrack = original.backgroundTrack;
      final originalMaxDuration = original.maxDuration;

      void expectUnchangedOriginalNotSame(dynamic copy) {
        expect(copy, isNot(same(original)));
        expect(original.mainTrack, equals(originalMainTrack));
        expect(original.backgroundTrack, equals(originalBackgroundTrack));
        expect(original.maxDuration, equals(originalMaxDuration));
      }

      test('no arguments', () {
        final copy = original.copyWith();
        expectUnchangedOriginalNotSame(copy);
        // should make an exact copy
        expect(copy, equals(original));
      });

      test('mainTrack: $newMainTrack', () {
        final copy = original.copyWith(mainTrack: newMainTrack);
        expectUnchangedOriginalNotSame(copy);
        // should not touch other members
        expect(copy.backgroundTrack, equals(original.backgroundTrack));
        expect(copy.maxDuration, equals(original.maxDuration));
        // should update copy's mainTrack
        expect(copy.mainTrack, equals(newMainTrack));
      });

      test('backgroundTrack: $newBackgroundTrack', () {
        final copy = original.copyWith(backgroundTrack: newBackgroundTrack);
        expectUnchangedOriginalNotSame(copy);
        // should not touch other members
        expect(copy.mainTrack, equals(original.mainTrack));
        expect(copy.maxDuration, equals(original.maxDuration));
        // should update copy's mainTrack
        expect(copy.backgroundTrack, equals(newBackgroundTrack));
      });

      test('maxDuration: $newMaxDuration', () {
        final copy = original.copyWith(maxDuration: newMaxDuration);
        expectUnchangedOriginalNotSame(copy);
        // should not touch other members
        expect(copy.mainTrack, equals(original.mainTrack));
        expect(copy.backgroundTrack, equals(original.backgroundTrack));
        // should update copy's mainTrack
        expect(copy.maxDuration, equals(newMaxDuration));
      });

      test(
          'mainTrack: $newMainTrack, '
          'backgroundTrack: $newBackgroundTrack', () {
        final copy = original.copyWith(
          mainTrack: newMainTrack,
          backgroundTrack: newBackgroundTrack,
        );
        expectUnchangedOriginalNotSame(copy);
        // should update copy
        expect(copy.mainTrack, equals(newMainTrack));
        expect(copy.backgroundTrack, equals(newBackgroundTrack));
      });

      test(
          'mainTrack: $newMainTrack, '
          'backgroundTrack: $newBackgroundTrack, '
          'maxDuration: $newMaxDuration', () {
        final copy = original.copyWith(
          mainTrack: newMainTrack,
          backgroundTrack: newBackgroundTrack,
          maxDuration: newMaxDuration,
        );
        expectUnchangedOriginalNotSame(copy);
        // should update copy
        expect(copy.mainTrack, equals(newMainTrack));
        expect(copy.backgroundTrack, equals(newBackgroundTrack));
        expect(copy.maxDuration, equals(newMaxDuration));
      });
    });

    group('asserts when', () {
      test('mainTrack is NoTrack', () {
        expect(() => original!.copyWith(mainTrack: const NoTrack()),
            throwsA(isA<AssertionError>()));
      });
      test('mainTrack is BackgroundMultiMediumTrack', () {
        expect(() => original!.copyWith(mainTrack: newBackgroundTrack),
            throwsA(isA<AssertionError>()));
      });
    });
  });
}

void testCopyWithPlayList({
  Playlist? original,
  List<Medium>? newMedia,
  InheritableConfig? newConfig,
}) {
  group('${original.runtimeType}', () {
    group('success when', () {
      final originalMedia = original!.media;
      final originalConfig = original.config;

      void expectUnchangedOriginalNotSame(dynamic copy) {
        expect(copy, isNot(same(original)));
        expect(original.media, equals(originalMedia));
        expect(original.config, equals(originalConfig));
      }

      test('no arguments', () {
        final copy = original.copyWith();
        expectUnchangedOriginalNotSame(copy);
        // should make an exact copy
        expect(copy, equals(original));
      });

      test('media: $newMedia', () {
        final copy = original.copyWith(media: newMedia);
        expectUnchangedOriginalNotSame(copy);
        // should not touch other members
        expect(copy.config, equals(original.config));
        // should update copy's media
        expect(copy.media, equals(newMedia));
      });

      test('config: $newConfig', () {
        final copy = original.copyWith(config: newConfig);
        expectUnchangedOriginalNotSame(copy);
        // should not touch other members
        expect(copy.media, equals(original.media));
        // should update copy's media
        expect(copy.config, equals(newConfig));
      });

      test('media: $newMedia, config: $newConfig', () {
        final copy = original.copyWith(
          media: newMedia,
          config: newConfig,
        );
        expectUnchangedOriginalNotSame(copy);
        // should update copy's media
        expect(copy.media, equals(newMedia));
        expect(copy.config, equals(newConfig));
      });
    });

    group('asserts when', () {
      test('media has no elements', () {
        expect(() => original!.copyWith(media: <Medium>[]),
            throwsA(isA<AssertionError>()));
      });
    });
  });
}
