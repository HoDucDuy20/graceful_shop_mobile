import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:graceful_shop/object/product_object.dart';
import 'package:graceful_shop/resources/utils/colors.dart';
import 'package:graceful_shop/resources/utils/dimensions.dart';
import 'package:graceful_shop/resources/widgets/grid_view.dart';
import 'package:html/dom.dart' as dom;
import 'package:url_launcher/url_launcher.dart';

class AdvertiseDetail extends StatefulWidget {
  const AdvertiseDetail({Key? key}) : super(key: key);

  @override
  State<AdvertiseDetail> createState() => _AdvertiseDetailState();
}

class _AdvertiseDetailState extends State<AdvertiseDetail> {
  List<ProductObject> lstProduct = [
    ProductObject('Áo cổ rộng gợi cảm', 'assets/images/img_2.jpg', 250000, 20),
    ProductObject('Áo cổ rộng gợi cảm', 'assets/images/img_2.jpg', 250000, 20),
    ProductObject('Áo cổ rộng gợi cảm', 'assets/images/img_2.jpg', 250000, 20),
    ProductObject('Áo cổ rộng gợi cảm', 'assets/images/img_2.jpg', 250000, 20),
    ProductObject('Áo cổ rộng gợi cảm', 'assets/images/img_2.jpg', 250000, 20),
    ProductObject('Áo cổ rộng gợi cảm', 'assets/images/img_2.jpg', 250000, 20),
  ];

  void _launchUrl(String url) async {
    Uri _url = Uri.parse(url);
    // ignore: avoid_print
    print(_url);
    if (!await launchUrl(_url)) throw 'Could not launch $_url';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: Dimensions.h250,
              padding: EdgeInsets.only(
                  left: Dimensions.w15,
                  right: Dimensions.w15,
                  top: Dimensions.h20),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/img_1.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(100.0),
                      ),
                      color: AppColors.whiteColor,
                    ),
                    child: Icon(
                      Icons.chevron_left,
                      size: Dimensions.font30,
                      color: AppColors.black2Color,
                    ),
                  ),
                ),
                trailing: InkWell(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.all(Dimensions.w5),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(100.0),
                      ),
                      color: AppColors.whiteColor,
                    ),
                    child: Icon(
                      Icons.share_rounded,
                      size: Dimensions.font20,
                      color: AppColors.black2Color,
                    ),
                  ),
                ),
              ),
            ),
            Html(
              data: """<head>
            <meta http-equiv=Content-Type content="text/html; charset=windows-1252">
            <meta name=Generator content="Microsoft Word 15 (filtered)">
            <style>
            <!--
            /* Font Definitions */
            @font-face
              {font-family:"Cambria Math";
              panose-1:2 4 5 3 5 4 6 3 2 4;}
            @font-face
              {font-family:Calibri;
              panose-1:2 15 5 2 2 2 4 3 2 4;}
            /* Style Definitions */
            p.MsoNormal, li.MsoNormal, div.MsoNormal
              {margin-top:0in;
              margin-right:0in;
              margin-bottom:8.0pt;
              margin-left:0in;
              line-height:107%;
              font-size:11.0pt;
              font-family:"Calibri",sans-serif;}
            a:link, span.MsoHyperlink
              {color:#0563C1;
              text-decoration:underline;}
            .MsoChpDefault
              {font-family:"Calibri",sans-serif;}
            .MsoPapDefault
              {margin-bottom:8.0pt;
              line-height:107%;}
            @page WordSection1
              {size:8.5in 11.0in;
              margin:1.0in 1.0in 1.0in 1.0in;}
            div.WordSection1
              {page:WordSection1;}
            -->
            </style>
            </head>
            <body lang=EN-US link="#0563C1" vlink="#954F72" style='word-wrap:break-word'>
            <div class=WordSection1>
            <p class=MsoNormal align=center style='text-align:center'><span
            style='font-size:14.0pt;line-height:107%'>[De Closet x MIM] VOUCHER 30% ALL 
            ITEMS</span></p>
            <p class=MsoNormal><span style='font-size:12.0pt;line-height:107%'>Chi ti&#7871;t
            ch&#432;&#417;ng tr�nh:</span></p>
            <p class=MsoNormal><span style='font-size:12.0pt;line-height:107%;font-family:
            "Segoe UI Emoji",sans-serif'>&#10084;</span><span style='font-size:12.0pt;
            line-height:107%'>&#65039;VOUCHER 30% FOR ALL ITEMS</span></p>
            <p class=MsoNormal><span style='font-size:12.0pt;line-height:107%;font-family:
            "Segoe UI Emoji",sans-serif'>&#128073;</span><span style='font-size:12.0pt;
            line-height:107%'>Th&#7901;i gian: 27/04 � 30/04/2022</span></p>
            <p class=MsoNormal><span style='font-size:12.0pt;line-height:107%;font-family:
            "Segoe UI Emoji",sans-serif'>&#128073;</span><span style='font-size:12.0pt;
            line-height:107%'>Truy c&#7853;p v�o shop t&#7841;i: <a
            href="https://share.decloset.vn/MIM">share.decloset.vn/MIM</a></span></p>
            <p class=MsoNormal><span style='font-size:12.0pt;line-height:107%'>&nbsp;</span></p>
            <p class=MsoNormal><span style='font-size:12.0pt;line-height:107%;font-family:
            "Segoe UI Emoji",sans-serif'>&#128073;</span><span style='font-size:12.0pt;
            line-height:107%'>&#431;u &#273;�i d�nh ri�ng cho kh�ch h�ng khi mua s&#7855;m
            qua &#7913;ng d&#7909;ng De Closet</span></p>
            <p class=MsoNormal><span style='font-size:12.0pt;line-height:107%'>&nbsp;</span></p>
            </div>
            </body>""",
              onLinkTap: (String? url, RenderContext context,
                  Map<String, String> attributes, dom.Element? element) {
                _launchUrl(url!);
              },
            ),
            Container(
              padding: EdgeInsets.only(bottom: Dimensions.h10),
              child: GridViewCustom(lstProduct: lstProduct),
            ),
          ],
        ),
      ),
    );
  }
}
