package panel
{
	import com.adobe.serialization.json.JSON;
	
	import flashx.textLayout.formats.Float;
	
	import mx.collections.ArrayCollection;
	
	import shou.*;
	
	import spark.components.*;
	import spark.components.Button;
	import spark.components.Group;
	import spark.components.Image;

	public class getNumImg
	{
		public function get_NumImg(dataString:String,group_img:HGroup,size:int):void
		{
			if(dataString!=null)
			{
					for(var i:int=0;i<dataString.length;i++)
					{	
						if(dataString.substr(i,1)=="0")
						{
							var img_0:Image=new Image();
							img_0.source= "images/0.png";
							img_0.width=size;
							group_img.addElement(img_0);
							
						}
						else if(dataString.substr(i,1)=="1")
						{
							var img_1:Image=new Image();
							img_1.source= "images/1.png";
							img_1.width=size;
							group_img.addElement(img_1);
						}
						else if(dataString.substr(i,1)=="2")
						{
							var img_2:Image=new Image();
							img_2.source= "images/2.png";
							img_2.width=size;
							group_img.addElement(img_2);
						}
						else if(dataString.substr(i,1)=="3")
						{
							var img_3:Image=new Image();
							img_3.source= "images/3.png";
							img_3.width=size;
							group_img.addElement(img_3);
						}
						else if(dataString.substr(i,1)=="4")
						{
							var img_4:Image=new Image();
							img_4.source= "images/4.png";
							img_4.width=size;
							group_img.addElement(img_4);
						}
						else if(dataString.substr(i,1)=="5")
						{
							var img_5:Image=new Image();
							img_5.source= "images/5.png";
							img_5.width=size;
							group_img.addElement(img_5);
						}
						else if(dataString.substr(i,1)=="6")
						{
							var img_6:Image=new Image();
							img_6.source= "images/6.png";
							img_6.width=size;
							group_img.addElement(img_6);
						}
						else if(dataString.substr(i,1)=="7")
						{
							var img_7:Image=new Image();
							img_7.source= "images/7.png";
							img_7.width=size;
							group_img.addElement(img_7);
						}
						else if(dataString.substr(i,1)=="8")
						{
							var img_8:Image=new Image();
							img_8.source= "images/8.png";
							img_8.width=size;
							group_img.addElement(img_8);
						}
						else if(dataString.substr(i,1)=="9")
						{
							var img_9:Image=new Image();
							img_9.source= "images/9.png";
							img_9.width=size;
							group_img.addElement(img_9);
						}
						else if(dataString.substr(i,1)==".")
						{
							/*var lab_a:Label=new Label();
							lab_a.text=dataString.substr(i,1);
							group_img.addElement(lab_a);*/
							
							var img_p:Image=new Image();
							img_p.source= "images/point.png";
							img_p.width=size;
							group_img.addElement(img_p);
						}
						else
						{
							var lab_a:Label=new Label();
							lab_a.text=dataString.substr(i,1);
							group_img.addElement(lab_a);
							
						}
					}
			}	
		}
		
		public function removeElements(group_img:Group):void
		{
			group_img.removeAllElements();
		}
	}
}