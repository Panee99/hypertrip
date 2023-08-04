part of '../view.dart';

AppBar _buildAppBar(BuildContext context) {
  return AppBar(
    leading: BackButton(onPressed: () {
      Navigator.of(context).pop();
    }),
    title: Text(
      label_incurred_costs,
      style:
          Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white),
    ),
  );
}