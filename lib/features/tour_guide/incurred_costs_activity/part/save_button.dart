part of '../view.dart';

class SaveButton extends StatefulWidget {
  const SaveButton({super.key});

  @override
  State<SaveButton> createState() => _SaveButtonState();
}

class _SaveButtonState extends State<SaveButton> {
  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<IncurredCostsActivityCubit>(context);

    return BlocBuilder<IncurredCostsActivityCubit, IncurredCostsActivityState>(
      builder: (context, state) {
        return BlocBuilder<IncurredCostsActivityCubit,
            IncurredCostsActivityState>(
          buildWhen: (previous, current) => previous.isValid != current.isValid,
          builder: (context, state) {
            return ElevatedButton(
              onPressed: state.isValid ? _onPressed : null,
              child: const Text(
                label_incurred_button_save,
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _onPressed() async {
    var cubit = context.read<IncurredCostsActivityCubit>();
    if (await cubit.submit()) Navigator.of(context).pop();
  }
}
