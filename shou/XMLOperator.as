package shou {
import flash.events.Event;

public class XMLOperator {
    private static var strSqlWServiceStart:String = "";
    private static var strSqlWServiceEnd:String = "";
    //连接的数据库名和登录数据库的用户名与密码

    public static var strDataBase:String = "JiDiDB";
    public static var strUsername:String = "jdU";
    public static var strPassword:String = "****8";
    //需要访问的7个数据库表的名称
    public static var strUserinfo:String = "fbcuser.CENTER_MM_USERINFO";
    public static var strRole:String = "fbcuser.CENTER_MM_ROLE";
    public static var strModelfea:String = "fbcuser.CENTER_MM_MODELFEA";
    public static var strPrivilege:String = "fbcuser.CENTER_MM_PRIVILEGE";
    public static var strUserrefrole:String = "fbcuser.CENTER_MM_USERREFROLE";
    public static var strRolerefpri:String = "fbcuser.CENTER_MM_ROLEREFPRI";
    public static var strPrivrefmodel:String = "fbcuser.CENTER_MM_PRIVREFMODEL";

    //调用WebService的地址
	//  public static var strWebserviceWsdl:String = "http://202.121.66.51:808/Service_fbc.asmx";
   public static var strWebserviceWsdl:String = "http://192.168.11.17/Service_fbc.asmx";
    public function XMLOperator() {

    }

    private static function completeHandler(event:Event):String {
        var xml:XML = XML(event.target.data);
        strDataBase = xml.database.toString();
        strUsername = xml.username.toString();
        strPassword = xml.password.toString();
        strUserinfo = xml.userinfo.toString();
        strRole = xml.role.toString();
        strModelfea = xml.modelfea.toString();
        strPrivilege = xml.privilege.toString();
        strUserrefrole = xml.userrefrole.toString();
        strRolerefpri = xml.rolerefpri.toString();
        strPrivrefmodel = xml.privrefmodel.toString();
        strWebserviceWsdl = xml.webservicewsdl.toString();
        return xml.toXMLString();
    }

    public static function GetSelectWebServiceSql(strSqlWService:String):String {

        strSqlWServiceStart = "<?xml version=\"1.0\" encoding=\"gbk\"?>";
        strSqlWServiceStart = strSqlWServiceStart + "<input><dataBase>" + strDataBase + "</dataBase><username>" + strUsername + "</username><password>" + strPassword + "</password>";
        strSqlWServiceStart = strSqlWServiceStart + "<tablename></tablename><operateType>select</operateType><sql>";
        strSqlWServiceStart = strSqlWServiceStart + "<\!\[CDATA\[ ";
        strSqlWServiceEnd = "\]\]></sql></input>";
        return strSqlWServiceStart + strSqlWService + strSqlWServiceEnd;
    }

    public static function GetUpInDeWebServiceSql():String {

        strSqlWServiceStart = "<?xml version=\"1.0\" encoding=\"gbk\"?>";
        strSqlWServiceStart = strSqlWServiceStart + "<input><dataBase>" + strDataBase + "</dataBase><username>" + strUsername + "</username><password>" + strPassword + "</password>";
        strSqlWServiceStart = strSqlWServiceStart + "<tablename>CENTER_MM_MESH </tablename><operateType>select</operateType><sql>";
        strSqlWServiceStart = strSqlWServiceStart + "<\!\[CDATA\[ ";
        strSqlWServiceEnd = "\]\]></sql></input>";
        return strSqlWServiceStart + strSqlWServiceEnd;
    }
}
}