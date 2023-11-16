enum AppMappingActions {
  openSettings("Open settings"),
  splitRight("Split right"),
  splitDown("Split down"),
  newTab("Open new tab"),
  closeTab("Close tab"),
  focusNextTab("Focus next tab"),
  closeTerminal("Close terminal"),
  focusPrevTab("Focus prev tab");

  const AppMappingActions(this.description);
  final String description;
}
