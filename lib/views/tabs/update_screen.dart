import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unimapnav/controllers/updates_controller.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';

import '../../widgets/readmore_text.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({super.key});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  UpdatesController updatesController = Get.put(UpdatesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: RefreshIndicator(
          onRefresh: () async {
            updatesController.getStreamUpdates();
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                StreamBuilder<List<DocumentSnapshot>>(
                  stream: updatesController.stream,
                  // Your stream from UpdatesController
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator(); // Show loading indicator while waiting for data
                    }

                    if (snapshot.hasError) {
                      return Text(
                          'Error: ${snapshot.error}'); // Display error if any
                    }

                    if (!snapshot.hasData) {
                      return const Text(
                          'No data available'); // Display this if no data is available
                    }

                    // Build the UI based on the snapshot data
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        DocumentSnapshot doc = snapshot.data![index];
                        // Build your widget based on DocumentSnapshot
                        // For example:
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Material(
                              elevation: 2,
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white60,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ReadMoreText(
                                          text: doc['description'],
                                          trimLength: 100),
                                    ),
                                    doc['type'] == 'image'
                                        ? Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Image.network(
                                                  doc['url'],
                                                  height: 150,
                                                  width: double.infinity,
                                                  fit: BoxFit.fill,
                                                )),
                                          )
                                        : Container(
                                            margin: const EdgeInsets.all(8.0),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.deepPurple.shade200,
                                            ),
                                            child: ListTile(
                                              title: const Text(
                                                'Document',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              leading: const Icon(
                                                Icons.link,
                                                color: Colors.white,
                                              ),
                                              onTap: () {
                                                launchUrl(Uri.parse(doc['url']
                                                    .toString())); // Open the link in browser
                                                // Open the link in browser
                                              },
                                              trailing: const Icon(
                                                Icons.download,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text('Posted '),
                                          Text(timeago.format(DateTime
                                              .fromMillisecondsSinceEpoch(doc[
                                                      'createdAt']
                                                  .millisecondsSinceEpoch))),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
