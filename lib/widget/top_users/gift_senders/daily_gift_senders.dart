import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:provider/provider.dart';
import '../../../provider/top_users_provider.dart';
import '../../../view/user_profile.dart';
import '../../follow_button.dart';

class DailyGiftSenders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TopUsersProvider>(builder: (context, topusers, child) {
      return Conditional.single(
        context: context,
        conditionBuilder: (context) => topusers.todayTopUsers != null,
        fallbackBuilder: (context) =>
            Center(child: CircularProgressIndicator()),
        widgetBuilder: (context) => Conditional.single(
          context: context,
          conditionBuilder: (context) => topusers.todayTopUsers.data.isNotEmpty,
          fallbackBuilder: (context) => Center(child: Text("No Top Users")),
          widgetBuilder: (context) => ListView.separated(
              itemCount: topusers.todayTopUsers.data.length,
              separatorBuilder: (context, index) => SizedBox(height: 5),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserProfile(
                                  user:
                                      topusers.todayTopUsers.data[index].user)),
                        );
                      },
                      child: Card(
                          child: ListTile(
                        title: Row(
                          children: [
                            Column(
                              children: [
                                Text(
                                  topusers.todayTopUsers.data[index].user.name,
                                ),
                                Text(
                                    'تم الدعم ب ${topusers.yearlyTopUsers.data[index].value} ماسه ')
                              ],
                              crossAxisAlignment: CrossAxisAlignment.start,
                            ),
                          ],
                        ),
                        trailing: FollowButton(
                          following: topusers
                              .todayTopUsers.data[index].user.followers[index],
                        ),
                        leading: Container(
                          width: 60,
                          height: 60,
                          child: Image.network(
                            topusers.todayTopUsers.data[index].user.image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )),
                    ),
                  ],
                );
              }),
        ),
      );
    });
  }
}
