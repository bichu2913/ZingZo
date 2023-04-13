
import 'package:flutter/material.dart';
import 'package:music_player/screens/favourite.dart';

import 'package:music_player/screens/miniscreen.dart';
import 'package:music_player/screens/mostplayed.dart';

import 'package:music_player/screens/search.dart';


import 'package:readmore/readmore.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});


  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    const drawerHeader = UserAccountsDrawerHeader(
     
      decoration: BoxDecoration(
        
  color: Colors.black,
  ),
      
      accountName: Text('User Name'),
      accountEmail: Text('user.name@email.com'),
      
      
    );
    final drawerItems = ListView(
      children: <Widget>[
        const SizedBox(),
        ListTile(
          title: const Text('Terms and Condition'),
          
          onTap: () => Navigator.of(context).push(_Add(1)),
        ),
        ListTile(
          title: const Text('privacy policy'),
         onTap: () => Navigator.of(context).push(_Add1(1)),
        ),
        
        
      ],
    );
    final height1 = MediaQuery.of(context).size.height;
    final width1 = MediaQuery.of(context).size.width;
    return Scaffold(
      bottomSheet: const MiniPlayer(),
      
       backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Where words fail, It Starts"),
        actions: [
          IconButton(onPressed:()=>Navigator.of(context).push(MaterialPageRoute(builder: (context) =>const Search())), icon: const Icon(Icons.search))
        ],
        
         
      ),
      body: Container(
    width: width1*1,
    height: height1*1,
    color: const Color.fromARGB(255, 0, 0, 0),
    
    child: Column(
      children: [
        const SizedBox(height: 10,),
                Container(
    width: width1*0.95 ,
    height: height1*0.60  ,
    decoration: const BoxDecoration(
    image: DecorationImage(
      fit: BoxFit.fill,
      image: AssetImage('assets/images/images.jpg'),
    ),
    ),
    ),
    const SizedBox(height: 20 ,),
    Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    
                children: <Widget>[
    
                  InkWell(onTap:() => Navigator.of(context).push(MaterialPageRoute(builder: (context) =>const FavoritePagelist())),
    
    
    
                    child: Container(height:height1*0.17  ,
    
                      width: width1*0.25   ,
    
                                  decoration: const BoxDecoration(
    
                    image: DecorationImage(
    
                                   fit: BoxFit.fill,
    
                                   image: AssetImage('assets/images/Screenshot 2022-12-27 103701.png'),
    
                     ),
    
                     )
    
                    ),
    
                  ),
    
                  InkWell(onTap: () =>Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MosltlyPlayedScreen())),
    
    
    
                    child: Container(height:height1*0.17,
    
                      width: width1*0.25 ,
    
                                  decoration: const BoxDecoration(
    
                    image: DecorationImage(
    
                                   fit: BoxFit.fill,
    
                                   image: AssetImage('assets/images/Screenshot 2022-12-27 103950.png'),
    
                     ),
    
                     )
    
                    ),
    
                  ),
    
                 
    
                ],),
                
                
        
                
                 
      ],
    ),
  ),
      drawer: Drawer(
        child: drawerItems,
      ),
    );
  }
}


class _Add extends MaterialPageRoute<void> {
  _Add(int id)
      : super(
        
        
          builder: (BuildContext context) {
            String content =
      "You should be aware that there are certain things that ZingZo will not take responsibility for. Certain functions of the app will require the app to have an active internet connection. The connection can be Wi-Fi or provided by your mobile network provider, but Bichu B Nadhan cannot take responsibility for the app not working at full functionality if you dont have access to Wi-Fi, and you dont have any of your data allowance left.\nIf you’re using the app outside of an area with Wi-Fi, you should remember that the terms of the agreement with your mobile network provider will still apply. As a result, you may be charged by your mobile provider for the cost of data for the duration of the connection while accessing the app, or other third-party charges. In using the app, you’re accepting responsibility for any such charges, including roaming data charges if you use the app outside of your home territory (i.e. region or country) without turning off data roaming. If you are not the bill payer for the device on which you’re using the app, please be aware that we assume that you have received permission from the bill payer for using the app.\nAlong the same lines, Bichu B Nadhan cannot always take responsibility for the way you use the app i.e. You need to make sure that your device stays charged – if it runs out of battery and you can’t turn it on to avail the Service, Bichu B Nadhan cannot accept responsibility.\nWith respect to Bichu B Nadhan's responsibility for your use of the app, when you’re using the app, it’s important to bear in mind that although we endeavor to ensure that it is updated and correct at all times, we do rely on third parties to provide information to us so that we can make it available to you. Bichu B Nadhan accepts no liability for any loss, direct or indirect, you experience as a result of relying wholly on this functionality of the app.At some point, we may wish to update the app. The app is currently available on Android – the requirements for the system(and for any additional systems we decide to extend the availability of the app to) may change, and you’ll need to download the updates if you want to keep using the app. Bichu B Nadhan does not promise that it will always update the app so that it is relevant to you and/or works with the Android version that you have installed on your device. However, you promise to always accept updates to the application when offered to you, We may also wish to stop providing the app, and may terminate use of it at any time without giving notice of termination to you. Unless we tell you otherwise, upon any termination, (a) the rights and licenses granted to you in these terms will end; (b) you must stop using the app, and (if needed) delete it from your device.";
  String content1 =
      "I may update our Terms and Conditions from time to time. Thus, you are advised to review this page periodically for any changes. I will notify you of any changes by posting the new Terms and Conditions on this page.These terms and conditions are effective as of 2023-04-11";
  String content2 =
      "If you have any questions or suggestions about my Terms and Conditions, do not hesitate to contact me at bichuamz@gmail.com.\nThis Terms and Conditions page was generated by App Privacy Policy Generator";
             final height1 = MediaQuery.of(context).size.height;
             final width1 = MediaQuery.of(context).size.width;
            return Scaffold(
      backgroundColor: Colors.black ,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: width1 * 1,
              height: height1 * 0.10,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: Colors.black26,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: width1 * 0.05,
                            vertical: height1 * 0.02),
                        child: const Text(
                          'Terms and Conditions',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(15),
                      child: ReadMoreText(
                        content,
                        trimLines: 58,
                        textAlign: TextAlign.justify,
                        trimMode: TrimMode.Line,
                        lessStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        moreStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        style: const TextStyle(
                            fontSize: 16, height: 1.5, color: Colors.white),
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: width1 * 0.04,
                        ),
                        const Text(
                          'Changes to This Terms and Conditions',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(15),
                      child: ReadMoreText(
                        content1,
                        trimLines: 58,
                        textAlign: TextAlign.justify,
                        trimMode: TrimMode.Line,
                        lessStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        moreStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        style: const TextStyle(
                            fontSize: 16, height: 1.5, color: Colors.white),
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: width1 * 0.04,
                        ),
                        const Text(
                          'Contact us',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(15),
                      child: ReadMoreText(
                        content2,
                        trimLines: 58,
                        textAlign: TextAlign.justify,
                        trimMode: TrimMode.Line,
                        lessStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        moreStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        style: const TextStyle(
                            fontSize: 16, height: 1.5, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
          },
        );
}
class _Add1 extends MaterialPageRoute<void> {
  _Add1(int id)
      : super(
        
        
          builder: (BuildContext context) {
           String content =
      "Bichu B Nadhan built the ZingZo app as a Free app. This SERVICE is provided by Bichu B Nadhan at no cost and is intended for use as is.This page is used to inform visitors regarding my policies with the collection, use, and disclosure of Personal Information if anyone decided to use my Service.If you choose to use my Service, then you agree to the collection and use of information in relation to this policy. The Personal Information that I collect is used for providing and improving the Service. I will not use or share your information with anyone except as described in this Privacy Policy.\nThe terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which are accessible at Bichu B Nadhan unless otherwise defined in this Privacy Policy.";
  String content1 =
      " For a better experience, while using our Service, I may require you to provide us with certain personally identifiable information, including but not limited to tall man,. The information that I request will be retained on your device and is not collected by me in any way.\nThe app does use third-party services that may collect information used to identify you.";
  String content2 =
      "Cookies are files with a small amount of data that are commonly used as anonymous unique identifiers. These are sent to your browser from the websites that you visit and are stored on your device's internal memory.\nThis Service does not use these “cookies” explicitly. However, the app may use third-party code and libraries that use “cookies” to collect information and improve their services. You have the option to either accept or refuse these cookies and know when a cookie is being sent to your device. If you choose to refuse our cookies, you may not be able to use some portions of this Service.";
  String content3 =
      "If you have any questions or suggestions about my Privacy Policy, do not hesitate to contact me at bichuamz@gmail.com.\nThis privacy policy page was created at privacypolicytemplate.net and modified/generated by App Privacy Policy Generator";
             final height1 = MediaQuery.of(context).size.height;
             final width1 = MediaQuery.of(context).size.width;
            return Scaffold(
            backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: width1 * 1,
              height: height1 * 0.10,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: Colors.black26,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: width1 * 0.05,
                            vertical: height1 * 0.02),
                        child: const Text(
                          'Privacy Policy',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(15),
                      child: ReadMoreText(
                        content,
                        trimLines: 58,
                        textAlign: TextAlign.justify,
                        trimMode: TrimMode.Line,
                        lessStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        moreStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        style: const TextStyle(
                            fontSize: 16, height: 1.5, color: Colors.white),
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: width1 * 0.04,
                        ),
                        const Text(
                          'Information Collection and Use',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(15),
                      child: ReadMoreText(
                        content1,
                        trimLines: 58,
                        textAlign: TextAlign.justify,
                        trimMode: TrimMode.Line,
                        lessStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        moreStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        style: const TextStyle(
                            fontSize: 16, height: 1.5, color: Colors.white),
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: width1 * 0.04,
                        ),
                        const Text(
                          'Cookies',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(15),
                      child: ReadMoreText(
                        content2,
                        trimLines: 58,
                        textAlign: TextAlign.justify,
                        trimMode: TrimMode.Line,
                        lessStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        moreStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        style: const TextStyle(
                            fontSize: 16, height: 1.5, color: Colors.white),
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: width1 * 0.04,
                        ),
                        const Text(
                          'Conatct us',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(15),
                      child: ReadMoreText(
                        content3,
                        trimLines: 58,
                        textAlign: TextAlign.justify,
                        trimMode: TrimMode.Line,
                        lessStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        moreStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        style: const TextStyle(
                            fontSize: 16, height: 1.5, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )
    );
          },
        );
}



