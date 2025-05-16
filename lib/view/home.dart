import 'package:currency/Model/currency_model.dart';
import 'package:currency/controller/controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  final controller = Get.put(Controller());


  late AnimationController animationController;
  late Animation<Offset> animationTitle;
  late Animation<Offset> animationDescription;
  late Animation<Offset> animationIconoffset;



  @override
  void initState() {

    animationController = AnimationController(vsync: this,duration: const Duration(milliseconds: 800));
    animationTitle = Tween<Offset>(begin: const Offset(-1, 0),end: const Offset(0, 0) ).animate(animationController);
    animationDescription = Tween<Offset>(begin: const Offset(1, 0),end: const Offset(0, 0) ).animate(animationController);
    animationIconoffset = Tween<Offset>(begin: const Offset(1, -1),end: const Offset(0, 0) ).animate(animationController);
   
    
    animationController.forward();

    // animationIconoffset.addStatusListener((status){
    //   if(status.isCompleted){
    //     animationController.reverse();
    //   }
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 243, 243),
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          const SizedBox(width: 12),
          Image.asset('assets/images/icon.png'),
          const SizedBox(width: 12),
          Text('قیمت به‌روز ارز', style: textStyle.bodyLarge),
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Image.asset('assets/images/2976215.png'),
            ),
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Obx(
            () => Column(
              children: [
                //title
                Row(
                  children: [
                    Image.asset('assets/images/752675.png'),
                    const SizedBox(width: 8),
                    SlideTransition(position: animationTitle,
                    child: Text('نرخ ارز آزاد چیست؟ ', style: textStyle.bodyLarge)),
                  ],
                ),
                const SizedBox(height: 12),
                //dict
                SlideTransition(
                  position: animationDescription,
                  child: Text(
                    ' نرخ ارزها در معاملات نقدی و رایج روزانه است معاملات نقدی معاملاتی هستند که خریدار و فروشنده به محض انجام معامله، ارز و ریال را با هم تبادل می نمایند.',
                    style: textStyle.bodySmall,
                  ),
                ),
                const SizedBox(height: 12),
                //title_List_container
                SlideTransition(
                  position: animationDescription,
                  child: Container(
                    width: double.infinity,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(1000),
                      color: const Color.fromARGB(255, 130, 130, 130),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('نام آزاد ارز', style: textStyle.headlineSmall),
                        Text('قیمت ', style: textStyle.headlineSmall),
                        Text('تغییر', style: textStyle.headlineSmall),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                //list_Item
                controller.loading.value == false
                    ? Container(
                      height: 370,
                      decoration: const BoxDecoration(),
                      child: ListView.builder(
                        itemCount: controller.listData.length,
                        physics: const AlwaysScrollableScrollPhysics(),

                        itemBuilder: (context, index) {
                          var item = controller.listData[index];

                          return itemList(item, textStyle,index);
                        },
                      ),
                    )
                    : const Center(child: CircularProgressIndicator()),
                const SizedBox(height: 20),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1000),
                    color: const Color.fromARGB(255, 232, 232, 232),
                  ),
                  //btn_bottom_navigation_bar
                  child: Row(
                    children: [
                      SizedBox(
                        height: 50,
                        child: TextButton.icon(
                          onPressed: () {
                            controller.listData.clear();
                            controller.getMthod();
                            
                          },
                          label: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'بروزرسانی',
                              style: textStyle.titleLarge,
                            ),
                          ),
                          icon: const Icon(
                            CupertinoIcons.refresh_thin,
                            size: 25,
                          ),
                          style: const ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(
                              Color.fromARGB(255, 209, 193, 255),
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
                        child: Text(
                          'آخرین بروز رسانی ${_gettime()} ',
                          style: textStyle.bodySmall,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding itemList(CurrencyModel item, TextTheme textStyle,index) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(1000),
          boxShadow: const <BoxShadow>[
            BoxShadow(color: Colors.black12, blurRadius: 2.0),
            
          ],
          
          
          image: DecorationImage(
            image: NetworkImage(item.image!,scale: 2),
            fit: BoxFit.contain,
            alignment: Alignment.centerRight,
            
            
          ),
          shape: BoxShape.rectangle,
      
          border: Border.all(color: Colors.blue,width: 2,style: BorderStyle.solid)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(item.id!, style: textStyle.headlineSmall),
            Text(
              '${item.currentPrice} \$',
              style: const TextStyle(color: Colors.blue,fontSize: 12,fontWeight: FontWeight.w700),
            ),
            Text(
              '${item.athChangePercentage}%',
              style:
                  item.athChangePercentage! < 0
                          
                      ? textStyle.titleSmall
                      : const TextStyle(color: Colors.green,fontSize: 12,fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }

  String _gettime() {
    DateTime now = DateTime.now();

    return DateFormat('kk:mm:ss').format(now);
  }
}
