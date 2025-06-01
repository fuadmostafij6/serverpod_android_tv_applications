import 'package:flutter/material.dart';

enum ButtonVariant {
  primary,
  secondary,
  outline,
  ghost,
  link,
}

enum ButtonSize {
  sm,
  md,
  lg,
}

class ShadcnButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final ButtonVariant variant;
  final ButtonSize size;
  final bool isLoading;
  final bool isFullWidth;
  final double? value;

  const ShadcnButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.variant = ButtonVariant.primary,
    this.size = ButtonSize.md,
    this.isLoading = false,
    this.isFullWidth = false, this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    Widget buttonChild = isLoading
        ? SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              value: value,
              valueColor: AlwaysStoppedAnimation<Color>(
                variant == ButtonVariant.primary
                    ? colorScheme.onPrimary
                    : colorScheme.primary,
              ),
            ),
          )
        : child;

    final buttonStyle = _getButtonStyle(theme);

    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: buttonStyle,
        child: Padding(
          padding: _getPadding(),
          child: buttonChild,
        ),
      ),
    );
  }

  ButtonStyle _getButtonStyle(ThemeData theme) {
    final colorScheme = theme.colorScheme;

    switch (variant) {
      case ButtonVariant.primary:
        return ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        );
      case ButtonVariant.secondary:
        return ElevatedButton.styleFrom(
          backgroundColor: colorScheme.secondary,
          foregroundColor: colorScheme.onSecondary,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        );
      case ButtonVariant.outline:
        return OutlinedButton.styleFrom(
          foregroundColor: colorScheme.primary,
          side: BorderSide(color: colorScheme.primary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        );
      case ButtonVariant.ghost:
        return TextButton.styleFrom(
          foregroundColor: colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        );
      case ButtonVariant.link:
        return TextButton.styleFrom(
          foregroundColor: colorScheme.primary,
          padding: EdgeInsets.zero,
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        );
    }
  }

  EdgeInsets _getPadding() {
    switch (size) {
      case ButtonSize.sm:
        return const EdgeInsets.symmetric(horizontal: 12, vertical: 8);
      case ButtonSize.md:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 12);
      case ButtonSize.lg:
        return const EdgeInsets.symmetric(horizontal: 20, vertical: 16);
    }
  }
} 