class Breakpoints {
  const Breakpoints._();

  static const double compact = 720;
  static const double medium = 1100;

  static bool isCompact(double width) => width < compact;
  static bool isMedium(double width) => width >= compact && width < medium;
  static bool isExpanded(double width) => width >= medium;
}