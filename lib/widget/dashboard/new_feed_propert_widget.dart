import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fragvest_mobile/constants/kcolors.dart';
import 'package:fragvest_mobile/model/get_blog_post_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class NewFeedPropertyWidget extends StatelessWidget {
  @required
  final GetBlogPostModel getBlogPostModel;

  const NewFeedPropertyWidget({Key key, this.getBlogPostModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      // scrollDirection: Axis.horizontal,

      physics: NeverScrollableScrollPhysics(),
      itemCount: getBlogPostModel.data.take(2).length,
      itemBuilder: (context, index) {
        final post = getBlogPostModel.data[index];
        return GestureDetector(
          onTap: () => _launchURL(post.postLink),
          child: Container(
            // color: Colors.orange,
            // padding: const EdgeInsets.all(8),
            width: 165,
            height: 206,
            decoration: BoxDecoration(
                // color: Colors.red,
                borderRadius: BorderRadius.circular(20)),
            child: Container(
              // color: Colors.orange,
              padding: const EdgeInsets.all(10),
              width: 165,
              height: 206,
              decoration: new BoxDecoration(
                // color: Colors.red,
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                    colors: [
                      Color(0xFF0C0932).withOpacity(0.0),
                      Color(0xFF0C0932).withOpacity(0.5837),
                      Color(0xFF0C0932).withOpacity(1),
                      Color(0xFF0C0932).withOpacity(1),
                      Color(0xFF0C0932),
                    ],
                    stops: [
                      0.0,
                      0.5837,
                      1,
                      1,
                      1.0
                    ]),
                image: new DecorationImage(
                  colorFilter: ColorFilter.mode(
                      Color(0xFF0C0932).withOpacity(0.2), BlendMode.dstATop),
                  // image: new AssetImage("assets/images/splash.png"),
                  // imageUrl: post.postImage
                  // image: Image.network('https://picsum.photos/250?image=9'),
                  image: NetworkImage(post.postImage),
                  fit: BoxFit.fill,
                ),
              ),
              // decoration: BoxDecoration(
              //     color: kcWhite, borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 120,
                    width: double.infinity,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          // imageUrl: post.postImage,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                              height: 50,
                              width: 30,
                              child: CupertinoActivityIndicator()),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        )),
                  ),

                  Container(
                    // padding: EdgeInsets.only(bottom:2),
                    child:  Expanded(
                      child: Text(
                        post.postTitle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(color: Color(0xFFffffff)),
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  Container(
                    // padding: EdgeInsets.only(top:8),
                    child: Text(
                      'See More',
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(color: Color(0xFF07C168)),
                          // decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w500,
                          fontSize: 12),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          // childAspectRatio: 4 / 5,
          mainAxisExtent: 206,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        )
    );
  }

  void _launchURL(String url) async {
    if (!await launch(url)) throw 'Could not launch $url';
  }
}
