 import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constant.dart';
import '../screens/institute_details.dart';
import '../providers/favorites_provider.dart';

Widget instituteCard({
required BuildContext context,
required WidgetRef ref,
required String name,
required String location,
required String rating,
required String image,
}) {
final favorites = ref.watch(favoritesProvider);
final isFav = favorites.any((e) => e['name'] == name);

return InkWell(
onTap: () {
Navigator.push(
context,
MaterialPageRoute(
builder: (context) => const InstituteDetailsScreen(),
),
);
},
child: Container(
margin: const EdgeInsets.only(bottom: 18),
decoration: BoxDecoration(
color: Colors.white,
borderRadius: BorderRadius.circular(24),
boxShadow: [
BoxShadow(
color: Theme.of(context).colorScheme.primary,
blurRadius: 4,
offset: const Offset(0, 3),
)
],
),
child: Row(
children: [

/// IMAGE
ClipRRect(
borderRadius: const BorderRadius.horizontal(
right: Radius.circular(24),
),
child: Image.network(
image,
width: 120,
height: 120,
fit: BoxFit.cover,
),
),
SizedBox(width: 5,),
Expanded(
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [

/// NAME + FAVORITE BUTTON
Row(
children: [
Expanded(
child: Text(
name,
maxLines: 1,
overflow: TextOverflow.ellipsis,
style: const TextStyle(
fontSize: 20,
fontWeight: FontWeight.bold,
),
),
),

IconButton(
onPressed: () {
ref
    .read(favoritesProvider.notifier)
    .toggle({
"name": name,
"location": location,
"rating": rating,
"image": image,
});
},
icon: Icon(
isFav
? Icons.favorite
    : Icons.favorite_border,
color: Theme.of(context).colorScheme.error,
),
),
],
),

const SizedBox(height: 5),

Row(
children: [
 Icon(
Icons.location_on,
size: 18,
color: Theme.of(context).colorScheme.outlineVariant,
),
const SizedBox(width: 6),
Expanded(
child: Text(
location,
maxLines: 1,
overflow: TextOverflow.ellipsis,
style:  TextStyle(
color:  Theme.of(context).colorScheme.outlineVariant,
),
),
),
],
),

const SizedBox(height: 10),

Row(
children: [
Icon(
Icons.star,
color: gold,
size: 20,
),
const SizedBox(width: 5),
Text(
rating,
style: const TextStyle(
fontWeight: FontWeight.bold,
),
),
],
),
],
),
),
],
),
),
);
}