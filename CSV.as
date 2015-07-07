package {
import flash.net.FileReference;
import flash.utils.ByteArray;

import mx.collections.ArrayCollection;
import mx.collections.IViewCursor;
import mx.controls.DataGrid;
import mx.controls.dataGridClasses.DataGridColumn;

public class CSV {

    private var mydata:DataGrid;

    public function CSV(mydata:DataGrid) {
        this.mydata = mydata;
    }

    public function test():void {
        var csvSeparator:String = "\t";
        var lineSeparator:String = "\n";
        var data:String = "";
        var columns:Array = mydata.columns;
        var columnCount:int = columns.length;
        var column:DataGridColumn;
        var header:String = "";
        var headerGenerated:Boolean = false;
        var dataProvider:Object = mydata.dataProvider;
        var rowCount:int = dataProvider.length;
        var dp:Object = null;
        var cursor:IViewCursor = dataProvider.createCursor();
        var j:int = 0;
        //loop through rows
        while (!cursor.afterLast) {
            var obj:Object = null;
            obj = cursor.current;
            //循环所有列
            for (var k:int = 0; k < columnCount; k++) {
                column = columns[k];
                trace(column.itemToLabel(obj));
                //判断列是否可见
                if (!column.visible) {
                    continue;
                }
                data += column.itemToLabel(obj) + ",";
                if (k < (columnCount - 1)) {
                    data += csvSeparator;
                }
                //判断是不是标题
                if (!headerGenerated) {
                    header += column.headerText + ",";
                    if (k < columnCount - 1) {
                        header += csvSeparator;
                    }
                }
            }
            headerGenerated = true;
            if (j < (rowCount - 1)) {
                data += lineSeparator;
            }
            j++;
            cursor.moveNext();
        }

        dataProvider = null;
        columns = null;
        column = null;

        var fr:FileReference = new FileReference();
        fr.save(header + "\n" + data, "exportCSV.csv");

    }


    public function exportCSV():void {
        var dataProviderCollection:ArrayCollection = mydata.dataProvider as ArrayCollection; //DataGrid数据源
        var rowCount:int = dataProviderCollection.length; //有多少行数据
        var columns:Array = mydata.columns; //DataGrid有多少列
        var data:String = " ";
        var fieldSeparator:String = "\t";
        var lineSeparator:String = "\r\n";
        var csvSeparator:String = "       ";
        var fields:Array = new Array();

        //循环datagrid字段名
        var i:int = 0;
        for each (var field:DataGridColumn in columns) {
            fields.push(field.dataField.toString());
            data += field.dataField.toString() + csvSeparator + fieldSeparator;
            if (field == columns[columns.length - 1]) {
                data += lineSeparator;
            }
            i++;
        }

        //循环所有行数据
        for (var r:int = 0; r < rowCount; r++) {

            var record:Object = dataProviderCollection.getItemAt(r);
            for each(var field_:String in fields) {
                for each (var value:String in record) {
                    if (record[field_].toString() == value) {
                        data += value + csvSeparator + fieldSeparator;
                    }
                }
            }

            data += lineSeparator;
        }
        var byte:ByteArray = new ByteArray();
        byte.writeMultiByte(data, "utf-8");
        //byte.endian = "bigEndian";

        var fr:FileReference = new FileReference();
        fr.save(byte, "exportCSV.csv");
    }
}
}