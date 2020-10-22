import 'package:test/test.dart';

import 'package:lunofono_bundle/lunofono_bundle.dart';

void testEqualitySingleMedium<T extends SingleMedium>(
  Uri resource,
  Duration maxDuration,
  Uri otherResource,
  Duration otherMaxDuration,
) {
  dynamic constructor(
    Uri resource, {
    Duration maxDuration,
  }) {
    if (T == Audio) {
      return Audio(resource, maxDuration: maxDuration);
    } else if (T == Image) {
      return Image(resource, maxDuration: maxDuration);
    } else if (T == Video) {
      return Video(resource, maxDuration: maxDuration);
    } else {
      assert(false);
    }
  }

  group('$T', () {
    group('==', () {
      test('resource', () {
        expect(constructor(resource), equals(constructor(resource)));
      });

      test('resource, maxDuration', () {
        final original =
            constructor(resource, maxDuration: maxDuration) as SingleMedium;
        final clone =
            constructor(resource, maxDuration: maxDuration) as SingleMedium;
        expect(original, equals(clone));
      });
    });

    group('!=', () {
      test('resource', () {
        final original = constructor(resource) as SingleMedium;
        final other = constructor(otherResource) as SingleMedium;
        expect(original, isNot(equals(other)));
      });

      test('maxDuration', () {
        final original =
            constructor(resource, maxDuration: maxDuration) as SingleMedium;
        final other = constructor(resource, maxDuration: otherMaxDuration)
            as SingleMedium;
        expect(original, isNot(equals(other)));
      });

      test('resource, maxDuration', () {
        final original =
            constructor(resource, maxDuration: maxDuration) as SingleMedium;
        final other = constructor(otherResource, maxDuration: otherMaxDuration)
            as SingleMedium;
        expect(original, isNot(equals(other)));
      });
    });
  });
}

void testEqualityMultiMediumTrack<T extends MultiMediumTrack,
    P extends Playable>(
  List<P> media,
  List<P> otherMedia,
) {
  dynamic constructor(List<P> media) {
    if (P == Audible) {
      return AudibleMultiMediumTrack(
          media == null ? null : List<Audible>.from(media));
    } else if (P == Visualizable) {
      return VisualizableMultiMediumTrack(
          media == null ? null : List<Visualizable>.from(media));
    } else {
      assert(false);
    }
  }

  group('$T', () {
    group('==', () {
      test('media', () {
        expect(constructor(media), equals(constructor(media)));
      });
    });

    group('!=', () {
      test('media', () {
        final original = constructor(media) as MultiMediumTrack;
        final other = constructor(otherMedia) as MultiMediumTrack;
        expect(original, isNot(equals(other)));
      });
    });
  });
}

void testEqualityBackgroundMultiMediumTrack<
    T extends BackgroundMultiMediumTrack, P extends Playable>(
  List<P> media,
  List<P> otherMedia,
) {
  dynamic constructor(
    List<P> media, {
    bool loop,
  }) {
    if (P == Audible) {
      return AudibleBackgroundMultiMediumTrack(
          media == null ? null : List<Audible>.from(media),
          loop: loop);
    } else if (P == Visualizable) {
      return VisualizableBackgroundMultiMediumTrack(
          media == null ? null : List<Visualizable>.from(media),
          loop: loop);
    } else {
      assert(false);
    }
  }

  group('$T', () {
    group('==', () {
      test('media', () {
        expect(constructor(media), equals(constructor(media)));
      });

      test('media, loop', () {
        final original =
            constructor(media, loop: true) as BackgroundMultiMediumTrack;
        final clone =
            constructor(media, loop: true) as BackgroundMultiMediumTrack;
        expect(original, equals(clone));
      });
    });

    group('!=', () {
      test('media', () {
        final original = constructor(media) as BackgroundMultiMediumTrack;
        final other = constructor(otherMedia) as BackgroundMultiMediumTrack;
        expect(original, isNot(equals(other)));
      });

      test('loop', () {
        final original =
            constructor(media, loop: true) as BackgroundMultiMediumTrack;
        final other =
            constructor(media, loop: false) as BackgroundMultiMediumTrack;
        expect(original, isNot(equals(other)));
      });

      test('media, loop', () {
        final original =
            constructor(media, loop: true) as BackgroundMultiMediumTrack;
        final other =
            constructor(otherMedia, loop: false) as BackgroundMultiMediumTrack;
        expect(original, isNot(equals(other)));
      });
    });
  });
}

void testEqualityMultiMedium(
  MultiMediumTrack mainTrack,
  BackgroundMultiMediumTrack backgroundTrack,
  Duration maxDuration,
  MultiMediumTrack otherMainTrack,
  BackgroundMultiMediumTrack otherBackgroundTrack,
  Duration otherMaxDuration,
) {
  group('MultiMedium', () {
    group('==', () {
      test('mainTrack', () {
        expect(MultiMedium(mainTrack), equals(MultiMedium(mainTrack)));
      });

      test('mainTrack, backgroundTrack', () {
        final original = MultiMedium(
          mainTrack,
          backgroundTrack: backgroundTrack,
        );
        final clone = MultiMedium(
          mainTrack,
          backgroundTrack: backgroundTrack,
        );
        expect(original, equals(clone));
      });

      test('mainTrack, maxDuration', () {
        final original = MultiMedium(
          mainTrack,
          maxDuration: maxDuration,
        );
        final clone = MultiMedium(
          mainTrack,
          maxDuration: maxDuration,
        );
        expect(original, equals(clone));
      });
    });

    group('!=', () {
      test('mainTrack', () {
        final original = MultiMedium(mainTrack);
        final other = MultiMedium(otherMainTrack);
        expect(original, isNot(equals(other)));
      });

      test('backgroundTrack', () {
        final original = MultiMedium(
          mainTrack,
          backgroundTrack: backgroundTrack,
        );
        final other = MultiMedium(
          mainTrack,
          backgroundTrack: otherBackgroundTrack,
        );
        expect(original, isNot(equals(other)));
      });

      test('maxDuration', () {
        final original = MultiMedium(
          mainTrack,
          maxDuration: maxDuration,
        );
        final other = MultiMedium(
          mainTrack,
          maxDuration: otherMaxDuration,
        );
        expect(original, isNot(equals(other)));
      });

      test('mainTrack, backgroundTrack, maxDuration', () {
        final original = MultiMedium(
          mainTrack,
          backgroundTrack: backgroundTrack,
          maxDuration: maxDuration,
        );
        final other = MultiMedium(
          otherMainTrack,
          backgroundTrack: otherBackgroundTrack,
          maxDuration: otherMaxDuration,
        );
        expect(original, isNot(equals(other)));
      });
    });
  });
}

void testEqualityPlayList(
  List<Medium> media,
  InheritableConfig config,
  List<Medium> otherMedia,
  InheritableConfig otherConfig,
) {
  group('PlayList', () {
    group('==', () {
      test('media', () {
        expect(PlayList(media), equals(PlayList(media)));
      });

      test('media, config', () {
        final original = PlayList(media, config: config);
        final clone = PlayList(media, config: config);
        expect(original, equals(clone));
      });
    });

    group('!=', () {
      test('media', () {
        final original = PlayList(media);
        final other = PlayList(otherMedia);
        expect(original, isNot(equals(other)));
      });

      test('config', () {
        final original = PlayList(media, config: config);
        final other = PlayList(media, config: otherConfig);
        expect(original, isNot(equals(other)));
      });
    });
  });
}
