import 'package:test/test.dart';

import 'package:lunofono_bundle/lunofono_bundle.dart';

const _noTrack = NoTrack();

void testConstructorUnlimitedDuration() {
  group('UnlimitedDuration', () {
    test('exists and is a Duration', () {
      expect(UnlimitedDuration(), isA<Duration>());
      expect(const UnlimitedDuration(), isA<Duration>());
    });
    test('It is a BIG duration', () {
      expect(const UnlimitedDuration().inDays, greaterThanOrEqualTo(365));
    });
    test('Different instances are equal and have the same hashCode', () {
      final unlimitedDuration1 = UnlimitedDuration();
      final unlimitedDuration2 = UnlimitedDuration();
      expect(unlimitedDuration1, unlimitedDuration2);
      expect(unlimitedDuration1.hashCode, unlimitedDuration2.hashCode);
    });
  });
}

void testConstructorSingleMedium<T extends SingleMedium>(
  Uri resource,
  Duration maxDuration,
) {
  Object? constructor(
    Uri resource, {
    Duration maxDuration = const UnlimitedDuration(),
  }) {
    if (T == Audio) {
      return Audio(resource, maxDuration: maxDuration);
    } else if (T == Image) {
      return Image(resource, maxDuration: maxDuration);
    } else if (T == Video) {
      return Video(resource, maxDuration: maxDuration);
    } else {
      assert(false);
      return null;
    }
  }

  const unlimitedDuration = UnlimitedDuration();

  group('$T', () {
    group('success when', () {
      test('resource [defaults]', () {
        final medium = constructor(resource) as T;
        expect(medium.resource, equals(resource));
        expect(medium.maxDuration, equals(unlimitedDuration));
      });
      test('resource, [explicit defaults]', () {
        final medium =
            constructor(resource, maxDuration: unlimitedDuration) as T;
        expect(medium.resource, equals(resource));
        expect(medium.maxDuration, equals(unlimitedDuration));
      });
      test('resource, maxDuration', () {
        final medium = constructor(resource, maxDuration: maxDuration) as T;
        expect(medium.resource, equals(resource));
        expect(medium.maxDuration, equals(maxDuration));
      });
      test('resource, unlimited', () {
        final medium =
            constructor(resource, maxDuration: unlimitedDuration) as T;
        expect(medium.resource, equals(resource));
        expect(medium.maxDuration, equals(unlimitedDuration));
      });
    });
  });
}

void testConstructorMultiMediumTrack<T extends MultiMediumTrack,
    P extends Playable>(
  List<P> media,
) {
  Object? constructor(List<P> media) {
    if (P == Audible) {
      return AudibleMultiMediumTrack(List<Audible>.from(media));
    } else if (P == Visualizable) {
      return VisualizableMultiMediumTrack(List<Visualizable>.from(media));
    } else {
      assert(false);
      return null;
    }
  }

  group('$T', () {
    group('success when', () {
      test('media', () {
        final track = constructor(media) as T;
        expect(track.media, equals(media));
      });
    });

    group('assert when', () {
      test('<$P>[]', () {
        expect(() => constructor(<P>[]), throwsA(isA<AssertionError>()));
      });
    });
  });
}

void testConstructorBackgroundMultiMediumTrack<
    T extends BackgroundMultiMediumTrack, P extends Playable>(
  List<P> media,
) {
  Object? constructor(
    List<P> media, {
    bool loop = false,
  }) {
    if (P == Audible) {
      return AudibleBackgroundMultiMediumTrack(List<Audible>.from(media),
          loop: loop);
    } else if (P == Visualizable) {
      return VisualizableBackgroundMultiMediumTrack(
          List<Visualizable>.from(media),
          loop: loop);
    } else {
      assert(false);
      return null;
    }
  }

  group('$T', () {
    group('success when', () {
      test('media [defaults]', () {
        final track = constructor(media) as T;
        expect(track.media, equals(media));
        expect(track.isLooping, equals(false));
      });
      test('media, false', () {
        final track = constructor(media, loop: false) as T;
        expect(track.media, equals(media));
        expect(track.isLooping, equals(false));
      });
      test('media, true', () {
        final track = constructor(media, loop: true) as T;
        expect(track.media, equals(media));
        expect(track.isLooping, equals(true));
      });
    });

    group('assert when', () {
      test('<$P>[] [defaults]', () {
        expect(() => constructor(<P>[]), throwsA(isA<AssertionError>()));
      });
    });
  });
}

void testConstructorNoTrack() {
  group('NoTrack', () {
    test('exists and is a BackgroundMultiMediumTrack', () {
      expect(_noTrack, isA<BackgroundMultiMediumTrack>());
    });
    test('Any uses of it throws', () {
      expect(() => _noTrack.media, throwsA(isA<UnimplementedError>()));
      expect(() => _noTrack.isLooping, throwsA(isA<UnimplementedError>()));
    });
    test('Different instances are equal and have the same hashCode', () {
      final noTrack1 = NoTrack();
      final noTrack2 = NoTrack();
      expect(noTrack1, noTrack2);
      expect(noTrack1.hashCode, noTrack2.hashCode);
    });
  });
}

void testConstructorMultiMedium(
  MultiMediumTrack mainTrack,
  BackgroundMultiMediumTrack backgroundTrack,
  Duration maxDuration,
) {
  const unlimitedDuration = UnlimitedDuration();

  group('MultiMedium', () {
    group('success when', () {
      test('mainTrack [defaults]', () {
        final medium = MultiMedium(mainTrack);
        expect(medium.mainTrack, equals(mainTrack));
        expect(medium.backgroundTrack, equals(_noTrack));
        expect(medium.maxDuration, equals(unlimitedDuration));
      });
      test('mainTrack, [explicit defaults]', () {
        final medium = MultiMedium(
          mainTrack,
          backgroundTrack: _noTrack,
          maxDuration: unlimitedDuration,
        );
        expect(medium.mainTrack, equals(mainTrack));
        expect(medium.backgroundTrack, equals(_noTrack));
        expect(medium.maxDuration, equals(unlimitedDuration));
      });
      test('mainTrack, backgroundTrack, maxDuration', () {
        final medium = MultiMedium(
          mainTrack,
          backgroundTrack: backgroundTrack,
          maxDuration: maxDuration,
        );
        expect(medium.mainTrack, equals(mainTrack));
        expect(medium.backgroundTrack, equals(backgroundTrack));
        expect(medium.maxDuration, equals(maxDuration));
      });
    });

    group('assert when', () {
      test('mainTrack is BackgroundMultiMediumTrack', () {
        expect(
            () => MultiMedium(backgroundTrack), throwsA(isA<AssertionError>()));
      });
    });
  });
}

class FakeSingleMedium extends SingleMedium {
  FakeSingleMedium() : super(Uri.parse('test-medium'));
}

void testConstructorMultiMediumFromSingleMedium(SingleMedium medium) {
  group('MultiMedium.fromSingleMedium(medium)', () {
    group('success when', () {
      test('medium is ${medium.runtimeType}', () {
        final mm = MultiMedium.fromSingleMedium(medium);
        expect(mm.mainTrack.media.length, 1);
        expect(mm.mainTrack.media.first, same(medium));
        expect(mm.backgroundTrack, equals(_noTrack));
        expect(mm.maxDuration, equals(medium.maxDuration));
      });
    });

    group('assert when', () {
      test('medium is not Audible or Visualizable', () {
        expect(() => MultiMedium.fromSingleMedium(FakeSingleMedium()),
            throwsA(isA<AssertionError>()));
      });
    });
  });
}

void testConstructorPlayList(
  List<Medium> media,
  InheritableConfig config,
) {
  group('Playlist', () {
    group('success when', () {
      test('media [defaults]', () {
        final playlist = Playlist(media);
        expect(playlist.media, equals(media));
        expect(playlist.config, equals(inheritedConfig));
      });
      test('media, [explicit defaults]', () {
        final playlist = Playlist(
          media,
          config: inheritedConfig,
        );
        expect(playlist.media, equals(media));
        expect(playlist.config, equals(inheritedConfig));
      });
      test('media, config', () {
        final playlist = Playlist(
          media,
          config: config,
        );
        expect(playlist.media, equals(media));
        expect(playlist.config, equals(config));
      });
    });

    group('assert when', () {
      test('[]', () {
        expect(() => Playlist(<Medium>[]), throwsA(isA<AssertionError>()));
      });
    });
  });
}
