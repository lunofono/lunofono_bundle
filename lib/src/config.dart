import 'package:equatable/equatable.dart' show EquatableMixin;

/// A set of configuration options that can be inherited.
///
/// This set of options can be inherited from parent to children, where the top
/// level is the App default configuration, then bundle, then the multiple
/// menus and finally the playlist.
class InheritableConfig with EquatableMixin {
  /// Preferred device screen [Orientation].
  final Orientation orientation;

  /// Map of how to react to different [Trigger]s when playing media.
  ///
  /// If this is an empty map other than the specific [inheritedReactions]
  /// instance, then the played media won't react to any triggers. If the media's
  /// [isLooping] is `true`, then at least one [Trigger] should be added to
  /// cause the [Reaction.stop] reaction, otherwise the app will play this
  /// media forever (until is closed from the OS).
  ///
  /// If the instance [inheritedReactions] is used, then the media will use the
  /// already configured reactions.
  ///
  /// Absent triggers are considered to be defined as triggering the
  /// [Reaction.none] reaction.
  final Map<Trigger, Reaction> reactions;

  /// Creates a configuration that can be overridden.
  ///
  /// [reactions] is a mapping from [Trigger]s to [Reaction]s to specify how to
  /// control playing media, please read the property's documentation for more
  /// details (defaults to [inheritedReactions] when null).
  ///
  /// If [orientation] is specified, then a particular orientation will be
  /// used. When null, [Orientation.inherited] will be used.
  const InheritableConfig({
    this.orientation = Orientation.inherited,
    this.reactions = inheritedReactions,
  });
  @override
  List<Object?> get props => [orientation, reactions];

  /// Creates a new [InheritableConfig] based on this one, overriding some
  /// values.
  ///
  /// Values not specified as arguments will be copied from this
  /// [InheritableConfig].
  InheritableConfig copyWith({
    Map<Trigger, Reaction>? reactions,
    Orientation? orientation,
  }) {
    return InheritableConfig(
      reactions: reactions ?? this.reactions,
      orientation: orientation ?? this.orientation,
    );
  }

  /// Returns a string representation of this object.
  @override
  String toString() {
    return '$runtimeType('
        'reactions: $reactions, '
        'orientation: $orientation'
        ')';
  }
}

/// Convenient alias for all-inherited config.
const inheritedConfig = InheritableConfig();

/// Screen orientation.
///
/// If [inherited] is used, then the currently configured rientation will be used.
///
/// If [automatic] is used, then the orientation will be handled by the device
/// based on how the user physically holds the device (if the device supports
/// it).
///
/// Other values force a particular orientation. This is useful if your
/// contents is designed with a particular aspect ratio, so the user doesn't
/// need to bother about moving the device until the content is seen correctly.
/// For this case the general [portrait] or [landscape] orientations should be
/// preferred
///
/// The very specific [portraitUp], [portraitDown], [landscapeLeft] and
/// [landscapeRight] can be used if you plan to make your content more like
/// a game, where the user might have some menu or content upside down for
/// example so they need to rotate the device while they play the content.
enum Orientation {
  /// Uses the current orientation configuration.
  inherited,

  /// Follow the device physical orientation if the device supports it.
  automatic,

  /// Force portrait orientation.
  portrait,

  /// Force up-only portrait orientation.
  portraitUp,

  /// Force down-only portrait orientation.
  portraitDown,

  /// Force landscape orientation.
  landscape,

  /// Force left-only landscape orientation.
  landscapeLeft,

  /// Force right-only landscape orientation.
  landscapeRight,
}

/// Types of triggers for reactions when a [PlayList] is playing.
enum Trigger {
  tap,
  longTap,
  doubleTap,
  swipeLeft,
  swipeRight,
  swipeUp,
  swipeDown,
}

/// How we should react to a trigger while a [PlayList] is playing.
enum Reaction {
  /// The trigger has no reaction.
  none,

  /// Inherits the reaction from the upper level (menu, bundle, config, default).
  inherited,

  /// Stop the [PlayList] and go back to the menu that started it.
  stop,

  /// Pause the current playing [Medium]/[PlayList].
  pause,

  /// Play the next [Medium] on the [PlayList].
  next,

  /// Play the previous [Medium] on the [PlayList].
  previous,
}

/// Convenient named map with all inherited reactions.
///
/// If you want to have a reactions map that uses all the default but for some
/// trigger, this is a good starting point, you can copy from this map and
/// override the triggers you want to change.
const inheritedReactions = <Trigger, Reaction>{
  Trigger.tap: Reaction.inherited,
  Trigger.longTap: Reaction.inherited,
  Trigger.doubleTap: Reaction.inherited,
  Trigger.swipeLeft: Reaction.inherited,
  Trigger.swipeRight: Reaction.inherited,
  Trigger.swipeUp: Reaction.inherited,
  Trigger.swipeDown: Reaction.inherited,
};

/// Convenient named empty reactions map.
///
/// If this is used, the [PlayList] will not react to any triggers, so it will
/// be forcibly played in full.
const noReactions = <Trigger, Reaction>{};
