package {
import com.as3xls.xls.ExcelFile;
import com.as3xls.xls.Sheet;

import flash.net.FileReference;
import flash.utils.ByteArray;

import mx.collections.ArrayCollection;
import mx.controls.DataGrid;
import mx.controls.dataGridClasses.DataGridColumn;

public class Excel {
    private var mydata:DataGrid;

    public function Excel(mydata:DataGrid) {
        this.mydata = mydata;
    }

    public function exportExcel():void {
        var sheet:Sheet = new Sheet();	//Excel选项卡
        var fields:Array = new Array(); 	//需要呈现的字段数组
        var filename:String = "ExportToxls" + ".xls";
        var dataProviderCollection:ArrayCollection = mydata.dataProvider as ArrayCollection; //DataGrid数据源
        var rowCount:int = dataProviderCollection.length; //有多少行数据
        sheet.resize(rowCount + 1, mydata.columnCount);	//设置当前选项卡 有多少行多少列
        var columns:Array = mydata.columns; //DataGrid有多少列

        //设置表格字段名
        var i:int = 0;
        for each (var field:DataGridColumn in columns) {
            fields.push(field.dataField.toString());
            sheet.setCell(0, i, field.dataField.toString()); //设置单元格 参数:1、行号；2、列号；3、单元格的值
            i++;
        }
        //循环所有数据
        for (var r:int = 0; r < rowCount; r++) {

            var record:Object = dataProviderCollection.getItemAt(r);

            //写入单行数据
            var x:int = 0;
            for each(var field_:String in fields) {
                for each (var value:String in record) {
                    if (record[field_].toString() == value) {
                        //将数据写到特定的单元格
                        sheet.setCell(r + 1, x, value);
                    }
                }
                x++;
            }
        }

        var xls:ExcelFile = new ExcelFile();
        xls.sheets.addItem(sheet);

        var bytes:ByteArray = xls.saveToByteArray();
        //var filter:FileFilter = new FileFilter("excel文件(.xls)", "*.xls");
        var fr:FileReference = new FileReference();
        //fr.browse([filter]);
        fr.save(bytes, filename);
    }

}
}