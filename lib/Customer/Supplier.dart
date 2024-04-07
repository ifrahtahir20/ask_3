// Container(
//   padding: EdgeInsets.only(top: 5, bottom: 5),
//   constraints: BoxConstraints(maxWidth: double.infinity),
//   height: 100,
//   color: Colors.cyan.shade50,
//   child: Row(
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: [
//       TextButton(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) =>
//                     AddCustomerSupplierScreen(isCustomer: true)),
//           );
//         },
//         child: Text(
//           "Add Customer",
//           style: TextStyle(fontSize: 22, color: Colors.white),
//         ),
//         style: TextButton.styleFrom(
//           minimumSize: Size(150, 60),
//           backgroundColor: Color(0xFF4CBB17),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(15),
//           ),
//         ),
//       ),
//       SizedBox(
//         width: 10,
//       ),
//       TextButton(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => AddCustomerSupplierScreen(
//                       isCustomer: false,
//                     )),
//           );
//         },
//         child: Text(
//           "Add Supplier",
//           style: TextStyle(fontSize: 22, color: Colors.white),
//         ),
//         style: TextButton.styleFrom(
//           minimumSize: Size(150, 60),
//           backgroundColor: Colors.orange.shade700,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(15),
//           ),
//         ),
//       ),
//     ],
//   ),
// ),
