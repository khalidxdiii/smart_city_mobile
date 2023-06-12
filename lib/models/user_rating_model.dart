

class MAUserRattingModel {
  final double r1;
  final double r2;
  final double r3;
  final double r4;
  final double r5;
  final double r6;
  final double r7;
  final double r8;
  final double r9;
  final double r10;
  

  MAUserRattingModel({
 this.r1 =0,
 this.r2 =0,
 this.r3 =0,
 this.r4 =0,
 this.r5 =0,
 this.r6 =0,
 this.r7 =0,
 this.r8 =0,
 this.r9 =0,
 this.r10 =0,
  });

  factory MAUserRattingModel.fromJSON(Map json) {
   
    return MAUserRattingModel(
     r1: json['ما رايك بالخدمه بشكل عام'],
     r2: json['ما مدى رضاك عن حل المشكله'],
     r3: json['سرعه الاستجابه فى حل المشكله'],
     r4: json['ما رايك فى التعامل مع المسؤلين مع المشكله'],
     r5: json['ما رايك فى تعامل المسؤلين معك بشكل خاص'],
     r6: json['تقييم المسؤلين بشكل عام'],
     r7: json[ 'هل تنصح اصدقائك باستخدام التطبيق'],
     r8: json['تعامل ممثل خدمة العملاء مع مكالمتي بسرعة'],
     r9: json['كان ممثل خدمة العملاء مهذبًا للغاية'],
     r10: json['كان ممثل خدمة العملاء على دراية كبيرة بالمشكله'],
    );
  }

  Map toJSON() {
    return {
     'ما رايك بالخدمه بشكل عام':r1,
                        'ما مدى رضاك عن حل المشكله':r2,
                        'سرعه الاستجابه فى حل المشكله':r3,
                        'ما رايك فى التعامل مع المسؤلين مع المشكله':r4,
                        'ما رايك فى تعامل المسؤلين معك بشكل خاص':r5,
                        'تقييم المسؤلين بشكل عام':r6,
                        'هل تنصح اصدقائك باستخدام التطبيق':r7,
                        'تعامل ممثل خدمة العملاء مع مكالمتي بسرعة':r8,
                        'كان ممثل خدمة العملاء مهذبًا للغاية':r9,
                        'كان ممثل خدمة العملاء على دراية كبيرة بالمشكله':r10
    };
  }
}
