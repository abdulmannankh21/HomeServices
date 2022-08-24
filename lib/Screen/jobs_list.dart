import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class JobsList extends StatefulWidget {
  const JobsList({Key? key}) : super(key: key);

  @override
  State<JobsList> createState() => _JobsListState();
}

class _JobsListState extends State<JobsList> {
  final Stream<QuerySnapshot> studentsStream = FirebaseFirestore.instance
      .collection('job')
      .where('status', isEqualTo: 'pending')
      .where('postedBy', isNotEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 2,
        backgroundColor: Colors.amber,
        title: const Text(
          "Servo",
        ),
      ),
      body: StreamBuilder(
          stream: studentsStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              print('Something went Wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(
                    height: 1,
                    color: Colors.amber,
                  ),
                  itemBuilder: (BuildContext context, i) {
                    return JobPostWidget(
                      size: size,
                      snapshot: snapshot.data!.docs[i],
                    );
                  },
                ),
              );
            } else {
              return Container();
            }
          }),
    );

    /*return StreamBuilder<QuerySnapshot>(
      stream: studentsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          print('Something went Wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final List jobslist = [];
        snapshot.data!.docs.map((DocumentSnapshot document) {
          Map a = document.data() as Map<String, dynamic>;
          jobslist.add(a);
          a['id'] = document.id;
        }).toList();
        for (var i = 0; i < jobslist.length; i++);
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.amber,
              title: const Text(
                "Servo",
              ),
            ),
            body: SingleChildScrollView(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: jobslist.length,
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(height: 1,color: Colors.amber,),
                itemBuilder: (BuildContext context, i) {
                  return Container(
                    height: 80,
                    width: size.width,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(jobslist[i]['job title'], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(jobslist[i]['job discription'])
                      ],
                    ),
                  );
                },
              ),
            ),
          );
      },
    );*/
  }
}

class JobPostWidget extends StatefulWidget {
  JobPostWidget({Key? key, required this.size, required this.snapshot})
      : super(key: key);

  final Size size;
  QueryDocumentSnapshot snapshot;

  @override
  State<JobPostWidget> createState() => _JobPostWidgetState();
}

class _JobPostWidgetState extends State<JobPostWidget> {
  bool _isAcceptedLoading = false;
  bool _isRejectedLoading = false;

  showInSnackBar({required String message, required context}) {
    final snackBar = SnackBar(content: Text(message, style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w700)), elevation: 10, duration: const Duration(seconds: 2), margin: const EdgeInsets.all(16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), behavior: SnackBarBehavior.floating, backgroundColor: Colors.amber.shade50,);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  String chatRoomId(String user1, String user2) {
    if (user1[0].toLowerCase().codeUnits[0] >
        user2.toLowerCase().codeUnits[0]) {
      return "$user1-$user2";
    } else {
      return "$user2-$user1";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 80,
      width: widget.size.width,
      //color: Colors.amber.shade50,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.snapshot['job title'],
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              const Icon(
                Icons.location_on_rounded,
                color: Colors.black26,
                size: 15,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                widget.snapshot['location'],
                style: const TextStyle(
                    fontSize: 12, fontWeight: FontWeight.normal),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Description',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          Container(
            width: widget.size.width,
            padding: const EdgeInsets.all(5),
            child: Text(widget.snapshot['job discription']),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Spacer(),
              /*InkWell(
                onTap:(){
                  setState(() {
                    _isRejectedLoading = !_isRejectedLoading;
                  });
                  widget.snapshot.reference.update({'status' : 'rejected'}).then((value) => print('Ho gya e oye'));

                },
                child: Container(
                  width: widget.size.width / 2.5,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.red.shade200, width: 0.5)),
                  child: Text(
                    'Reject',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.red.shade400),
                  ),
                ),
              ),*/
              _isAcceptedLoading
                  ? Container(
                      width: widget.size.width / 2.5,
                      height: 40,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: Colors.green.shade500, width: 0.5)),
                      child: Container(
                        height: 30,
                        width: 30,
                        child: const CircularProgressIndicator(
                          color: Colors.amber,
                          strokeWidth: 1.5,
                        ),
                      ),
                    )
                  : InkWell(
                      onTap: () async{
                        setState(() {
                          _isAcceptedLoading = !_isAcceptedLoading;
                        });

                        DocumentReference myDoc = FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid);

                        DocumentSnapshot laoshe = await myDoc.get();
                        Map<String, dynamic> maoshe = laoshe.data() as Map<String, dynamic>;

                        DocumentSnapshot otherUserData = await FirebaseFirestore.instance.collection('users').doc(widget.snapshot['postedBy']).get();
                        Map<String, dynamic> otherUserMap = otherUserData.data() as Map<String, dynamic>;

                        if(!maoshe.containsKey('jobAccepted') && maoshe['jobAccepted'] != true){
                          String chatId = '';
                          chatId = chatRoomId(FirebaseAuth.instance.currentUser!.uid, widget.snapshot['postedBy']);
                          await myDoc.set({
                            'jobAccepted' : true,
                            'acceptedJobId' : widget.snapshot['id'],
                            'jobPostedBy' : widget.snapshot['postedBy'],
                            'chatId' : chatId
                          }, SetOptions(merge: true));

                          await otherUserData.reference.set({
                            'chatId' : chatId
                          }, SetOptions(merge: true));
                          await widget.snapshot.reference.update({'status' : 'accepted'}).then((value) => print('Ho gya e oye'));
                        }else{
                          showInSnackBar(context: context, message: "You can't select more than one jobs.");
                        }
                      },
                      child: Container(
                        width: widget.size.width / 2.5,
                        height: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: Colors.green.shade500, width: 0.5)),
                        child: Text(
                          'Accept',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.green.shade400),
                        ),
                      ),
                    ),
            ],
          ),
        ],
      ),
    );
  }
}
