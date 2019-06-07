/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package activos.logic;

import com.itextpdf.text.Chunk;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfContentByte;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import javax.servlet.http.HttpServletResponse;

import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Image;
import com.itextpdf.text.pdf.Barcode128;
import com.itextpdf.text.pdf.PdfWriter;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.util.List;

/**
 *
 * @author steve
 */
public class GenerarPDF {
    private final Font fuenteBold = new Font(Font.FontFamily.COURIER,10,Font.BOLD);
    private final Font fuenteNormal = new Font(Font.FontFamily.COURIER,8,Font.NORMAL);
    private final Font fuenteItalic= new Font(Font.FontFamily.COURIER,8,Font.ITALIC);
    
//    public void generarPDF(String header, String info, String footer, String salida, List<String> codigo){
//        try{
//          HttpServletResponse response = null;
//          Document document = new Document (PageSize.LETTER,36,36,10,10);
//          PdfWriter   pw = PdfWriter.getInstance(document,new FileOutputStream("C:/Users/ExtremeTech/Desktop/Proyecto-1-p4/"+salida+".pdf"));
//          document.open();
//          //document.add(getHeader(header));
//          //document.add(getInfo(info));
//          for(String s: codigo){
//          document.add(GetBarcode(document, pw, s));
//          }
//          //document.add(getFooter(footer));
//          document.close();
//          //response.setContentType("application/octet-strem");
//          //response.setHeader("Content-Disposition", "attachment;filename='" + document + "'"); //preparando el 'download' al navegador
//          
//          
//        }catch(DocumentException | FileNotFoundException e){
//            
//        }
//        
//    }
    
    public void generarPDF(String header, String info, String footer, String salida, String codigo){
        try{
          HttpServletResponse response = null;
          Document document = new Document (PageSize.LETTER,36,36,10,10);
          PdfWriter   pw = PdfWriter.getInstance(document,new FileOutputStream("C:/Users/ExtremeTech/Desktop/Proyecto-1-p4/"+salida+".pdf"));
          document.open();
          //document.add(getHeader(header));
          //document.add(getInfo(info));
          document.add(GetBarcode(document, pw, codigo));
          //document.add(getFooter(footer));
          document.close();
          //response.setContentType("application/octet-strem");
          //response.setHeader("Content-Disposition", "attachment;filename='" + document + "'"); //preparando el 'download' al navegador
          
          
        }catch(DocumentException | FileNotFoundException e){
            
        }
        
    }
    
    private Paragraph getHeader(String texto){
        Paragraph  p = new Paragraph();
        Chunk  c= new Chunk();
        p.setAlignment(Element.ALIGN_CENTER);
        c.append(texto);
        c.setFont(fuenteBold);
        p.add(c);
        return p;
    }
    
    private Paragraph getInfo(String texto){
        Paragraph  p = new Paragraph();
        Chunk  c= new Chunk();
        p.setAlignment(Element.ALIGN_JUSTIFIED_ALL);
        c.append(texto);
        c.setFont(fuenteNormal);
        p.add(c);
        return p;
    }
    
    private Paragraph getFooter(String texto){
        Paragraph  p = new Paragraph();
        Chunk  c= new Chunk();
        p.setAlignment(Element.ALIGN_RIGHT);
        c.append(texto);
        c.setFont(fuenteItalic);
        p.add(c);
        return p;
    }
   
    private Image GetBarcode(Document document, PdfWriter pw, String codigo){
        PdfContentByte cimg = pw.getDirectContent();
        Barcode128 code128 = new Barcode128();
        code128.setCode(codigo);
        code128.setCodeType(Barcode128.CODE128);
        code128.setTextAlignment(Element.ALIGN_CENTER);
        Image image = code128.createImageWithBarcode(cimg,BaseColor.BLACK, BaseColor.BLACK);
        float scaler = ((document.getPageSize().getWidth()-document.leftMargin()-document.rightMargin()-0)/image.getWidth()*60);
        image.scalePercent(scaler);
        image.setAlignment(Element.ALIGN_CENTER);
        return image;
    }
   
    private String formatearCodigo(String num){
        NumberFormat form = new DecimalFormat("0000000");
        return form.format((num!=null)? Integer.parseInt(num):0000000);
    }
}
