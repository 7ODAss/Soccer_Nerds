import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_app/features/list_of_match/presentation/component/widgets/livematch_details_shared/event_icon.dart';
import '../../../../core/utils/enums.dart';
import '../controller/live_match_details_bloc.dart';

class LiveMatchDetailsComponent extends StatelessWidget {
  const LiveMatchDetailsComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LiveMatchDetailsBloc, LiveMatchDetailsState>(
      buildWhen: (previous, current) =>
      previous.liveMatchDetailsState != current.liveMatchDetailsState,
      builder: (context, state) {
        switch (state.liveMatchDetailsState) {
          case RequestState.loading:
            return const Center(child: CircularProgressIndicator());
          case RequestState.error:
            return Center(child: Column(
              children: [
                Icon(Icons.error,size: 100,),
                Text(state.liveMatchDetailsMessage,style: TextStyle(fontSize: 25),),
              ],
            ));
          case RequestState.success:
            if(state.liveMatchDetails.isEmpty) {
              return Icon(Icons.sports_soccer, color: Colors.grey,size: 100,);
            } if (state.liveMatchDetails.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.hourglass_empty, color: Colors.grey, size: 60),
                    SizedBox(height: 10),
                    Text("No events have occurred yet."),
                  ],
                ),
              );
            } else {
              return ListView.builder(
                itemCount: state.liveMatchDetails.length,
                itemBuilder: (context, index) {
                  final details = state.liveMatchDetails[index];
                  return Padding(
                    padding: EdgeInsets.all(10),
                    child: EventIcon(details: details,),
                  );
                },
              );
            }
        }
      },
    );
  }
}
