import 'package:flutter/widgets.dart';
import 'package:klin/modules/mappings/controllers/mappings.controller.dart';
import 'package:klin/modules/mappings/models/intents.dart';
import 'package:klin/modules/mappings/models/shortcuts.dart';
import 'package:klin/modules/settings/components/scope_card.dart';
import 'package:klin/modules/settings/components/settings_page.dart';
import 'package:klin/modules/settings/components/switch_control.dart';
import 'package:klin/shared/components/button/button.dart';
import 'package:klin/shared/components/hotkey_recorder/hotkey_recorder.dart';
import 'package:klin/shared/components/icon/icon.dart';
import 'package:klin/shared/components/input/controlled_input.dart';
import 'package:klin/shared/components/select/select.dart';
import 'package:klin/shared/components/table/table.dart';
import 'package:rx_flow/rx_flow.dart';

class MappingsView extends RxConsumer {
  const MappingsView({super.key});

  @override
  Widget build(BuildContext context, watcher) {
    final mappingsController = watcher.controller<MappingController>();
    final mappings = watcher.watch(mappingsController.mappings) ?? [];
    final macOptionAsMeta =
        watcher.watch(mappingsController.macOptionAsMeta$) == true;

    return SettingsPage(
      children: [
        ScopeCard(
          title: "",
          children: [
            SwitchControl(
              title: "Mac option as meta",
              value: macOptionAsMeta,
              onChanged: (value) {
                mappingsController.macOptionAsMeta$.next(value);
              },
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            KlinButton(
                onTap: () {
                  mappingsController.addKeymap(CustomShortcut());
                },
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Add mapping"),
                    SizedBox(width: 6),
                    KlinIcon(
                      TablerIcons.plus,
                      size: 16,
                    )
                  ],
                )),
          ],
        ),
        const SizedBox(height: 12),
        KlinTable(
          columnWidth: const {
            3: FixedColumnWidth(80),
            2: FixedColumnWidth(130),
          },
          headers: const [
            Text("Type"),
            Text("Action"),
            Text("Hotkey"),
            SizedBox()
          ],
          rows: [
            ...mappings.map((mapping) => [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Select(
                      placeholder: "Type", // width: 200,
                      onSelect: (action) {
                        if (action.value == TerminalAction.action) {
                          mappingsController.replaceShortcut(
                            mapping,
                            CustomShortcut(
                              action: mapping.action,
                              activator: mapping.activator,
                            ),
                          );
                        } else if (action.value == TerminalAction.sendChars) {
                          mappingsController.replaceShortcut(
                            mapping,
                            CustomShortcut(
                              sendChars: mapping.sendChars ?? "",
                              activator: mapping.activator,
                            ),
                          );
                        }
                      },
                      value: mapping.sendChars != null
                          ? TerminalAction.sendChars
                          : TerminalAction.action,
                      items: TerminalAction.values
                          .map(
                            (item) => SelectItem(
                              child: Text(
                                item.description,
                                // softWrap: false,
                                overflow: TextOverflow.fade,
                              ),
                              value: item,
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: mapping.sendChars != null
                        ? SizedBox(
                            width: 200,
                            child: ControlledKlinInput(
                                placeholder: "Send chars",
                                value: mapping.sendChars ?? "",
                                onInput: (chars) {
                                  mappingsController.replaceShortcut(mapping,
                                      mapping.copyWith(sendChars: chars));
                                }),
                          )
                        : Select(
                            placeholder: "Select action",
                            width: 200,
                            value: mapping.action,
                            onSelect: (action) {
                              mappingsController.replaceShortcut(mapping,
                                  mapping.copyWith(action: action.value));
                            },
                            items: AppMappingActions.values
                                .map(
                                  (item) => SelectItem(
                                    child: Text(
                                      item.description,
                                      softWrap: false,
                                      overflow: TextOverflow.fade,
                                    ),
                                    value: item,
                                  ),
                                )
                                .toList(),
                          ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: HotKeyRecorder(
                        activator: mapping.activator,
                        onAccept: (activator) {
                          mappingsController.replaceShortcut(
                              mapping, mapping.copyWith(activator: activator));
                        }),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: KlinButton(
                      onTap: () {
                        mappingsController.removeKeymap(mapping);
                      },
                      child: const KlinIcon(
                        TablerIcons.trash,
                        size: 16,
                      ),
                    ),
                  )
                ]),
          ],
        ),
      ],
    );
  }
}
