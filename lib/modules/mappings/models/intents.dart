enum AppMappingActions {
  splitRight("Split right"),
  splitDown("Split down"),
  newTab("Open new tab"),
  closeTab("Close tab"),
  focusNextTab("Focus next tab"),
  focusPrevTab("Focus prev tab");

  const AppMappingActions(this.description);
  final String description;
}
