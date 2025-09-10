import 'package:flutter/material.dart';
import '../utils/extensions.dart';

enum ButtonVariant { filled, outlined, text }
enum ButtonSize { small, medium, large }

class CustomButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonVariant variant;
  final ButtonSize size;
  final Widget? icon;
  final bool isLoading;
  final bool expanded;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? borderRadius;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.variant = ButtonVariant.filled,
    this.size = ButtonSize.medium,
    this.icon,
    this.isLoading = false,
    this.expanded = false,
    this.padding,
    this.backgroundColor,
    this.foregroundColor,
    this.borderRadius,
  });

  const CustomButton.filled({
    super.key,
    required this.text,
    this.onPressed,
    this.size = ButtonSize.medium,
    this.icon,
    this.isLoading = false,
    this.expanded = false,
    this.padding,
    this.backgroundColor,
    this.foregroundColor,
    this.borderRadius,
  }) : variant = ButtonVariant.filled;

  const CustomButton.outlined({
    super.key,
    required this.text,
    this.onPressed,
    this.size = ButtonSize.medium,
    this.icon,
    this.isLoading = false,
    this.expanded = false,
    this.padding,
    this.backgroundColor,
    this.foregroundColor,
    this.borderRadius,
  }) : variant = ButtonVariant.outlined;

  const CustomButton.text({
    super.key,
    required this.text,
    this.onPressed,
    this.size = ButtonSize.medium,
    this.icon,
    this.isLoading = false,
    this.expanded = false,
    this.padding,
    this.backgroundColor,
    this.foregroundColor,
    this.borderRadius,
  }) : variant = ButtonVariant.text;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final button = _buildButton(context);

    if (widget.expanded) {
      return SizedBox(
        width: double.infinity,
        child: button,
      );
    }

    return button;
  }

  Widget _buildButton(BuildContext context) {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: child,
        );
      },
      child: _buildButtonChild(context),
    );
  }

  Widget _buildButtonChild(BuildContext context) {
    final isEnabled = widget.onPressed != null && !widget.isLoading;

    switch (widget.variant) {
      case ButtonVariant.filled:
        return widget.icon != null
            ? FilledButton.icon(
          onPressed: isEnabled ? _handlePressed : null,
          icon: _buildIcon(),
          label: _buildLabel(),
          style: _buildButtonStyle(context),
        )
            : FilledButton(
          onPressed: isEnabled ? _handlePressed : null,
          style: _buildButtonStyle(context),
          child: _buildLabel(),
        );
      case ButtonVariant.outlined:
        return widget.icon != null
            ? OutlinedButton.icon(
          onPressed: isEnabled ? _handlePressed : null,
          icon: _buildIcon(),
          label: _buildLabel(),
          style: _buildButtonStyle(context),
        )
            : OutlinedButton(
          onPressed: isEnabled ? _handlePressed : null,
          style: _buildButtonStyle(context),
          child: _buildLabel(),
        );
      case ButtonVariant.text:
        return widget.icon != null
            ? TextButton.icon(
          onPressed: isEnabled ? _handlePressed : null,
          icon: _buildIcon(),
          label: _buildLabel(),
          style: _buildButtonStyle(context),
        )
            : TextButton(
          onPressed: isEnabled ? _handlePressed : null,
          style: _buildButtonStyle(context),
          child: _buildLabel(),
        );
    }
  }

  Widget _buildIcon() {
    if (widget.isLoading) {
      return SizedBox(
        width: _getIconSize(),
        height: _getIconSize(),
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            widget.foregroundColor ??
                (widget.variant == ButtonVariant.filled
                    ? Colors.white
                    : context.colorScheme.primary),
          ),
        ),
      );
    }

    return widget.icon ?? const SizedBox.shrink();
  }

  Widget _buildLabel() {
    return Text(
      widget.text,
      style: TextStyle(
        fontSize: _getFontSize(),
        fontWeight: FontWeight.w600,
      ),
    );
  }

  ButtonStyle _buildButtonStyle(BuildContext context) {
    return ButtonStyle(
      padding: WidgetStateProperty.all(
        widget.padding ?? _getDefaultPadding(),
      ),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            widget.borderRadius ?? _getDefaultBorderRadius(),
          ),
        ),
      ),
      backgroundColor: widget.backgroundColor != null
          ? WidgetStateProperty.all(widget.backgroundColor)
          : null,
      foregroundColor: widget.foregroundColor != null
          ? WidgetStateProperty.all(widget.foregroundColor)
          : null,
      overlayColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.pressed)) {
          return context.colorScheme.primary.withOpacity(0.1);
        }
        if (states.contains(WidgetState.hovered)) {
          return context.colorScheme.primary.withOpacity(0.08);
        }
        return null;
      }),
    );
  }

  void _handlePressed() {
    _animationController.forward().then((_) {
      _animationController.reverse();
    });
    widget.onPressed?.call();
  }

  EdgeInsetsGeometry _getDefaultPadding() {
    switch (widget.size) {
      case ButtonSize.small:
        return const EdgeInsets.symmetric(horizontal: 12, vertical: 8);
      case ButtonSize.medium:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 12);
      case ButtonSize.large:
        return const EdgeInsets.symmetric(horizontal: 20, vertical: 16);
    }
  }

  double _getDefaultBorderRadius() {
    switch (widget.size) {
      case ButtonSize.small:
        return 6;
      case ButtonSize.medium:
        return 8;
      case ButtonSize.large:
        return 12;
    }
  }

  double _getFontSize() {
    switch (widget.size) {
      case ButtonSize.small:
        return 12;
      case ButtonSize.medium:
        return 14;
      case ButtonSize.large:
        return 16;
    }
  }

  double _getIconSize() {
    switch (widget.size) {
      case ButtonSize.small:
        return 16;
      case ButtonSize.medium:
        return 18;
      case ButtonSize.large:
        return 20;
    }
  }
}