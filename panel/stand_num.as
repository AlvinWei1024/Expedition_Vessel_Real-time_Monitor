package panel
{
	public class stand_num
	{
		public function stand_num()
		{}
		public function fomart_num(numstring:String,numcount:int):String //规格化数字的位数
		{
			var numvalue:int;
			numvalue=int(numstring);
			if(numstring!=null)
			{
				if(numstring.length>numcount)
				{
					//return numvalue.toString().substr(0,numcount);
					
					var bbb:String=fomart_num(numvalue.toString().substr(0,numcount),numcount);
					return bbb;
				}
				else
				{
					if(numcount==1)
					{
						return numvalue.toString();
					}
					else if(numcount==2)
					{
						if(numvalue<10&&numvalue>=0)
						{
							return("0"+ numvalue.toString());
						}
						else
							return numvalue.toString();
					}
					else if(numcount==3)
					{
						if(numvalue<100&&numvalue>=10)
						{
							return("0"+ numvalue.toString());
						}
						else if(numvalue<10&&numvalue>=0)
						{
							return("00"+ numvalue.toString());
						}
						else
							return numvalue.toString();
					}
					else if(numcount==4)
					{
						if(numvalue<1000&&numvalue>=100)
						{
							return("0"+ numvalue.toString());
						}
						else if(numvalue<100&&numvalue>=10)
						{
							return("00"+ numvalue.toString());
						}
						else if(numvalue<10&&numvalue>=0)
						{
							return("000"+ numvalue.toString());
						}
						else
							return numvalue.toString();
					}
					else if(numcount==5)
					{
						if(numvalue<10000&&numvalue>=1000)
						{
							return("0"+ numvalue.toString());
						}
						else if(numvalue<1000&&numvalue>=100)
						{
							return("00"+ numvalue.toString());
						}
						else if(numvalue<100&&numvalue>=10)
						{
							return("000"+ numvalue.toString());
						}
						else if(numvalue<10&&numvalue>=0)
						{
							return("0000"+ numvalue.toString());
						}
						else
							return numvalue.toString();
					}
					else if(numcount==6)
					{
						if(numvalue<100000&&numvalue>=10000)
						{
							return("0"+ numvalue.toString());
						}
						else if(numvalue<10000&&numvalue>=1000)
						{
							return("00"+ numvalue.toString());
						}
						else if(numvalue<1000&&numvalue>=100)
						{
							return("000"+ numvalue.toString());
						}
						else if(numvalue<100&&numvalue>=10)
						{
							return("0000"+ numvalue.toString());
						}
						else if(numvalue<10&&numvalue>=0)
						{
							return("00000"+ numvalue.toString());
						}
						else
							return numvalue.toString();
					}
					else return numstring.toString();
				}
				
			}
			
			else
			{
				 var Zstring:String="0";
				 for(var j:int=0;j<numcount-1;j++)
				 {
					 Zstring=Zstring+"0";
				 }
				 return Zstring;
			}
				
			}
			
			
		
	}
}