import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:room_finder_flutter/components/discovery/nearby_places_component.dart';
import 'package:room_finder_flutter/utils/RFWidget.dart';

import '../../bloc/nearby/nearby_bloc.dart';
import '../../bloc/nearby/nearby_event.dart';
import '../../data/repositories/repositories.dart';

class NearbyYou extends StatefulWidget {
  final String category;
  const NearbyYou({super.key, required this.category});

  @override
  State<NearbyYou> createState() => _NearbyYouState();
}

class _NearbyYouState extends State<NearbyYou> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            PlaceBloc(RepositoryProvider.of<FoursquareRepository>(context))
              ..add(LoadPlaceEvent()),
        child: Scaffold(
          appBar: commonAppBarWidget(context,
              title: widget.category, showLeadingIcon: true),
          body: NearbyPlacesComponent(category: widget.category),
        ));
  }
}
