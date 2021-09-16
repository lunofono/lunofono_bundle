import 'package:equatable/equatable.dart' show EquatableMixin;

import 'config.dart';

/// A type tag to indicate the medium can be played.
///
/// This type is used to tag other types and group all types that can be played
/// by the Lunofono player. Is created only as a placeholder for containers
/// that should have playable media. This is just a way to get a slightly more
/// restrictive [Object] or [dynamic] type.
abstract class Playable {}

/// A type tag to indicate the medium can be viewed.
///
/// This type is used to tag other types and group all types that need some
/// visual representation to be played.
abstract class Visualizable implements Playable {}

/// A type tag to indicate the medium can be heard.
///
/// This type is used to tag other types and group all types that can just be
/// heard, and don't need any visual representation to be played.
abstract class Audible implements Playable {}

/// An unlimited (infinite) [Duration].
///
/// This is represented by just a number of days set to the maximum 32bit
/// number, and since this is not, of course, infinite, when using this it
/// should be checked for equality or just check if a particular `duration is
/// UnlimitedDuration`. All instances of this class will compare equal when
/// using the equality operator.
class UnlimitedDuration extends Duration {
  /// Constructs a new [UnlimitedDuration].
  ///
  /// Even when the created object might be new, all [UnlimitedDuration]
  /// instances compare equals.
  const UnlimitedDuration() : super(days: 365);

  /// Returns true is [other] is an instance of [UnlimitedDuration].
  @override
  bool operator ==(Object other) => other is UnlimitedDuration;

  /// Returns the same value for all [UnlimitedDuration] instances.
  @override
  int get hashCode => 'UnlimitedDuration'.hashCode;
}

/// Basic unit that can be reproduced.
///
/// Typically it can be an [Image], [Video] or [Audio], but it can also be
/// a [MultiMedium].
abstract class Medium implements Playable {
  /// Maximum duration for this [Medium].
  ///
  /// If this [Medium] last longer than [maxDuration], the medium will be
  /// stopped after it player for [maxDuration] time, unless [maxDuration] is
  /// [UnlimitedDuration], which means the medium should be played completely.
  final Duration maxDuration;

  /// Creates a [Medium] with a maximum duration of [maxDuration].
  ///
  /// If [maxDuration] is set to an [UnlimitedDuration] (the default when null),
  /// this [Medium] will play for as long as it lasts.
  const Medium({Duration? maxDuration})
      : maxDuration = maxDuration ?? const UnlimitedDuration();
}

/// A [Medium] with a single resource.
abstract class SingleMedium extends Medium with EquatableMixin {
  /// URI with the location of the resource
  ///
  /// The URI can have the following schemas:
  ///
  /// * `http`/`https`: Get the resource from the network using the HTTP/HTTPS
  ///   protocols.
  /// * `asset`: Get the resource from the App's assets. Example:
  ///   `assets:path/to/media`.
  /// * `bundle`: Get the resource from the content bundle that defined this
  ///    medium. Example: `bundle:path/to/media`.
  final Uri resource;

  /// Creates a [SingleMedium] pointing to a [resource].
  const SingleMedium(
    this.resource, {
    Duration? maxDuration,
  }) : super(maxDuration: maxDuration);
  @override
  List<Object?> get props => [resource, maxDuration];

  /// Returns a string representation of this object.
  @override
  String toString() {
    return '$runtimeType('
        'resource: $resource, '
        'maxDuration: $maxDuration'
        ')';
  }
}

/// An audio single medium
class Audio extends SingleMedium implements Audible {
  /// Creates a single [Audio] [Medium].
  const Audio(
    Uri resource, {
    Duration? maxDuration,
  }) : super(
          resource,
          maxDuration: maxDuration,
        );

  /// Creates a new [Audio] based on this one, overriding some values.
  ///
  /// Values not specified as arguments will be copied from this [Audio].
  Audio copyWith({Uri? resource, Duration? maxDuration}) {
    return Audio(
      resource ?? this.resource,
      maxDuration: maxDuration ?? this.maxDuration,
    );
  }
}

/// An image single medium
class Image extends SingleMedium implements Visualizable {
  /// Creates a single [Image] [Medium].
  const Image(
    Uri resource, {
    Duration? maxDuration,
  }) : super(
          resource,
          maxDuration: maxDuration,
        );

  /// Creates a new [Image] based on this one, overriding some values.
  ///
  /// Values not specified as arguments will be copied from this [Image].
  Image copyWith({Uri? resource, Duration? maxDuration}) {
    return Image(
      resource ?? this.resource,
      maxDuration: maxDuration ?? this.maxDuration,
    );
  }
}

/// A video single medium
class Video extends SingleMedium implements Visualizable, Audible {
  /// Creates a single [Video] [Medium].
  const Video(
    Uri resource, {
    Duration? maxDuration,
  }) : super(
          resource,
          maxDuration: maxDuration,
        );

  /// Creates a new [Video] based on this one, overriding some values.
  ///
  /// Values not specified as arguments will be copied from this [Video].
  Video copyWith({Uri? resource, Duration? maxDuration}) {
    return Video(
      resource ?? this.resource,
      maxDuration: maxDuration ?? this.maxDuration,
    );
  }
}

/// A track of a [MultiMedium] medium.
///
/// Since the [media] must all be either [Visualizable] or [Audible] this is an
/// abstract class. The concrete classes are [AudibleMultiMediumTrack] and
/// [VisualizableMultiMediumTrack]. There is also the special [NoTrack] class
/// that represents the absence of a track.
abstract class MultiMediumTrack {
  /// List of [SingleMedium] media reproduced by this track.
  List<SingleMedium> get media;
}

/// An audible track of a [MultiMedium] medium.
class AudibleMultiMediumTrack with EquatableMixin implements MultiMediumTrack {
  /// List of [SingleMedium] media reproduced by this track.
  @override
  List<SingleMedium> get media => List<SingleMedium>.from(_media);

  /// List of [Audible] media reproduced by this track.
  final List<Audible> _media;

  /// Creates a multi medium track.
  ///
  /// The track consists of a list of [media] that will be played sequentially.
  const AudibleMultiMediumTrack(
    List<Audible> media,
  )   : assert(media.length != 0), // Can't use .isNotEmpty because of const
        _media = media;
  @override
  List<Object?> get props => [media];

  /// Creates a new [MultiMediumTrack] based on this one.
  ///
  /// Values not specified as arguments will be copied from this
  /// [MultiMediumTrack].
  AudibleMultiMediumTrack copyWith({
    List<Audible>? media,
  }) {
    return AudibleMultiMediumTrack(
      media ?? _media,
    );
  }

  /// Returns a string representation of this object.
  @override
  String toString() {
    return '$runtimeType('
        'media: $media'
        ')';
  }
}

/// A track of a [MultiMedium] medium.
///
/// The [media] must all be either [Visualizable] or [Audible], there can't be
/// mixed media in the same track.
class VisualizableMultiMediumTrack
    with EquatableMixin
    implements MultiMediumTrack {
  /// List of [SingleMedium] media reproduced by this track.
  @override
  List<SingleMedium> get media => List<SingleMedium>.from(_media);

  /// List of [SingleMedium] media reproduced by this track.
  final List<Visualizable> _media;

  /// Creates a multi medium track.
  ///
  /// The track consists of a list of [media] that will be played sequentially.
  const VisualizableMultiMediumTrack(
    List<Visualizable> media,
  )   : assert(media.length != 0), // Can't use .isNotEmpty because of const
        _media = media;
  @override
  List<Object?> get props => [media];

  /// Creates a new [MultiMediumTrack] based on this one.
  ///
  /// Values not specified as arguments will be copied from this
  /// [MultiMediumTrack].
  VisualizableMultiMediumTrack copyWith({
    List<Visualizable>? media,
  }) {
    return VisualizableMultiMediumTrack(
      media ?? _media,
    );
  }

  /// Returns a string representation of this object.
  @override
  String toString() {
    return '$runtimeType('
        'media: $media'
        ')';
  }
}

/// A background track of a [MultiMedium] medium.
///
/// A background tracks is [MultiMediumTrack] that can be played in a loop.
abstract class BackgroundMultiMediumTrack implements MultiMediumTrack {
  /// If true, the track loops.
  bool get isLooping;
}

/// An [Audible] background [MultiMedium] track.
class AudibleBackgroundMultiMediumTrack extends AudibleMultiMediumTrack
    implements BackgroundMultiMediumTrack {
  /// If true, the track loops.
  final bool _isLooping;

  /// If true, the track loops.
  @override
  bool get isLooping => _isLooping;

  /// Creates a background multi medium track.
  ///
  /// The track consists of a list of [media] that will be played sequentially.
  /// If [loop] is true, it will play the media in a loop (defaults to false
  /// when null).
  const AudibleBackgroundMultiMediumTrack(
    List<Audible> media, {
    bool loop = false,
  })  : _isLooping = loop,
        super(media);
  @override
  List<Object?> get props => super.props + [isLooping];

  /// Creates a new [AudibleBackgroundMultiMediumTrack] based on this one.
  ///
  /// Values not specified as arguments will be copied from this
  /// [AudibleBackgroundMultiMediumTrack].
  @override
  AudibleBackgroundMultiMediumTrack copyWith({
    List<Audible>? media,
    bool? isLooping,
  }) {
    return AudibleBackgroundMultiMediumTrack(
      media ?? _media,
      loop: isLooping ?? this.isLooping,
    );
  }

  /// Returns a string representation of this object.
  @override
  String toString() {
    return '$runtimeType('
        'media: $media, '
        'isLooping: $isLooping'
        ')';
  }
}

/// A [Visualizable] background [MultiMedium] track.
class VisualizableBackgroundMultiMediumTrack
    extends VisualizableMultiMediumTrack implements BackgroundMultiMediumTrack {
  /// If true, the track loops.
  final bool _isLooping;

  /// If true, the track loops.
  @override
  bool get isLooping => _isLooping;

  /// Creates a background multi medium track.
  ///
  /// The track consists of a list of [media] that will be played sequentially.
  /// If [loop] is true, it will play the media in a loop (defaults to false
  /// when null).
  const VisualizableBackgroundMultiMediumTrack(
    List<Visualizable> media, {
    bool loop = false,
  })  : _isLooping = loop,
        super(media);
  @override
  List<Object?> get props => super.props + [isLooping];

  /// Creates a new [VisualizableBackgroundMultiMediumTrack] based on this one.
  ///
  /// Values not specified as arguments will be copied from this
  /// [VisualizableBackgroundMultiMediumTrack].
  @override
  VisualizableBackgroundMultiMediumTrack copyWith({
    List<Visualizable>? media,
    bool? isLooping,
  }) {
    return VisualizableBackgroundMultiMediumTrack(
      media ?? _media,
      loop: isLooping ?? this.isLooping,
    );
  }

  /// Returns a string representation of this object.
  @override
  String toString() {
    return '$runtimeType('
        'media: $media, '
        'isLooping: $isLooping'
        ')';
  }
}

/// Internal type to represent an empty [MultiMediumTrack].
///
/// Background tracks for [MultiMediumTrack]s can be empty, but we can't use
/// null to represent that, otherwise [copyWith()] can't differentiate if the
/// passed background track should be removed of if it shouldn't be overridden.
///
/// This implementation throws a [UnimplementedError] for all the
/// [MultiMediumTrack] API, it should only be used to compare for equality or
/// with the `is` operator.
class NoTrack implements BackgroundMultiMediumTrack {
  /// Throws an [UnimplementedError].
  @override
  List<SingleMedium> get media {
    throw UnimplementedError();
  }

  /// Throws an [UnimplementedError].
  @override
  bool get isLooping {
    throw UnimplementedError();
  }

  /// Constructs a [NoTrack] instance.
  const NoTrack();

  /// Returns a string representation of this object.
  @override
  String toString() {
    return 'NoTrack';
  }

  /// Returns true if [other] is an instance of [NoTrack].
  @override
  bool operator ==(Object other) => other is NoTrack;

  /// Returns the same value for all [NoTrack] instances.
  @override
  int get hashCode => 'NoTrack'.hashCode;
}

/// A [Medium] with two tracks of media.
///
/// This medium is composed from a [mainTrack] and an optional
/// [backgroundTrack]. Each track is a sequence of one or more media. The
/// lifetime of this medium is bound to the [mainTrack], while the
/// [backgroundTrack], if present, will adapt to the [mainTrack].
class MultiMedium extends Medium with EquatableMixin {
  /// Main [MultiMedium] track.
  ///
  /// The lifetime of this [MultiMedium] will be tied to this track.
  final MultiMediumTrack mainTrack;

  /// The background track for this [MultiMedium].
  ///
  /// The background track will adapt to the lifetime of the main track. If
  /// this medium should not have a background track, [NoTrack] can be used.
  /// If [backgroundTrack.isLooping] is true, then as long as the
  /// [mainTrack] is playing, the background track will be restarted when
  /// finished.
  final BackgroundMultiMediumTrack backgroundTrack;

  /// Creates a [MultiMedium].
  ///
  /// The medium must have a non-empty [mainTrack] and an optional
  /// [backgroundTrack] ([NoTrack] should be used to omit the
  /// [backgroundTrack], which is the default when null is used).
  ///
  /// If there is a [backgroundTrack] present, then the [mainTrack] and
  /// [backgroundTrack.track] should one audible and the other one
  /// visualizable.
  ///
  /// The [mainTrack] can't be a [BackgroundMultiMediumTrack].
  const MultiMedium(
    this.mainTrack, {
    this.backgroundTrack = const NoTrack(),
    Duration maxDuration = const UnlimitedDuration(),
  })  : assert(mainTrack is! BackgroundMultiMediumTrack),
        assert(backgroundTrack is NoTrack ||
            (mainTrack is AudibleMultiMediumTrack &&
                    backgroundTrack is VisualizableBackgroundMultiMediumTrack ||
                mainTrack is VisualizableMultiMediumTrack &&
                    backgroundTrack is AudibleBackgroundMultiMediumTrack)),
        super(maxDuration: maxDuration);
  @override
  List<Object?> get props => [
        mainTrack,
        backgroundTrack,
        maxDuration,
      ];

  /// Creates a [MultiMedium] from a [SingleMedium].
  ///
  /// The [medium] is added as the only media in the [mainTrack] and
  /// [maxDuration] is set to [medium.maxDuration]. The [mainTrack] will be
  /// visualizable if the [medium] is [Visualizable] (even if it is [Audible]
  /// too. If it is [Audible] *only*, then the [mainTrack] is audible.
  MultiMedium.fromSingleMedium(SingleMedium medium)
      : assert(medium is Audible || medium is Visualizable),
        mainTrack = (medium is Visualizable
            ? VisualizableMultiMediumTrack([medium as Visualizable])
            : AudibleMultiMediumTrack([medium as Audible])) as MultiMediumTrack,
        backgroundTrack = const NoTrack(),
        super(maxDuration: medium.maxDuration);

  /// Creates a new [MultiMedium] based on this one.
  ///
  /// Values not specified as arguments will be copied from this [MultiMedium].
  MultiMedium copyWith({
    MultiMediumTrack? mainTrack,
    BackgroundMultiMediumTrack? backgroundTrack,
    Duration? maxDuration,
  }) {
    return MultiMedium(
      mainTrack ?? this.mainTrack,
      backgroundTrack: backgroundTrack ?? this.backgroundTrack,
      maxDuration: maxDuration ?? this.maxDuration,
    );
  }

  /// Returns a string representation of this object.
  @override
  String toString() {
    return '$runtimeType('
        'mainTrack: $mainTrack, '
        'backgroundTrack: $backgroundTrack, '
        'maxDuration: $maxDuration'
        ')';
  }
}

/// A list of media that can be played.
class Playlist with EquatableMixin implements Playable {
  /// List of media that this [Playlist] will play.
  final List<Medium> media;

  /// Playlist's [Orientation].
  final InheritableConfig config;

  /// Creates a play list with a list of [media].
  ///
  /// Playlist configuration, like the preferred screen orientation or how to
  /// react to events to control the playlist can be specified via [config].
  /// When null is used (the default), all configuration will be inherited from
  /// the parent.
  ///
  /// The [media] list must not be empty.
  const Playlist(
    this.media, {
    this.config = inheritedConfig,
  }) : assert(media.length != 0); // Can't use .isNotEmpty because of const
  @override
  List<Object?> get props => [media, config];

  /// Creates a new [Playlist] based on this one, overriding some values.
  ///
  /// Values not specified as arguments will be copied from this [Playlist].
  Playlist copyWith({
    List<Medium>? media,
    InheritableConfig? config,
  }) {
    return Playlist(
      media ?? this.media,
      config: config ?? this.config,
    );
  }

  /// Returns a string representation of this object.
  @override
  String toString() {
    return '$runtimeType('
        'media: $media, '
        'config: $config'
        ')';
  }
}
