// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ccdu extends StatefulWidget {
  const ccdu({Key? key}) : super(key: key);

  @override
  State<ccdu> createState() => ccduState();
}
class ccduState extends State<ccdu>{


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          colorSchemeSeed: const Color(0xff6750a4), useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(title: const Text('CCDU'), backgroundColor: Color(0xff003b5c),),
        body: Column(
          children: const <Widget>[
            //Spacer(),
            Appoitment1(),
            Appoitment2(),
            Appoitment3(),
            Appoitment4(),
            //Spacer(),
          ],
        ),
      ),
    );
  }
}

class Appoitment1 extends StatelessWidget {
  const Appoitment1({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Card(
        child: SizedBox(
          width: 350,
          height: 170,
          child:Text(''' Date: 06/10/2022
 Time: 09h:00
 Student name: Khotsofalang
 Description: Course is chowing me
 ''''',style: TextStyle(fontSize: 20),),
          // style: TextStyle(fontSize: 16),),
        ),
      ),
    );
  }
}

class  Appoitment2 extends StatelessWidget {
  const  Appoitment2({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        //elevation: 0,
        //color: Theme.of(context).colorScheme.surfaceVariant,
        child: const SizedBox(
          width: 350,
          height: 170,
          child: Text(''' Date: 12/01/2022
 Time: 10h: 30
 Student name: khotsos
 Descprption: its tough
 ''''',style: TextStyle(fontSize: 20),),
          // style: TextStyle(fontSize: 16),),
        ),
      ),
    );
  }
}

class  Appoitment3 extends StatelessWidget {
  const  Appoitment3({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        //elevation: 0,
        //color: Theme.of(context).colorScheme.surfaceVariant,
        child: const SizedBox(
          width: 350,
          height: 170,
          child: Text(''' Date: 08/10/2022
 Time: 11h:00
 Student name: Tsunyane
 Descprption: mxm
 ''''',style: TextStyle(fontSize: 20),),
          // style: TextStyle(fontSize: 16),),
        ),
      ),
    );
  }
}

class  Appoitment4 extends StatelessWidget {
  const  Appoitment4({super.key});

  @override
  Widget build(BuildContext context) {


    return Center(
      child: Card(
        //elevation: 0,
        //color: Theme.of(context).colorScheme.surfaceVariant,
        child: const SizedBox(
          width: 350,
          height: 170,
          child: Text(''' Date: 07/10/2022
 Time: 13h:00
 Student name: khotso
 Descprption: bla bla bla bla
  ''''',style: TextStyle(fontSize: 20),),
          // style: TextStyle(fontSize: 16),),
        ),

      ),
    );
  }
}


//     return Scaffold(
//         appBar: AppBar(title: const Text('CCDU'), backgroundColor: Color(0xff003b5c),),
//          body : Card(
//       clipBehavior: Clip.antiAlias,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(24),
//       ),
//       child: Column(
//         children: [
//           Stack(
//             children: [
//               Ink.image(
//                 image: NetworkImage(
//                   'https://www.iconsdb.com/icons/preview/white/rounded-rectangle-xxl.png',
//                 ),
//                 height: 240,
//                 fit: BoxFit.cover,
//               ),
//               Positioned(
//                 bottom: 16,
//                 right: 16,
//                 left: 16,
//                 child: Text(
//                   'Appoitment1',
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     color: Colors.blue,
//                     fontSize: 24,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           Padding(
//             padding: EdgeInsets.all(16).copyWith(bottom: 0),
//             child: Text(
//               ''''date:
//                   time:
//                   student name:
//                   descprption:
//                 ''''',style: TextStyle(fontSize: 16),
//               //style: TextStyle(fontSize: 16),
//             ),
//           ),
//           ButtonBar(
//             alignment: MainAxisAlignment.start,
//             children: [
//               FlatButton(
//                 child: Text('Accept'),
//                 onPressed: () {},
//               ),
//               FlatButton(
//                 child: Text('Reject'),
//                 onPressed: () {},
//               )
//             ],
//           )
//         ],
//       ),
//     )
//     );
//
//   }
// }


