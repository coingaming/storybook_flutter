import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storybook_flutter/src/knobs/knob_list_tile.dart';
import 'package:storybook_flutter/src/knobs/knobs.dart';
import 'package:storybook_flutter/src/plugins/knobs.dart';

/// {@template string_knob}
/// A knob that allows the user to edit a string value.
///
/// See also:
/// * [StringKnobWidget], which is the widget that displays the knob.
/// {@endtemplate}
class StringKnobValue extends KnobValue<String> {
  /// {@macro string_knob}
  StringKnobValue({required super.value});

  @override
  Widget build({
    required String label,
    required String? description,
    required bool enabled,
    required bool nullable,
  }) =>
      StringKnobWidget(
        label: label,
        description: description,
        value: value,
        enabled: enabled,
        nullable: nullable,
      );
}

/// {@template string_knob_widget}
/// A knob widget that allows the user to edit a string value.
///
/// The knob is displayed as a [TextFormField].
///
/// See also:
/// * [StringKnobValue], which is the knob that this widget represents.
/// {@endtemplate}
class StringKnobWidget extends StatelessWidget {
  /// {@macro string_knob_widget}
  const StringKnobWidget({
    super.key,
    required this.label,
    required this.description,
    required this.value,
    required this.enabled,
    required this.nullable,
  });

  final String label;
  final String? description;
  final String value;
  final bool enabled;
  final bool nullable;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final description = this.description;

    return KnobListTile(
      enabled: enabled,
      nullable: nullable,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 4.0,
      ),
      onToggled: (enabled) =>
          context.read<KnobsNotifier>().update(label, enabled ? value : null),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 40,
            child: TextFormField(
              style: theme.textTheme.bodyMedium,
              textAlignVertical: TextAlignVertical.center,
              cursorColor: Colors.black87,
              cursorWidth: 1.8,
              cursorRadius: const Radius.circular(32),
              decoration: InputDecoration(
                labelText: label,
                hoverColor: Colors.transparent,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                    width: 1.25,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              textInputAction: TextInputAction.done,
              initialValue: value,
              onChanged: (String value) => context.read<KnobsNotifier>().update(
                    label,
                    value,
                  ),
            ),
          ),
          if (description != null)
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                description,
                style: theme.listTileTheme.subtitleTextStyle,
              ),
            ),
        ],
      ),
    );
  }
}
