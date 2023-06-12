import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../layout/admin/admin_layout_screen_moudule.dart';
import '../../../models/problem_model.dart';
import '../../../models/user_model.dart';
import '../../../shared/component/componant.dart';
import '../../../shared/component/constants.dart';
import '../../../shared/component/icon_card_widget.dart';
import '../../../shared/network/remote/image_uploader.dart';
import '../../../shared/styles/colors.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class AdminUploadImage extends StatelessWidget {
  const AdminUploadImage({super.key, this.problem, this.user, this.reportID});
  final MAProblemModel? problem;
  final MAUserModel? user;
  final String? reportID;

  @override
  Widget build(BuildContext context) {
    var adminNotesToUser = TextEditingController();

    var formKey = GlobalKey<FormState>();
    //bool isLoading = true;

    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('تحديث البيانات')),
      body: BlocProvider(
        create: (BuildContext context) => AdminCameraCubit(),
        child: BlocConsumer<AdminCameraCubit, AdminCameraStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return ModalProgressHUD(
              inAsyncCall: context.watch<AdminCameraCubit>().isLoading,
              child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      //color: kDprimaryColor[300],
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            IconCardGetImageWidget(
                              onTap: AdminCameraCubit.get(context).getimage,
                              onDelete: () {
                                context.read<AdminCameraCubit>().clearImage();
                                debugPrint("del");
                              },
                              image: context.watch<AdminCameraCubit>().image,
                              isSelectedImage:
                                  context.watch<AdminCameraCubit>().image !=
                                      null,
                            ),
                            const SizedBox(
                              height: 20,
                            ),

                            DefaultTextFild(
                              label: 'ملاحظات المسؤل',
                              controller: adminNotesToUser,
                              type: TextInputType.text,
                              validator: (value) {
                                return null;
                              },
                              prefixIcon: Icons.edit,
                              minLines: 7,
                              maxLines: 7,
                            ),

                            //
                            const SizedBox(
                              height: 20,
                            ),
                            DefaultButton(
                                function: () async {
                                  try {
                                    if (formKey.currentState!.validate()) {
                                      context
                                          .read<AdminCameraCubit>()
                                          .isLoadingTrue();
                                      var imUp = ImageUploader();
                                      var imageAfterUrl =
                                          await imUp.uploadImage(context
                                              .read<AdminCameraCubit>()
                                              .image!);
                                      bool isDone = await imUp.adminFinshReport(
                                        reportID: problem!.reportID!,
                                        imageAfterUrl: imageAfterUrl,
                                        adminNotesToUser:
                                            adminNotesToUser.text.trim(),
                                      );

                                      if (isDone) {
                                        debugPrint('done upload image');
                                      } else {
                                        debugPrint('finish upload image');
                                      }
                                      context
                                          .read<AdminCameraCubit>()
                                          .clearImage();
                                      adminNotesToUser.clear();
                                      ///////////////////////////  Send Email /////////////////////////////
                                      try {
                                        final smtpServer = SmtpServer(
                                            'smtp.sendgrid.net',
                                            port: 465,
                                            ssl: true,
                                            username: 'apikey',
                                            password:
                                                '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');

                                        // Create email message
                                        final message = Message()
                                          ..from = const Address(
                                              'fokkakmeni@gmail.com', kDAppName)
                                          ..recipients
                                              .add(adminNotesToUser.text)
                                          //..ccRecipients.addAll(['recipient2@example.com', 'recipient3@example.com'])
                                          ..subject =
                                              '$kDAppName - registration successful'
                                          ..text = """
MR/ ${user!.fullName}.

Thank you for your cooperation and patience with us..

Your report number: ${problem!.reportID} has been reviewed and the problem has been addressed.. 

You can login to your account to view the details.

$kDAppName.
""";
                                        // ..html = '<h1>Hi ,</h1>\n<p>Your registration was successful.</p>';

                                        // Send email
                                        try {
                                          final sendReport =
                                              await send(message, smtpServer);
                                          debugPrint(
                                              'Message sent: ${sendReport.toString()}');
                                        } on MailerException catch (e) {
                                          debugPrint(
                                              'Message not sent. ${e.toString()}');
                                        } catch (e) {
                                          debugPrint(
                                              'An unexpected error occurred. ${e.toString()}');
                                        }
                                      } catch (e) {
                                        debugPrint(e.toString());
                                      }
                                      //////////////////////////////////////////////////////

                                      context
                                          .read<AdminCameraCubit>()
                                          .isLoadingFalse();

                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const AdminLayoutScreenMoudule(),
                                        ),
                                      );

                                      var snackBar = SnackBar(
                                        content: Text(
                                          'تم الرفع بنجاح',
                                          style: GoogleFonts.almarai(),
                                        ),
                                        backgroundColor: kDprimaryColor,
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    }
                                  } catch (e) {
                                    debugPrint(e.toString());
                                  }
                                },
                                text: 'انهاء التقرير')
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
