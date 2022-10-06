import 'package:flutter/material.dart';

class BookRide extends StatefulWidget {
  const BookRide({Key? key}) : super(key: key);

  @override
  State<BookRide> createState() => _BookRideState();
}

class _BookRideState extends State<BookRide> {
  double initialChildSize = 0.6;
  double minChildSize = 0.4;
  double maxChildSize = 0.95;

  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return makeDismissible(
      child: DraggableScrollableSheet(
          initialChildSize: initialChildSize,
          minChildSize: minChildSize,
          maxChildSize: maxChildSize,
          builder: (_, controller) => Container(
            decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20.0))),
            child: ListView(
              controller: controller,
              children: [
                // Container(
                //   margin: const EdgeInsets.only(
                //       left: 10.0, right: 10.0, top: 20.0),
                //   padding: const EdgeInsets.symmetric(horizontal: 10.0),
                //   width: MediaQuery.of(context).size.width,
                //   child: TextField(
                //     controller: _controller,
                //     decoration: InputDecoration(
                //       alignLabelWithHint: true,
                //       labelText: 'Caption',
                //       labelStyle: const TextStyle(
                //         color: Colors.black87,
                //       ),
                //       isDense: false,
                //       filled: true,
                //       fillColor: Colors.white30,
                //       border: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(10.0),
                //       ),
                //       focusedBorder: OutlineInputBorder(
                //           borderSide:
                //           BorderSide(color: Colors.deepPurple.shade900),
                //           borderRadius: BorderRadius.circular(10.0)),
                //     ),
                //     onChanged: (message) {
                //       announcementMessage = message;
                //     },
                //     minLines: 1,
                //     maxLines: 1,
                //   ),
                // ),
                // if (image != null)
                //   Center(
                //     child: Stack(
                //       children: [
                //         Container(
                //           margin: const EdgeInsets.only(
                //               top: 20.0, left: 20.0, right: 20.0),
                //           child: Image.file(
                //             image!,
                //             // width: 200,
                //             height: 200,
                //           ),
                //         ),
                //         IconButton(
                //             onPressed: () {
                //               setState(() {
                //                 image = null;
                //               });
                //             },
                //             icon: Container(
                //                 decoration: BoxDecoration(
                //                     color: Colors.grey.shade200,
                //                     borderRadius:
                //                     BorderRadius.circular(20.0)),
                //                 // color: Colors.black,
                //                 child: const Icon(
                //                   Icons.cancel_sharp,
                //                   color: Colors.redAccent,
                //                   size: 20.0,
                //                 )))
                //       ],
                //     ),
                //   ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                //   children: [
                //     Expanded(
                //       child: ListTile(
                //         title: Container(
                //           margin:
                //           const EdgeInsets.only(left: 5.0, top: 20.0),
                //           child: Row(
                //             children: const [
                //               Icon(
                //                 Icons.add_photo_alternate_rounded,
                //                 color: Color(0xff25C9D1),
                //                 size: 30,
                //               ),
                //               SizedBox(
                //                 width: 10.0,
                //               ),
                //               Text(
                //                 'Add Photo',
                //                 style: TextStyle(
                //                     fontSize: 18,
                //                     fontWeight: FontWeight.bold),
                //               ),
                //             ],
                //           ),
                //         ),
                //         onTap: () => pickImage(ImageSource.gallery),
                //       ),
                //     ),
                //     Expanded(
                //       child: ListTile(
                //         title: Container(
                //           margin:
                //           const EdgeInsets.only(left: 5.0, top: 10.0),
                //           child: Row(
                //             children: const [
                //               Icon(
                //                 Icons.add_a_photo,
                //                 color: Color(0xff25C9D1),
                //                 size: 30,
                //               ),
                //               SizedBox(
                //                 width: 10.0,
                //               ),
                //               Text(
                //                 'Take Photo',
                //                 style: TextStyle(
                //                     fontSize: 18,
                //                     fontWeight: FontWeight.bold),
                //               ),
                //             ],
                //           ),
                //         ),
                //         onTap: () => pickImage(ImageSource.camera),
                //       ),
                //     ),
                //   ],
                // ),
                // Container(
                //   height: 50.0,
                //   width: MediaQuery.of(context).size.width,
                //   margin: const EdgeInsets.only(
                //       top: 30.0, left: 10.0, right: 10.0),
                //   child: ElevatedButton(
                //     onPressed: isButtonEnabled? () {
                //       announcementMessage = announcementMessage.trim();
                //       if (image != null) {
                //         setState(() {
                //           postButtonChild = const CircularProgressIndicator();
                //           _controller.clear();
                //           isButtonEnabled = false;
                //         });
                //         post();
                //       }else{
                //         Get.snackbar(
                //             'Error',
                //             'Image Not Selected!',
                //             snackPosition: SnackPosition.BOTTOM,
                //             backgroundColor: Colors.red,
                //             colorText: Colors.black
                //         );
                //       }
                //     }:null,
                //     style: ButtonStyle(
                //       backgroundColor:
                //       MaterialStateProperty.all(Colors.white),
                //     ),
                //     child: Center(
                //       child: postButtonChild,
                //     ),
                //   ),
                // ),
              ],
            ),
          )),
    );
  }

  Widget makeDismissible({required Widget child}) => GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: () => Navigator.pop(context),
    child: GestureDetector(
      onTap: () {},
      child: child,
    ),
  );
}
