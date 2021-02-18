import 'dart:ui' show Color;

import 'package:equatable/equatable.dart' show EquatableMixin;
import 'package:meta/meta.dart' show required;

import 'config.dart';
import 'media.dart';

export 'dart:ui' show Color;

/// A content bundle.
///
/// Bundles are the way Lunofono distributes content, and content is organized
/// in one or more [Menu]s that consist of [Button]s, which when touched,
/// reproduce some [Medium] or [Playlist] (or open a new sub-[Menu]). The main
/// menu of a bundle is called the [rootMenu].
///
/// A bundle can have an optional [InheritableConfig] which defines some
/// configuration options that can be overridden from the main app
/// configuration, and can also be overridden by [Menu]s and [Playlist]s.
///
/// If [config] is [inheritedConfig] (the default when null),
/// then the app main configuration will be used and inherited by the
/// [rootMenu] (which can override it).
class Bundle with EquatableMixin {
  /// Main menu for the content bundle (the player will start here).
  final Menu rootMenu;

  /// Configuration that can be inherited from the app's configuration.
  ///
  /// This configuration can also be overridden by [Menu]s and [Playlist]s.
  final InheritableConfig config;

  /// Creates a content bundle.
  const Bundle(
    this.rootMenu, {
    InheritableConfig config,
  })  : config = config ?? inheritedConfig,
        assert(rootMenu != null);
  @override
  List<Object> get props => [rootMenu, config];

  /// Creates a new [Bundle] based on this one, overriding some values.
  ///
  /// Values not specified as arguments will be copied from this [Bundle].
  Bundle copyWith({
    Menu rootMenu,
    InheritableConfig config,
  }) {
    return Bundle(
      rootMenu ?? this.rootMenu,
      config: config ?? this.config,
    );
  }

  /// Returns a string representation of this object.
  @override
  String toString() {
    return '$runtimeType('
        'rootMenu: $rootMenu, '
        'config: $config'
        ')';
  }
}

/// A content menu.
///
/// A Menu normally consists of [Button]s, which when touched, reproduce some
/// [Medium] or [Playlist] (or open a new sub-[Menu]).
///
/// A menu can have an optional [config] configuration that can be inherited
/// from the parent and overridden by the children.
abstract class Menu {
  /// Menu configuration.
  ///
  /// This configuration can be inherited from the parent [Menu] or
  /// [Bundle].
  final InheritableConfig config;

  /// Constructs a new Menu.
  ///
  /// If [config] is null (the default), [inheritedConfig] is used, and all the
  /// configuration is inherited from the parent [Menu] or [Bundle].
  const Menu({
    InheritableConfig config,
  }) : config = config ?? inheritedConfig;
}

/// A [Menu] consisting in a grid or buttons.
///
/// Buttons are stored in the [buttons] list and will be arranged filling first
/// the [rows] and then the [columns].
///
/// For example, if the a grid menu is created with 2 [rows] and 3 [columns],
/// and the [buttons] contains `[b1, b2, b3, b4, b5, b6]`, then the grid will
/// look like this:
///
/// ```
/// b1 b2
/// b3 b4
/// b5 b6
/// ```
class GridMenu extends Menu with EquatableMixin {
  /// Number of rows this menu has.
  final int rows;

  /// Number of columns this menu has.
  final int columns;

  /// List of buttons in this manu.
  final List<Button> buttons;

  /// Gets the [Button] at position ([row], [column]) in the grid.
  ///
  /// TODO: Swap rows and cols if the orientation is forced?
  Button buttonAt(int row, int column) => buttons[row * columns + column];

  /// Creates a grid menu from a list of [buttons].
  ///
  /// The list of [buttons] must not be empty and have `rows * columns`
  /// buttons (where both [rows] and [columns] must be greater than 0).
  const GridMenu({
    @required this.rows,
    @required this.columns,
    @required this.buttons,
    InheritableConfig config,
  })  : assert(rows != null),
        assert(rows > 0),
        assert(columns != null),
        assert(columns > 0),
        assert(buttons != null),
        assert(buttons.length == rows * columns),
        super(config: config);
  @override
  List<Object> get props => [rows, columns, buttons, config];

  /// Creates a new [GridMenu] based on this one, overriding some values.
  ///
  /// Values not specified as arguments will be copied from this [GridMenu].
  GridMenu copyWith({
    int rows,
    int columns,
    List<Button> buttons,
    InheritableConfig config,
  }) {
    return GridMenu(
      rows: rows ?? this.rows,
      columns: columns ?? this.columns,
      buttons: buttons ?? this.buttons,
      config: config ?? this.config,
    );
  }

  /// Returns a string representation of this object.
  @override
  String toString() {
    return '$runtimeType('
        'rows: $rows, '
        'columns: $columns, '
        'buttons: $buttons, '
        'config: $config'
        ')';
  }
}

/// An action performed when a [Button] is pressed.
abstract class Action {
  const Action();
}

/// A button that triggers an [Action].
abstract class Button {
  /// Action to be triggered by the button when pressed.
  final Action action;

  /// Creates a new [Button] with an associated [Action].
  const Button(this.action) : assert(action != null);
}

/// A [Button] with a customizable style.
class StyledButton extends Button with EquatableMixin {
  /// Color to display as this button's background.
  ///
  /// If null, the player can automatically choose one or a global default might
  /// be used.
  final Color backgroundColor;

  /// The image to display in this button foreground.
  ///
  /// If null, no foreground image is displayed.
  final Uri foregroundImage;

  /// Creates a button represented by a [backgroundColor].
  const StyledButton(Action action,
      {this.backgroundColor, this.foregroundImage})
      : super(action);
  @override
  List<Object> get props => [action, backgroundColor, foregroundImage];

  /// Creates a new [StyledButton] based on this one, overriding some values.
  ///
  /// Values not specified as arguments will be copied from this
  /// [StyledButton].
  ///
  /// Note that this won't work to make a copy with some values set to null. If
  /// you need to do that you'll have to do the copy manually by calling the
  /// constructor explicitly.
  StyledButton copyWith({
    Action action,
    Color backgroundColor,
    Uri foregroundImage,
  }) {
    return StyledButton(
      action ?? this.action,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundImage: foregroundImage ?? this.foregroundImage,
    );
  }

  /// Returns a string representation of this object.
  @override
  String toString() {
    return '$runtimeType('
        'action: $action, '
        'backgroundColor: $backgroundColor, '
        'foregroundImage: $foregroundImage'
        ')';
  }
}

/// A [Button] that shows an image.
class ImageButton extends Button with EquatableMixin {
  /// The image to display in this button.
  final Uri imageUri;

  /// Creates a button represented by [imageUri].
  const ImageButton(Action action, this.imageUri)
      : assert(imageUri != null),
        super(action);
  @override
  List<Object> get props => [action, imageUri];

  /// Creates a new [ImageButton] based on this one, overriding some values.
  ///
  /// Values not specified as arguments will be copied from this
  /// [ImageButton].
  ///
  /// Note that this won't work to make a copy with some values set to null. If
  /// you need to do that you'll have to do the copy manually by calling the
  /// constructor explicitly.
  ImageButton copyWith({
    Action action,
    Uri imageUri,
  }) {
    return ImageButton(
      action ?? this.action,
      imageUri ?? this.imageUri,
    );
  }

  /// Returns a string representation of this object.
  @override
  String toString() {
    return '$runtimeType('
        'action: $action, '
        'imageUri: $imageUri'
        ')';
  }
}

/// An [Action] that shows a [Menu] when a [Button] is pressed.
class ShowMenuAction extends Action with EquatableMixin {
  /// [Menu] to be shown by this action.
  final Menu menu;

  /// Creates a new [ShowMenuAction].
  ///
  /// The action will show the [menu] when activated.
  const ShowMenuAction(this.menu) : assert(menu != null);
  @override
  List<Object> get props => [menu];

  /// Creates a new [ShowMenuAction] based on this one, overriding some values.
  ///
  /// Values not specified as arguments will be copied from this
  /// [ShowMenuAction].
  ShowMenuAction copyWith({
    Menu menu,
  }) {
    return ShowMenuAction(
      menu ?? this.menu,
    );
  }

  /// Returns a string representation of this object.
  @override
  String toString() {
    return '$runtimeType('
        'menu: $menu'
        ')';
  }
}

/// An [Action] that closes the current [Menu].
///
/// If this is the action appears in a [Bundle.rootMenu], then the
/// player is closed when the action is activated.
class CloseMenuAction extends Action with EquatableMixin {
  /// Creates a new [CloseMenuAction].
  const CloseMenuAction();
  @override
  List<Object> get props => [];

  /// Creates a new [CloseMenuAction] based on this one, overriding some
  /// values.
  ///
  /// Values not specified as arguments will be copied from this
  /// [CloseMenuAction].
  CloseMenuAction copyWith() {
    return CloseMenuAction();
  }

  /// Returns a string representation of this object.
  @override
  String toString() {
    return '$runtimeType()';
  }
}

/// An [Action] that plays a [Playable] when a [Button] is pressed.
class PlayContentAction extends Action with EquatableMixin {
  /// [Playable] content to be played.
  final Playable content;

  /// Creates a new [PlayContentAction].
  ///
  /// The action will play the [content] when activated.
  const PlayContentAction(this.content) : assert(content != null);
  @override
  List<Object> get props => [content];

  /// Creates a new [PlayContentAction] based on this one, overriding some values.
  ///
  /// Values not specified as arguments will be copied from this
  /// [PlayContentAction].
  PlayContentAction copyWith({
    Playable content,
  }) {
    return PlayContentAction(
      content ?? this.content,
    );
  }

  /// Returns a string representation of this object.
  @override
  String toString() {
    return '$runtimeType('
        'content: $content'
        ')';
  }
}
