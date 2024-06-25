import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:scholar_sphere/backend/save_and_open_pdf.dart';

class ParagraphPdfApi{
  static Future<File> generateParagraphPdf() async{
    final pdf = Document();
    pdf.addPage(
      MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) => [
          customHeader(),
          customHeadline(),
        ],
        header: (context)=> buildPageNumber(context),
        footer: (context)=> buildPageNumber(context),
      ),
    );
    return SaveAndOpenDocument.savePdf(name: 'ScholarSpherePortfolio.pdf', pdf:pdf);
  }
  static Widget customHeader() => Container(
        padding: const EdgeInsets.only(bottom: 3*PdfPageFormat.mm),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 2,color: PdfColors.blue),
          ),
        ),
        child: Row(
          children: [
            PdfLogo(),
            SizedBox(width: 0.5 * PdfPageFormat.cm),
            Text(
              'My Scholar Sphere Portfolio',
              style: TextStyle(
                fontSize: 50,
                color: PdfColors.blue,
                fontWeight: FontWeight.bold
              )
            ),
          ],
        ),
  );
  static Widget customHeadline() => Header(
    child: Text(
      'Another headline',
      style: TextStyle(
        fontSize: 50,
        fontWeight: FontWeight.bold,
        color: PdfColors.white,
      ),
    ),
    padding: const EdgeInsets.all(8.0),
    decoration: const BoxDecoration(color: PdfColors.red),
  );
  static Widget buildPageNumber (Context context) => Container(
    alignment: Alignment.center,
    margin: const EdgeInsets.only(top:10),
    child: Text(
      'Page ${context.pageNumber} of ${context.pagesCount}',
      style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),
    )
  );
}