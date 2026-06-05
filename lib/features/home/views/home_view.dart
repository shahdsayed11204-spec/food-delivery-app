import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../products/view/products_details.dart';
import '../widgets/cart.dart';
import '../widgets/categoris.dart';
import '../widgets/search_home.dart';
import '../widgets/uesr_header.dart';


class HomeView extends StatefulWidget {
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final List<String> categories = ['All', 'Sliders', 'Combos', 'Classic'];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 11.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap(60),
                   UesrHeader(),
                    Gap(20),
                    SearchHome(),
                    Gap(20),
                   HomeCategoris(selectedIndex: selectedIndex, categories: categories),
                    Gap(10),
                  ],
                ),
              ),
            ),
            SliverPadding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 8.0),
              sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    childCount: 6,
                        (context,index)=>GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductsDetails()),);
                          },
                          child: CardItem(
                          image: 'assets/test/test.png',
                          text:  'Cheeseburger',
                          desc: 'Wendy"s Burger',
                          rate: '4.9'
                                              ),
                        ),
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    childAspectRatio: 0.72,
                    mainAxisSpacing: 2,
                  ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//child: Padding(
//         padding:  EdgeInsets.symmetric(horizontal: 10),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Gap(60),
//               Row(
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SvgPicture.asset(
//                         'assets/logo/logo.svg',
//                         color: AppColors.primaryColor,
//                         height: 35,
//                       ),
//                       const Gap(10),
//                       CustomText(
//                         text: 'Hello, Shahd Sayed',
//                         color: Colors.grey.shade500,
//                         font: FontWeight.w700,
//                         size: 15,
//                       ),
//                     ],
//                   ),
//                   const Spacer(),
//                   CircleAvatar(
//                     radius: 30,
//                     backgroundColor: Colors.grey.shade200,
//                     child: Icon(
//                       CupertinoIcons.person,
//                       color: AppColors.primaryColor,
//                     ),
//                   ),
//                 ],
//               ),
//              Gap(20),
//               Material(
//                 elevation: 5,
//                 borderRadius: BorderRadius.circular(30),
//                 child: TextFormField(
//                   decoration: InputDecoration(
//                     prefixIcon: Icon(CupertinoIcons.search),
//                     hintText: 'Search...',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(30),
//                       borderSide: BorderSide.none,
//                     ),
//                     filled: true,
//                     fillColor: Colors.white,
//                   ),
//                 ),
//               ),
//              Gap(20),
//               SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 physics: BouncingScrollPhysics(),
//                 child: Row(
//                   children: List.generate(categories.length, (index) {
//                     return GestureDetector(
//                       onTap: () {
//                         setState(() => selectedIndex = index);
//                       },
//                       child: AnimatedContainer(
//                         duration: Duration(milliseconds: 300),
//                         margin: EdgeInsets.only(right: 8),
//                         padding: EdgeInsets.symmetric(horizontal: 27, vertical: 15),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(20),
//                           color: selectedIndex == index
//                               ? AppColors.primaryColor
//                               : Color(0xffF3F4F6),
//                         ),
//                         child: CustomText(
//                           text: categories[index],
//                           font: FontWeight.w600,
//                           color: selectedIndex == index
//                               ? Colors.white
//                               : Colors.black,
//                         ),
//                       ),
//                     );
//                   }),
//                 ),
//               ),
//               Gap(20),
//               GridView.builder(
//                 physics: NeverScrollableScrollPhysics(),
//                 shrinkWrap: true,
//                 padding: EdgeInsets.zero,
//                   itemCount: 6,
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                     childAspectRatio: 0.70,
//                     mainAxisSpacing: 2,
//                   ),
//                   itemBuilder: (context, index) =>CardItem(
//                       image: 'assets/test/test.png',
//                       text:  'Cheeseburger',
//                       desc: 'Wendy"s Burger',
//                       rate: '4.9'
//                   ) ,
//               ),
//
//
//             ],
//           ),
//         ),
//       ),
