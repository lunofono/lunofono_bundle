import 'package:test/test.dart';

import 'package:lunofono_bundle/lunofono_bundle.dart';

class ToStringMixin {
  @override
  String toString() => '$runtimeType';
}

class FakeInheritableConfig extends InheritableConfig with ToStringMixin {}

class FakePlayable extends Playable with ToStringMixin {}

class FakeAudibleMedium extends SingleMedium
    with ToStringMixin
    implements Audible {
  FakeAudibleMedium() : super(Uri.parse('fake-audible'));
}

class FakeVisualizableMedium extends SingleMedium
    with ToStringMixin
    implements Visualizable {
  FakeVisualizableMedium() : super(Uri.parse('fake-visualizable'));
}

class FakeAudibleMultiMediumTrack extends AudibleMultiMediumTrack
    with ToStringMixin {
  FakeAudibleMultiMediumTrack() : super(<Audible>[FakeAudibleMedium()]);
}

class FakeVisualizableMultiMediumTrack extends VisualizableMultiMediumTrack
    with ToStringMixin
    implements Visualizable {
  FakeVisualizableMultiMediumTrack()
      : super(<Visualizable>[FakeVisualizableMedium()]);
}

class FakeAudibleBackgroundMultiMediumTrack
    extends AudibleBackgroundMultiMediumTrack with ToStringMixin {
  FakeAudibleBackgroundMultiMediumTrack()
      : super(<Audible>[FakeAudibleMedium()]);
}

class FakeVisualizableBackgroundMultiMediumTrack
    extends VisualizableBackgroundMultiMediumTrack
    with ToStringMixin
    implements Visualizable {
  FakeVisualizableBackgroundMultiMediumTrack()
      : super(<Visualizable>[FakeVisualizableMedium()]);
}

void testToString() {
  test('Audio', () {
    final medium = Audio(Uri.parse('audio321'), maxDuration: Duration.zero);
    expect(medium.toString(),
        'Audio(resource: audio321, maxDuration: 0:00:00.000000)');
  });

  test('Image', () {
    final medium = Image(Uri.parse('image123'), maxDuration: Duration.zero);
    expect(medium.toString(),
        'Image(resource: image123, maxDuration: 0:00:00.000000)');
  });

  test('Video', () {
    final medium = Video(Uri.parse('video222'), maxDuration: Duration.zero);
    expect(medium.toString(),
        'Video(resource: video222, maxDuration: 0:00:00.000000)');
  });

  test('AudibleMultiMediumTrack', () {
    final track = AudibleMultiMediumTrack(<Audible>[FakeAudibleMedium()]);
    expect(track.toString(),
        'AudibleMultiMediumTrack(media: [FakeAudibleMedium])');
  });

  test('VisualizableMultiMediumTrack', () {
    final track =
        VisualizableMultiMediumTrack(<Visualizable>[FakeVisualizableMedium()]);
    expect(track.toString(),
        'VisualizableMultiMediumTrack(media: [FakeVisualizableMedium])');
  });

  test('AudibleBackgroundMultiMediumTrack', () {
    final track = AudibleBackgroundMultiMediumTrack(
      <Audible>[FakeAudibleMedium()],
      loop: true,
    );
    expect(
        track.toString(),
        'AudibleBackgroundMultiMediumTrack(media: [FakeAudibleMedium], '
        'isLooping: true)');
  });

  test('VisualizableBackgroundMultiMediumTrack', () {
    final track = VisualizableBackgroundMultiMediumTrack(
      <Visualizable>[FakeVisualizableMedium()],
      loop: false,
    );
    expect(
        track.toString(),
        'VisualizableBackgroundMultiMediumTrack(media: [FakeVisualizableMedium], '
        'isLooping: false)');
  });

  test('NoTrack', () {
    expect(NoTrack().toString(), 'NoTrack');
    expect(const NoTrack().toString(), 'NoTrack');
  });

  test('MultiMedium', () {
    final medium = MultiMedium(
      FakeAudibleMultiMediumTrack(),
      backgroundTrack: FakeVisualizableBackgroundMultiMediumTrack(),
      maxDuration: Duration.zero,
    );
    expect(
        medium.toString(),
        'MultiMedium(mainTrack: FakeAudibleMultiMediumTrack, '
        'backgroundTrack: FakeVisualizableBackgroundMultiMediumTrack, '
        'maxDuration: 0:00:00.000000)');
  });

  test('MultiMedium', () {
    final medium = MultiMedium(
      FakeVisualizableMultiMediumTrack(),
      backgroundTrack: FakeAudibleBackgroundMultiMediumTrack(),
      maxDuration: Duration.zero,
    );
    expect(
        medium.toString(),
        'MultiMedium(mainTrack: FakeVisualizableMultiMediumTrack, '
        'backgroundTrack: FakeAudibleBackgroundMultiMediumTrack, '
        'maxDuration: 0:00:00.000000)');
  });

  test('PlayList', () {
    final list = PlayList(<Medium>[FakeVisualizableMedium()],
        config: FakeInheritableConfig());
    expect(
        list.toString(),
        'PlayList(media: [FakeVisualizableMedium], '
        'config: FakeInheritableConfig)');
  });
}
