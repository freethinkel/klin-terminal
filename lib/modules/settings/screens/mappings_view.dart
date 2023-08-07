import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:oshmes_terminal/core/widgets/rx_consumer.dart';
import 'package:oshmes_terminal/modules/mappings/controllers/mappings.controller.dart';
import 'package:oshmes_terminal/modules/mappings/models/intents.dart';
import 'package:oshmes_terminal/modules/mappings/models/shortcuts.dart';
import 'package:oshmes_terminal/modules/settings/components/settings_page.dart';
import 'package:oshmes_terminal/shared/components/button/button.dart';
import 'package:oshmes_terminal/shared/components/hotkey_recorder/hotkey_recorder.dart';
import 'package:oshmes_terminal/shared/components/icon/icon.dart';
import 'package:oshmes_terminal/shared/components/input/input.dart';
import 'package:oshmes_terminal/shared/components/select/select.dart';
import 'package:oshmes_terminal/shared/components/table/table.dart';

class MappingsView extends RxConsumer {
  const MappingsView({super.key});

  @override
  Widget build(BuildContext context, watcher) {
    final mappingsController = watcher.controller<MappingController>();
    final keymappings = watcher.watch(mappingsController.mappings) ?? [];

    return SettingsPage(
      title: "Mappings",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          OshmesButton(
              onTap: () {
                mappingsController.addKeymap(CustomShortcut());
              },
              child: const Wrap(
                spacing: 2,
                children: [
                  Text("Add mapping"),
                  OshmesIcon(
                    TablerIcons.plus,
                    size: 16,
                  )
                ],
              )),
          const SizedBox(height: 12),
          OshmesTable(
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
              ...keymappings.map((mapping) => [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Select(
                        placeholder: "Type",
                        width: 200,
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
                                child: Text(item.description),
                                value: item,
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: mapping.sendChars != null
                          ? Container(
                              width: 200,
                              child: OshmesInput(
                                  placeholder: "Send chars",
                                  value: mapping.sendChars,
                                  onChanged: (chars) {
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
                                      child: Text(item.description),
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
                            mappingsController.replaceShortcut(mapping,
                                mapping.copyWith(activator: activator));
                          }),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: OshmesButton(
                        onTap: () {
                          mappingsController.removeKeymap(mapping);
                        },
                        child: const OshmesIcon(
                          TablerIcons.trash,
                          size: 16,
                        ),
                      ),
                    )
                  ]),
            ],
          ),
        ],
      ),
    );
  }
}
