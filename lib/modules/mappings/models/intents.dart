enum AppMappingActions {
  openSettings("Open settings"),
  splitRight("Split right"),
  splitDown("Split down"),
  newTab("Open new tab"),
  selectTab1("Select tab 1"),
  selectTab2("Select tab 2"),
  selectTab3("Select tab 3"),
  selectTab4("Select tab 4"),
  selectTab5("Select tab 5"),
  selectTab6("Select tab 6"),
  selectTab7("Select tab 7"),
  selectTab8("Select tab 8"),
  selectTab9("Select tab 9"),
  closeTab("Close tab"),
  focusNextTab("Focus next tab"),
  closeTerminal("Close terminal"),
  focusPrevTab("Focus prev tab");

  const AppMappingActions(this.description);
  final String description;
}
