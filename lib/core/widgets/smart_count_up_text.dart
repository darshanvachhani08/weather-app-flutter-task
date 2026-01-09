import '../core.dart';

/// SmartAnimatedText - Animated text that counts up to a target value
class SmartCountUpText extends StatefulWidget {
  final double targetValue;
  final TextStyle? style;
  final Duration duration;
  final int decimalPlaces;
  final String suffix;
  final bool useRandomness;

  const SmartCountUpText({
    super.key,
    required this.targetValue,
    this.style,
    this.duration = const Duration(milliseconds: 800),
    this.decimalPlaces = 1,
    this.suffix = '',
    this.useRandomness = true,
  });

  @override
  State<SmartCountUpText> createState() => _SmartCountUpTextState();
}

class _SmartCountUpTextState extends State<SmartCountUpText> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);

    _animation = Tween<double>(begin: 0, end: widget.targetValue).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutExpo));

    _controller.forward();
  }

  @override
  void didUpdateWidget(SmartCountUpText oldWidget) {
    if (oldWidget.targetValue != widget.targetValue) {
      _animation = Tween<double>(
        begin: _animation.value,
        end: widget.targetValue,
      ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutExpo));
      _controller.reset();
      _controller.forward();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        double displayValue;

        if (_controller.isAnimating) {
          // While animating, show a random value within a range that narrows down to targetValue
          // The range starts large and shrinks to 0 as _controller.value goes from 0 to 1
          final progress = _controller.value;

          if (progress < 0.1) {
            // Initial flicker
            displayValue = _random.nextDouble() * widget.targetValue * 1.5;
          } else if (progress < 0.9) {
            // High-speed random flickering that trends towards target
            // We mix the "true" target with a large random offset
            final randomness = (1.0 - progress) * widget.targetValue;
            displayValue = widget.targetValue + (_random.nextDouble() * randomness * 2) - randomness;
          } else {
            // Settle phase - quickly converge to target
            displayValue = widget.targetValue;
          }
        } else {
          // Animation finished, show exact value
          displayValue = widget.targetValue;
        }

        return SmartText(
          '${displayValue.toStringAsFixed(widget.decimalPlaces)}${widget.suffix}',
          style: widget.style,
          useLocalization: false,
        );
      },
    );
  }
}
