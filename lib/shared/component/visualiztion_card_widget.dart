import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VisualizationCardWidget extends StatelessWidget {
  const VisualizationCardWidget(
      {Key? key, required this.sections, required this.total, required this.radius})
      : super(key: key);

  final List<PieChartSectionData> sections;
  final int total;
  final double radius;

  @override
  Widget build(BuildContext context) {
    if(total ==0){
      return Container(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(width: 1.0),
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildKeyItem(
                  color: Colors.grey[300],
                  label: 'لا يوجد تقارير',
                ),
                const SizedBox(height: 16.0),
                _buildKeyItem(
                  color: Colors.grey,
                  label: 'معلق',
                ),
                const SizedBox(height: 16.0),
                _buildKeyItem(
                  color: Colors.blue,
                  label: 'قيد المراجعه',
                ),
                const SizedBox(height: 16.0),
                _buildKeyItem(
                  color: Colors.green,
                  label: 'مكتمل',
                ),
              ],
            ),
          ),
          const SizedBox(width: 16.0),
           Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: CircleAvatar(
  backgroundColor: Colors.grey[300],
  radius: radius,
  child: Center(child: Text('لا يوجد تقارير' ,style: GoogleFonts.almarai(fontWeight: FontWeight.bold ,color: Colors.black) ,)),
)
            ),
          ),
        ],
      ),
    );
    }else{return Container(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(width: 1.0),
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                 _buildKeyItem(
                  color: Colors.grey[300],
                  label: 'لا يوجد تقارير',
                ),
                const SizedBox(height: 16.0),
                _buildKeyItem(
                  color: Colors.grey,
                  label: 'معلق',
                ),
                const SizedBox(height: 16.0),
                _buildKeyItem(
                  color: Colors.blue,
                  label: 'قيد المراجعه',
                ),
                const SizedBox(height: 16.0),
                _buildKeyItem(
                  color: Colors.green,
                  label: 'مكتمل',
                ),
              ],
            ),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                  sections: sections,
                  borderData: FlBorderData(show: false),
                  centerSpaceRadius: 0,
                  sectionsSpace: 3,
                  // pieTouchData: PieTouchData(
                  //   touchCallback: (PieTouchResponse touchResponse) {},
                  // ),
                ),
              ),
            ),
          ),
        ],
      ),
    );}
    
  }
  Widget _buildKeyItem({required Color? color, required String label}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 16.0,
          height: 16.0,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.rectangle,
          ),
        ),
        const SizedBox(width: 8.0),
        Text(label),
      ],
    );
  }
}