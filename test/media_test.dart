import 'package:test/test.dart';

import 'package:lunofono_bundle/lunofono_bundle.dart';

import 'config/data.dart';
import 'media/constructor.dart';
import 'media/copy_with.dart';
import 'media/data.dart';
import 'media/equality.dart';
import 'media/to_string.dart';

void main() {
  group('Constructing', () {
    testConstructors();
  });
  group('Equality for', () {
    testEquality();
  });
  group('copyWith() for', () {
    testCopyWith();
  });
  group('toString() for', () {
    testToString();
  });
}

void testConstructors() {
  // UnlimitedDuration
  testConstructorUnlimitedDuration();

  // SingleMedium
  testConstructorSingleMedium<Audio>(
    uri1,
    duration1,
  );
  testConstructorSingleMedium<Image>(
    uri2,
    duration2,
  );
  testConstructorSingleMedium<Video>(
    uri1,
    duration2,
  );

  // MultiMediumTrack
  testConstructorMultiMediumTrack<AudibleMultiMediumTrack, Audible>(
    audibleList1a1v1,
  );
  testConstructorMultiMediumTrack<AudibleMultiMediumTrack, Audible>(
    audibleList2a1,
  );
  testConstructorMultiMediumTrack<VisualizableMultiMediumTrack, Visualizable>(
    visualizableList1i1v1,
  );
  testConstructorMultiMediumTrack<VisualizableMultiMediumTrack, Visualizable>(
    visualizableList2v1,
  );

  // BackgroundMultiMediumTrack
  testConstructorBackgroundMultiMediumTrack<AudibleBackgroundMultiMediumTrack,
      Audible>(
    audibleList1a1v1,
  );
  testConstructorBackgroundMultiMediumTrack<AudibleBackgroundMultiMediumTrack,
      Audible>(
    audibleList2a1,
  );
  testConstructorBackgroundMultiMediumTrack<
      VisualizableBackgroundMultiMediumTrack, Visualizable>(
    visualizableList1i1v1,
  );
  testConstructorBackgroundMultiMediumTrack<
      VisualizableBackgroundMultiMediumTrack, Visualizable>(
    visualizableList2v1,
  );

  // NoTrack
  testConstructorNoTrack();

  // MultiMedium
  testConstructorMultiMedium(
    audibleTrack1,
    visualizableBgTrack1,
    duration1,
  );
  testConstructorMultiMedium(
    visualizableTrack1,
    audibleBgTrack1,
    duration1,
  );
  testConstructorMultiMediumFromSingleMedium(audio1);
  testConstructorMultiMediumFromSingleMedium(image1);
  testConstructorMultiMediumFromSingleMedium(video1);
  group('MultiMedium', () {
    group('asserts when', () {
      test('mainTrack, backgroundTrack are both Audible', () {
        expect(
            () => MultiMedium(audibleTrack1, backgroundTrack: audibleBgTrack1),
            throwsA(isA<AssertionError>()));
      });
      test('mainTrack, backgroundTrack are both Visualizable', () {
        expect(
            () => MultiMedium(visualizableTrack1,
                backgroundTrack: visualizableBgTrack1),
            throwsA(isA<AssertionError>()));
      });
    });
  });

  // PlayList
  testConstructorPlayList(
    mediumList1,
    inheritableConfig1o1r1,
  );
}

void testEquality() {
  // SingleMedium
  testEqualitySingleMedium<Audio>(uri1, duration1, uri2, duration2);
  testEqualitySingleMedium<Image>(uri1, duration1, uri2, duration2);
  testEqualitySingleMedium<Video>(uri1, duration1, uri2, duration2);

  // MultiMediumTrack
  testEqualityMultiMediumTrack<AudibleMultiMediumTrack, Audible>(
      audibleList1a1v1, audibleList2a1);
  testEqualityMultiMediumTrack<VisualizableMultiMediumTrack, Visualizable>(
      visualizableList1i1v1, visualizableList2v1);

  // MultiMediumTrack
  testEqualityBackgroundMultiMediumTrack<AudibleBackgroundMultiMediumTrack,
      Audible>(audibleList1a1v1, audibleList2a1);
  testEqualityBackgroundMultiMediumTrack<VisualizableBackgroundMultiMediumTrack,
      Visualizable>(visualizableList1i1v1, visualizableList2v1);

  // MultiMedium
  testEqualityMultiMedium(
    audibleTrack1,
    visualizableBgTrack1,
    duration1,
    audibleTrack2,
    visualizableBgTrack2,
    duration2,
  );

  // PlayList TODO
  testEqualityPlayList(
    mediumList1,
    inheritableConfig1o1r1,
    mediumList2,
    inheritableConfig2o2r2,
  );
}

void testCopyWith() {
  // SingleMedium
  testCopyWithSingleMedium(
    original: audio1,
    newResource: uri2,
    newMaxDuration: duration2,
  );
  testCopyWithSingleMedium(
    original: image1,
    newResource: uri2,
    newMaxDuration: duration2,
  );
  testCopyWithSingleMedium(
    original: video1,
    newResource: uri2,
    newMaxDuration: duration2,
  );

  // MultiMediumTrack
  testCopyWithMultiMediumTrack<Audible>(
    original: audibleTrack1,
    newMedia: audibleList2a1,
  );
  testCopyWithMultiMediumTrack<Visualizable>(
    original: visualizableTrack1,
    newMedia: visualizableList2v1,
  );

  // BackgroundMultiMediumTrack
  testCopyWithBackgroundMultiMediumTrack<Audible>(
    original: audibleBgTrack1,
    newMedia: audibleList2a1,
    newIsLooping: bool2,
  );
  testCopyWithBackgroundMultiMediumTrack<Visualizable>(
    original: visualizableBgTrack1,
    newMedia: visualizableList2v1,
    newIsLooping: bool2,
  );

  // MultiMedium
  testCopyWithMultiMedium(
    original: multiMedium1a1,
    newMainTrack: audibleTrack2,
    newBackgroundTrack: visualizableBgTrack1,
    newIsSyncingTracks: bool2,
    newMaxDuration: duration2,
    description: 'main: audio back: none -> main: audio, back: visual',
  );
  testCopyWithMultiMedium(
    original: multiMedium2v1,
    newMainTrack: visualizableTrack2,
    newBackgroundTrack: audibleBgTrack1,
    newIsSyncingTracks: bool2,
    newMaxDuration: duration2,
    description: 'main: visual back: none -> main: visual, back: audio',
  );
  testCopyWithMultiMedium(
    original: multiMedium3a1v1,
    newMainTrack: audibleTrack2,
    newBackgroundTrack: visualizableBgTrack2,
    newIsSyncingTracks: bool2,
    newMaxDuration: duration2,
    description: 'main: audio back: visual -> main: audio, back: visual',
  );
  testCopyWithMultiMedium(
    original: multiMedium4v1a2,
    newMainTrack: visualizableTrack2,
    newBackgroundTrack: audibleBgTrack1,
    newIsSyncingTracks: bool2,
    newMaxDuration: duration2,
    description: 'main: visual back: audio -> main: visual, back: audio',
  );
  testCopyWithMultiMedium(
    original: multiMedium3a1v1,
    newMainTrack: audibleTrack2,
    newBackgroundTrack: const NoTrack(),
    newIsSyncingTracks: bool2,
    newMaxDuration: duration2,
    description: 'main: audio back: visual -> main: audio, back: none',
  );
  group('MultiMedium', () {
    group('asserts when', () {
      test('mainTrack and backgroundTrack are both Audible', () {
        expect(() => multiMedium1a1.copyWith(backgroundTrack: audibleBgTrack1),
            throwsA(isA<AssertionError>()));
      });
      test('mainTrack and backgroundTrack are both Visualizable', () {
        expect(
          () => multiMedium2v1.copyWith(backgroundTrack: visualizableBgTrack1),
          throwsA(isA<AssertionError>()),
        );
      });
    });
  });

  // PlayList
  testCopyWithPlayList(
    original: playList1,
    newMedia: mediumList2,
    newConfig: inheritableConfig2o2r2,
  );
}
