import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert' as convert;
import 'package:teravell_app/Model/Currency.dart';
import 'dart:developer'as developer;

void main() {
  runApp(Currencyapp());
}

class Currencyapp extends StatelessWidget {
  const Currencyapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('fa'), // فارسی
      ],

      theme: ThemeData(
        textTheme: TextTheme(
          headlineLarge: TextStyle(
            fontFamily: 'dana',
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
          headlineSmall: TextStyle(
            fontFamily: 'dana',
            fontSize: 14,
            fontWeight: FontWeight.w300,
          ),
          bodyLarge: TextStyle(
            fontFamily: 'dana',
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
          bodySmall: TextStyle(
            fontFamily: 'dana',
            fontSize: 13,
            fontWeight: FontWeight.w300,
          ),
          titleLarge: TextStyle(
            fontFamily: 'dana',
            fontSize: 16,
            fontWeight: FontWeight.w300,
          ),
          titleSmall: TextStyle(
            fontFamily: 'dana',
            fontSize: 14,
            fontWeight: FontWeight.w300,
            color: Colors.red,
          ),
        ),
      ),

      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Currency> currency = [];

  //get_requset
  Future getapi(BuildContext content) async{
    var url =
        'https://sasansafari.com/flutter/api.php?access_key=flutter123456';

    var onValue =await http.get(Uri.parse(url));
      if(currency.isEmpty){
        developer.log(onValue.statusCode.toString(),name: "statuse code");

          
          if (onValue.statusCode == 200) {
            
            List jsonlist = convert.jsonDecode(onValue.body);
            _showsnackbar(context, 'بروز شد');
            if (jsonlist.length > 0) {
              
                setState(() {
                  
                  for (int i = 0; i < jsonlist.length; i++) {
                  currency.add(
                    Currency(
                      id: jsonlist[i]['id'],
                      title: jsonlist[i]['title'],
                      price: jsonlist[i]['price'],
                      changes: jsonlist[i]['changes'],
                      status: jsonlist[i]['status'],
                    ),
                  );
                }
                });
              
            }
        }


      }
    
    return onValue;

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getapi(context);
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 243, 243, 243),
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          SizedBox(width: 12),
          Image.asset('assets/images/icon.png'),
          SizedBox(width: 12),
          Text('قیمت به‌روز ارز', style: Theme.of(context).textTheme.bodyLarge),
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Image.asset('assets/images/2976215.png'),
            ),
          ),
          SizedBox(width: 12),
        ],
      ),
      body:SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Image.asset('assets/images/752675.png'),
                    SizedBox(width: 8),
                    Text(
                      'نرخ ارز آزاد چیست؟ ',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Text(
                  ' نرخ ارزها در معاملات نقدی و رایج روزانه است معاملات نقدی معاملاتی هستند که خریدار و فروشنده به محض انجام معامله، ارز و ریال را با هم تبادل می نمایند.',
                  style: Theme.of(context).textTheme.bodySmall,
                  
                ),
                SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1000),
                    color: Color.fromARGB(255, 130, 130, 130),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'نام آزاد ارز',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Text(
                        'قیمت ',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Text(
                        'تغییر',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12,),
                //list
                futurebuilderapi(context),
                SizedBox(height: 20,),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1000),
                    color: Color.fromARGB(255, 232, 232, 232)
                  ),
                  //btn
                  child: Row(
                  
                    children: [
                      SizedBox(
                        height: 50,
                        child: TextButton.icon(
                          onPressed: (){

                            currency.clear();
                            futurebuilderapi(context);

                          },
                          label: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('بروزرسانی',style: Theme.of(context).textTheme.titleLarge,),
                          ),
                          icon: Icon(CupertinoIcons.refresh_thin,size: 25),
                          style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(
                            Color.fromARGB(255, 209, 193, 255)
                          )),
                        ),
                      ),
                      
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0,0,30,0),
                        child: Text('آخرین بروز رسانی ${_gettime()} ',style: Theme.of(context).textTheme.bodySmall,),
                      )
                  
                    ],
                  
                  ),
                )
              ],

            ),
          ),
      ),
      
    );
  }
  

  FutureBuilder<dynamic> futurebuilderapi(BuildContext context) {
    return FutureBuilder(

                builder: (context, snapshot) {
                  
                  developer.log(snapshot.toString(),name: 'logcat');

                  return snapshot.hasData ? 
                    Container(
                      height: 370,
                      decoration: BoxDecoration(),
                      child: ListView.builder(
                        itemCount: currency.length,
                        physics: AlwaysScrollableScrollPhysics(),
            
                        itemBuilder: (context, index) {
                          
                          return ListItem(currency: currency,index: index,);
                        },
                      ),
                    ) :Center(child: CircularProgressIndicator());

                },
                future: getapi(context),


              );
  }
  
  String _gettime() {

    DateTime now= DateTime.now();

    return DateFormat('kk:mm:ss').format(now);
  }
}

void _showsnackbar(BuildContext context,String msg){

  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text(msg,
  style: TextStyle(color: Colors.green,fontSize: 15)),backgroundColor: Colors.black,
  ));


}

class ListItem extends StatelessWidget {
  List<Currency> currency;
  int index;
  ListItem({required this.currency,required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5,10,5,0),
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(1000),
          boxShadow: <BoxShadow>[BoxShadow(color: Colors.white, blurRadius: 2.0)],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              currency[index].title!,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(
              getfarsinumber(currency[index].price.toString()),
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(
              getfarsinumber(currency[index].changes.toString()),
              style:
                  currency[index].status == 'n'
                      ? Theme.of(context).textTheme.titleSmall
                      : TextStyle(color: Colors.green),
            ),
          ],
        ),
      ),
    );
  }
  
}
String getfarsinumber(String number){

  List en= ['0','1','2','3','4','5','6','7','8','9'];
  List fa= ['۰','۱','۲','۳','۴','۵','۶','۷','۸','۹'];

  en.forEach((action){

    number= number.replaceAll(action, fa[en.indexOf(action)]);

  });


  return number;

}