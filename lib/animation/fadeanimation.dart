
// // Packages you must install ==>  simple_animations: ^4.0.1 || supercharged: ^2.1.1


//   // ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors
  


// import '../Widgets/AllExport.dart';

// enum AniProps { opacity, translateY }

// class FadeAnimation extends StatefulWidget {
//   final double delay;
//   final Widget child;

//   FadeAnimation({required this.delay, required  this.child});

//   @override
//   State<FadeAnimation> createState() => _FadeAnimationState();
// }

// class _FadeAnimationState extends State<FadeAnimation> with SingleTickerProviderStateMixin {
//   @override
//   Widget build(BuildContext context) {
//     final tween = MultiTween<AniProps>()
//       ..add(AniProps.opacity, 0.0.tweenTo(1.0), 500.milliseconds)
//       ..add(AniProps.translateY, (-30.0).tweenTo(0.0), 500.milliseconds,
//           Curves.easeOut);


//     return PlayAnimation<MultiTweenValues<AniProps>>(
//       delay: Duration(milliseconds: (500 * widget.delay).round()),
//       duration: tween.duration,
//       tween: tween,
//       child: widget.child,
//       builder: (context, child, value) => Opacity(
//         opacity: value.get(AniProps.opacity),
//         child: Transform.translate(
//             offset: Offset(0, value.get(AniProps.translateY)), child: child),
//       ),
//     );
//   }
// }
