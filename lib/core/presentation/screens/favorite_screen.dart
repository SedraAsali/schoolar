
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../providers/favorites_provider.dart';


class FavoritesPage extends ConsumerWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesProvider);

    return SafeArea(
      child: favorites.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_border_rounded,
              size: 90,
              color: Theme.of(context).colorScheme.primary,
            )
                .animate(
              onPlay: (controller) =>
                  controller.repeat(reverse: true),
            )
                .scale(
              begin: const Offset(1.2, 1.2),
              end: const Offset(1.1, 1.1),
              duration: 500.ms,
            ),
            const SizedBox(height: 15),
            Text(
              "لا توجد معاهد مفضلة",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ).animate().fadeIn(duration: 1100.ms),
          ],
        ),
      )
          : Padding(
        padding: const EdgeInsets.only(top: 10),
        child: ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: favorites.length,
          itemBuilder: (context, index) {
            final item = favorites[index];

            return Dismissible(
              key: Key(item['name']!),
              direction: DismissDirection.endToStart,
              onDismissed: (_) {
                ref.read(favoritesProvider.notifier).remove(item['name']!);
              },
              background: Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 20),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.error,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(
                  Icons.delete_rounded,
                  size: 30,
                  color: Theme.of(context).colorScheme.surface,
                ),
              ),
              child: TweenAnimationBuilder(
                duration:
                Duration(milliseconds: 500 + (index * 120)),
                tween: Tween(begin: 0.0, end: 1.0),
                curve: Curves.easeOutCubic,
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value,
                    child: Transform.translate(
                      offset: Offset(0, 50 * (1 - value)),
                      child: child,
                    ),
                  );
                },
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {},
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 14),
padding: const EdgeInsets.all(14),
decoration: BoxDecoration(
color: Theme.of(context).colorScheme.surface,
borderRadius: BorderRadius.circular(18),
boxShadow: [
BoxShadow(
color: Theme.of(context).colorScheme.primary,
blurRadius: 3,
offset: const Offset(0,2),
),
],
),
child: Row(
children: [
Container(
padding: const EdgeInsets.all(10),
decoration: BoxDecoration(
color: Theme.of(context).colorScheme.primary.withOpacity(.2),
borderRadius: BorderRadius.circular(12),
),
child: Icon(
Icons.school_rounded,
color: Theme.of(context).colorScheme.primary,
),
),
const SizedBox(width: 14),
Expanded(
child: Column(
crossAxisAlignment:
CrossAxisAlignment.start,
children: [
Text(

item['name']!,
maxLines: 1,
overflow:
TextOverflow.ellipsis,
style:  TextStyle(
  color: Theme.of(context).colorScheme.primary,
fontWeight: FontWeight.bold,
fontSize: 16,
),
),
const SizedBox(height: 4),
Text(
item['location'] ?? '',
maxLines: 1,
overflow:
TextOverflow.ellipsis,
style: TextStyle(
  color: Theme.of(context).colorScheme.outlineVariant,

),
),
],
),
),
Icon(
Icons.favorite,
color: Theme.of(context)
    .colorScheme
    .error,
)
    .animate(
onPlay: (controller) =>
controller.repeat(
reverse: true),
)
.scale(
begin:
const Offset(1.4, 1.4),
end: const Offset(1, 1),
duration: 900.ms,
),
],
),
),
),
),
)
    .animate()
    .fadeIn(
duration: 600.ms,
delay: (index * 100).ms,
)
    .slideY(
begin: 0.3,
end: 0,
curve: Curves.easeOutQuart,
),
);
},
),
),
);
}
}