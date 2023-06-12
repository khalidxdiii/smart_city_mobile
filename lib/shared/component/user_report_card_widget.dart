import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/problem_model.dart';
import '../../models/user_model.dart';

import '../styles/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'open_image.dart';

class UserReportCardWidget extends StatelessWidget {
  const UserReportCardWidget({
    super.key,
    required this.index,
    required this.problemModel,
    required this.userModel,
    required this.function,
    this.isImageAfter = false,
    this.showRaitingBar = false,
    this.addNewWidget = const SizedBox(
      height: 0,
    ),
    this.height = 190,
    this.showTimeAfterSolve = false,
  });
  final int index;
  final MAProblemModel problemModel;
  final MAUserModel userModel;
  final Function()? function;
  final bool isImageAfter;
  final bool showRaitingBar;
  final Widget addNewWidget;
  final double? height;
  final bool showTimeAfterSolve;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Padding(
        padding:
            const EdgeInsets.only(left: 10.0, bottom: 2, top: 10, right: 10),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: kDprimaryColor,
              width: 2.0,
            ),
            boxShadow: const [
              BoxShadow(
                  offset: Offset(0, 15), blurRadius: 25, color: Colors.black12),
            ],
          ),
          //width: 420,
          height: showRaitingBar ? height : height! - 30,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Icons.task,
                                    color: kDprimaryColor,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(
                                    child: Text(
                                      problemModel.title!,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      textAlign: TextAlign.start,
                                      style: GoogleFonts.almarai(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 5,
                                      height: showRaitingBar
                                          ? height! - 75.0
                                          : height! - 100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(40),
                                        color: kDprimaryColor,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "رقم التقرير : ${problemModel.reportID!}",
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.almarai(
                                              fontSize: 12,
                                              color: Colors.black,
                                            ),
                                            maxLines: 1,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),

                                          Text(
                                            problemModel.disc!,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.almarai(
                                              fontSize: 12,
                                            ),
                                            maxLines: 2,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),

                                          showTimeAfterSolve
                                              ? Text(
                                                  problemModel
                                                      .adminEndReportTime!,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: GoogleFonts.almarai(
                                                    fontSize: 12,
                                                    // color: Colors.black,
                                                  ),
                                                )
                                              : Text(
                                                  problemModel.prTime!,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: GoogleFonts.almarai(
                                                    fontSize: 12,
                                                    // color: Colors.black,
                                                  ),
                                                ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          addNewWidget,
                                          showRaitingBar
                                              ? RatingBar.builder(
                                                  itemSize: 30,
                                                  initialRating:
                                                      problemModel.rating ?? 0,
                                                  minRating: 1,
                                                  direction: Axis.horizontal,
                                                  allowHalfRating: true,
                                                  itemCount: 5,
                                                  itemPadding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 1.0),
                                                  itemBuilder: (context, _) =>
                                                      const Icon(
                                                    Icons.star,
                                                    color: Colors.amber,
                                                  ),
                                                  onRatingUpdate: (_) {},
                                                  ignoreGestures: true,
                                                )
                                              : const SizedBox(height: 0),
                                          //Text(feedback ?? ''),
                                        ],
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
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 120,
                        margin: const EdgeInsets.only(
                            top: 0, bottom: 0, left: 5, right: 0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: kDprimaryColor,
                            width: 2.0,
                          ),
                          //color: Colors.red,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                              return isImageAfter
                                  ? OpenImageScreen(
                                      imageUrl: problemModel,
                                      isImageAfter: true,
                                    )
                                  : OpenImageScreen(
                                      imageUrl: problemModel,
                                      isImageAfter: false,
                                    );
                            }));
                          },
                          child: CachedNetworkImage(
                            imageUrl: isImageAfter
                                ? problemModel.imageAfterUrl
                                : problemModel.imageUrl,
                            placeholder: (context, url) =>
                                Image.asset('images/FadeInImage.png'),
                            errorWidget: (context, url, error) =>
                                Image.asset('images/FadeInImageError.png'),
                            fit: BoxFit.cover,
                            imageBuilder: (context, imageProvider) => ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
