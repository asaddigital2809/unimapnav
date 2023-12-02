import 'package:flutter/material.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({super.key});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
           children: [
             //create news feed container like facebook
             for(int i=0;i<5;i++)
             Padding(
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
                        //readmore functionality
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec euismod, nisl eget aliquam ultricies, nunc nisl ultricies nunc, quis aliquet nisl nis'),),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network('https://picsum.photos/250?image=9',height: 150,width: double.infinity,fit: BoxFit.fill,)),
                        ),
                        const Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                radius: 15,
                                backgroundImage: AssetImage('assets/images/profile.png'),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('John Doe'),
                                Text('2 hours ago'),
                              ],
                            ),
                          ],
                                     ),
                      ],
                    ),)
               ),
             ),
           ],
          ),
        ),
      ),
    );
  }
}
