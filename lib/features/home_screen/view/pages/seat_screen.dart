import 'package:cat/core/data_base/models/seat_model.dart';
import 'package:cat/core/data_base/my_database.dart';
import 'package:cat/core/general_components/dialog.dart';
import 'package:cat/features/home_screen/viewmodel/seat_cubit/seat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/general_components/ColorHelper.dart';

class SeatScreen extends StatelessWidget {
  const SeatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Seats"),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: BlocProvider(
          create: (context) =>
          SeatCubit()
            ..getSeats(),
          child: BlocBuilder<SeatCubit,SeatState>(
            builder: (context, state) {
              var cubit = SeatCubit.get(context) ;
              if(state is SeatLoading){
                return Center(
                  child: CircularProgressIndicator(),
                );
              }else if(state is SeatSuccess){
                return DefaultTabController(
                    length: 3,
                    child: Scaffold(
                      appBar: TabBar(
                          dividerColor: Colors.transparent,
                          tabAlignment: TabAlignment.start,
                          indicatorColor: ColorHelper.mainColor,
                          labelColor: ColorHelper.mainColor,
                          isScrollable: true,
                          tabs: [
                            Tab(
                              text: "All Seats",
                            ),
                            Tab(
                              text: "Reserved Seats",
                            ),
                            Tab(
                              text: "Empty Seats",
                            )
                          ]
                      ),
                      body: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TabBarView(
                          children: [
                            cubit.allSeats.isNotEmpty ?
                            ListView.separated(
                                itemBuilder: (context, index) {
                                  return Container(
                                    decoration: BoxDecoration(
                                        color: ColorHelper.mainColor,
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: ListTile(
                                      onTap: (){

                                      },
                                      title: Text("Name: ${cubit.allSeats[index].seatName}",style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                      ),),
                                      subtitle: Text("${cubit.allSeats[index].reservedName}",style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                      ),),
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return const Divider();
                                },
                                itemCount: cubit.allSeats.length
                            ):
                            const Center(child: Text("No Seats")),
                            cubit.reservedSeats.isNotEmpty ?
                            ListView.separated(
                                itemBuilder: (context, index) {
                                  return Container(
                                    decoration: BoxDecoration(
                                        color: ColorHelper.mainColor,
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: ListTile(
                                      onTap: (){


                                        DialogUtilities.showMessage(
                                            context,
                                            "Are you sure to unreserved this seat ",
                                            nigaiveActionName: "Yes",
                                            nigaiveAction: () async{
                                               MyDataBase.editSeat(
                                                  SeatModel(
                                                      seatName: cubit.reservedSeats[index].seatName,
                                                      isReserved: false,
                                                      reservedName: ""
                                                  ),
                                              );
                                               cubit.getSeats();
                                            },
                                            posstiveActionName: "Cancel",
                                          posstiveAction: () {
                                            Navigator.pop(context);
                                          },
                                        );
                                      },
                                      title: Text("Name: ${cubit.reservedSeats[index].seatName}",style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                      ),),
                                      subtitle: Text("${cubit.reservedSeats[index].reservedName}",style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                      ),),
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return const Divider();
                                },
                                itemCount: cubit.reservedSeats.length
                            ):
                            const Center(child: Text("No Reserved Seats Available")),
                            cubit.emptySeats.isNotEmpty ?
                            ListView.separated(
                                itemBuilder: (context, index) {
                                  return Container(
                                    decoration: BoxDecoration(
                                        color: ColorHelper.mainColor,
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: ListTile(
                                      onTap: (){

                                      },
                                      title: Text("Name: ${cubit.emptySeats[index].seatName}",style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                      ),),
                                      subtitle: Text("${cubit.emptySeats[index].reservedName}",style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                      ),),
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return const Divider();
                                },
                                itemCount: cubit.emptySeats.length
                            ):
                            const Center(child: Text("No Empty Seat"))
                          ],
                        ),
                      ),
                    )
                );
              }else if(state is SeatError){
                return Center(
                  child: Text(state.message),
                );
              }else{
                return Text("Unknown State");
              }

            },
          ),
        ),
      ),
    );
  }
}
