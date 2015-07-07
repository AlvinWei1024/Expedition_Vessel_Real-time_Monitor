package {
import com.esri.ags.Graphic;
import com.esri.ags.Map;
import com.esri.ags.geometry.Extent;
import com.esri.ags.geometry.MapPoint;
import com.esri.ags.geometry.Polygon;
import com.esri.ags.geometry.Polyline;
import com.esri.ags.layers.GraphicsLayer;
import com.esri.ags.symbols.PictureMarkerSymbol;
import com.esri.ags.symbols.SimpleFillSymbol;
import com.esri.ags.symbols.SimpleLineSymbol;
import com.esri.ags.symbols.SimpleMarkerSymbol;

import flash.events.TimerEvent;
import flash.utils.Dictionary;
import flash.utils.Timer;

import mx.collections.ArrayCollection;

public class DrawRouteLogic {
    private var routeArrayYZRegion1:ArrayCollection = new ArrayCollection([
        {LONGITUDE: "13491530.448", LATITUDE: "3840443.126"},
        {LONGITUDE: "13493598.583", LATITUDE: "3838587.603"},
        {LONGITUDE: "13493675.897", LATITUDE: "3838123.722"},
        {LONGITUDE: "13493617.911", LATITUDE: "3837524.542"},
        {LONGITUDE: "13493559.926", LATITUDE: "3837002.676"},
        {LONGITUDE: "13493598.583", LATITUDE: "3836364.84"},
        {LONGITUDE: "13493733.882", LATITUDE: "3835398.422"},
        {LONGITUDE: "13493753.21", LATITUDE: "3835243.795"},
        {LONGITUDE: "13493501.941", LATITUDE: "3835166.482"},
        {LONGITUDE: "13493173.359", LATITUDE: "3834432.004"},
        {LONGITUDE: "13492690.15", LATITUDE: "3834432.004"},
        {LONGITUDE: "13492342.239", LATITUDE: "3834258.048"},
        {LONGITUDE: "13492090.971", LATITUDE: "3834103.421"},
        {LONGITUDE: "13491936.344", LATITUDE: "3834122.75"},
        {LONGITUDE: "13491723.732", LATITUDE: "3834026.108"},
        {LONGITUDE: "13491433.806", LATITUDE: "3834064.765"},
        {LONGITUDE: "13491066.567", LATITUDE: "3834103.421"},
        {LONGITUDE: "13490061.492", LATITUDE: "3833852.153"},
        {LONGITUDE: "13489713.581", LATITUDE: "3833697.526"},
        {LONGITUDE: "13489558.954", LATITUDE: "3833504.242"},
        {LONGITUDE: "13489384.999", LATITUDE: "3833446.257"},
        {LONGITUDE: "13489114.402", LATITUDE: "3833291.63"},
        {LONGITUDE: "13489114.402", LATITUDE: "3833040.361"},
        {LONGITUDE: "13489269.029", LATITUDE: "3832615.137"},
        {LONGITUDE: "13489056.417", LATITUDE: "3832383.197"},
        {LONGITUDE: "13488824.47", LATITUDE: "3832325.212"},
        {LONGITUDE: "13488669.85", LATITUDE: "3832054.615"},
        {LONGITUDE: "13488476.566", LATITUDE: "3831745.361"},
        {LONGITUDE: "13488437.909", LATITUDE: "3831416.779"},
        {LONGITUDE: "13488433.676", LATITUDE: "3831439.477"},
        {LONGITUDE: "13488601.19", LATITUDE: "3831271.963"},
        {LONGITUDE: "13488467.179", LATITUDE: "3831154.703"}
    ]);
    private var routeArray:ArrayCollection = new ArrayCollection();
    private var timer:Timer = new Timer(50, 0);
    private var graphicsLayerPoint:GraphicsLayer;
    private var graphicsLayer1:GraphicsLayer;
    private var graphicsLayer2:GraphicsLayer;
    private var route:Polyline;
    private var timeIndex:int;
    private var m_circleGeometry:Polygon;
    private var center:MapPoint;
    private var m_radius:Number;
    private var m_graphic:Graphic;
    private var m_textGraphic:Graphic;
    private var m_center:MapPoint;
    private var infoFlag:Boolean = false;
    public var typeTimeValue1:Dictionary = new Dictionary;
    public var numberOfCirclePoints:int = 100;

    public var map:Map;
    public var extent:Extent;

    public function DrawRouteLogic() {
        this.routeArray = this.routeArrayYZRegion1;
    }


    public function startRoute():void {
        if (graphicsLayer1 != null) {
            graphicsLayer1.clear();
        }

        if (graphicsLayerPoint != null) {
            graphicsLayerPoint.clear();
            route = null;
        }

        //计时器设置
        var larray:Array = getRouteData();
        var handleNum:int = larray.length;
        timer = new Timer(50, handleNum);// 每3秒钟执行一次，执行handleNum次
        timer.addEventListener(TimerEvent.TIMER, startTimer);
        var mapPoint:MapPoint = new MapPoint(routeArray[0].LONGITUDE, routeArray[0].LATITUDE);
        timeIndex = 0;
        if (this.extent != null) {
            this.map.extent = this.extent;
        }
        timer.start();
    }

    private function startTimer(event:TimerEvent):void {
        if (graphicsLayer1 != null) {
            map.removeLayer(graphicsLayer1);
            graphicsLayer1 = null;
        }
        if (graphicsLayer2 != null) {
            map.removeLayer(graphicsLayer2);
            graphicsLayer2 = null;
        }
        var larray:Array = getRouteData();
        var mapPoint:MapPoint = new MapPoint(larray[timeIndex].x, larray[timeIndex].y);
        if (timeIndex == 1) {
            var gra:Graphic = new Graphic();
            if (route == null) {
                route = new Polyline([]);
                var sym:SimpleLineSymbol = new SimpleLineSymbol("dot", 0xDC143C, 1.0, 1.5);
                gra.geometry = route;
                gra.symbol = sym;
            }
            graphicsLayerPoint.add(gra);
        }

        if (route != null) {
            var mptemp1:MapPoint = new MapPoint(Number(larray[timeIndex - 1].x), Number(larray[timeIndex - 1].y));
            var mptemp2:MapPoint = new MapPoint(Number(larray[timeIndex].x), Number(larray[timeIndex].y));
            route.addPath([mptemp1, mptemp2]);
        }

        for (var i:int = 0; i < routeArray.length; i++) {
            var point:MapPoint = new MapPoint(routeArray[i].LONGITUDE, routeArray[i].LATITUDE);
            if (point.x == mapPoint.x && point.y == mapPoint.y) {
                var graphic:Graphic = new Graphic(mapPoint, null, timeIndex);
                var l:SimpleLineSymbol = new SimpleLineSymbol("dot", 0xDC143C, 1.8, 1.0);
                var s:SimpleMarkerSymbol = new SimpleMarkerSymbol("dot", 8, 0xDC143C, 1, 0, 0, 0, l);
                graphic.symbol = s;
                if (graphicsLayerPoint == null) {
                    graphicsLayerPoint = new GraphicsLayer();
                }
                graphicsLayerPoint.add(graphic);
                map.addLayer(graphicsLayerPoint);

            }

        }


        //载入图片代码

        var mPoint:MapPoint = new MapPoint(larray[timeIndex].x, larray[timeIndex].y);
        var imgraphic:Graphic = new Graphic(mPoint);
        if (timeIndex == larray.length - 1) {
            var s1:PictureMarkerSymbol = new PictureMarkerSymbol("assets/images/tp.swf");
            timer.stop();
        } else {
            var s2:SimpleMarkerSymbol = new SimpleMarkerSymbol("circle", 8, 0xDC143C, 1, 0, 0, 0, l);
            imgraphic.symbol = s2;
        }
        if (graphicsLayer1 == null) {
            graphicsLayer1 = new GraphicsLayer();
        }
        graphicsLayer1.add(imgraphic);

        map.addLayer(graphicsLayer1);

        //画起始圆
        if (graphicsLayer2 == null) {

            graphicsLayer2 = new GraphicsLayer();

        }
        m_circleGeometry = new Polygon();
        center = new MapPoint(routeArray[0].LONGITUDE, routeArray[0].LATITUDE);
        m_center = mPoint;
        var outPoint:MapPoint = new MapPoint(routeArray[1].LONGITUDE, routeArray[1].LATITUDE);
        var dx:Number = outPoint.x - center.x;
        var dy:Number = outPoint.y - center.y;
        m_radius = Math.sqrt(dx * dx + dy * dy) / 3;
        updateCirclePolygon();                                    //根据不同的半径，获取不同的圆外坐标，构成Polygon  0xFFFFFF
        var l:SimpleLineSymbol = new SimpleLineSymbol("dot", 0xDC143C, 2.5, 1);
        var ls:SimpleFillSymbol = new SimpleFillSymbol("circle", 0xDC143C, 0.3, l);
        m_graphic = new Graphic(m_circleGeometry, ls);
        graphicsLayer2.add(m_graphic);
        map.addLayer(graphicsLayer2);
        timeIndex++;


    }

    /**
     * widget 获取圆的随机数组
     * @author:wang
     * @param:void
     * @return:void
     */
    private function updateCirclePolygon():void {
        if ((m_circleGeometry.rings != null) && (m_circleGeometry.rings.length > 0)) {

            m_circleGeometry.removeRing(0);
        }

        var cosinus:Number;
        var sinus:Number;
        var x:Number;
        var y:Number;
        var arrayOfPoints:Array = new Array();
        for (var i:int = 0; i < numberOfCirclePoints; i++) {
            sinus = Math.sin((Math.PI * 2.0) * (i / numberOfCirclePoints));
            cosinus = Math.cos((Math.PI * 2.0) * (i / numberOfCirclePoints));
            x = m_center.x + m_radius * cosinus;
            y = m_center.y + m_radius * sinus;
            arrayOfPoints[i] = new MapPoint(x, y);
            //arrayOfPoints[i]  = WebMercatorUtil.geographicToWebMercator(arrayOfPoints[i]) as MapPoint;
        }
        arrayOfPoints.push(arrayOfPoints[0]);

        m_circleGeometry.addRing(arrayOfPoints);
    }


    /**
     *将点集分割成细点集
     * @return
     *
     */
    private function getRouteData():Array {
        var larray:Array = new Array();
        for (var i:int = 0; i < routeArray.length; i++) {
            var mapPoint:MapPoint = new MapPoint(routeArray[i].LONGITUDE, routeArray[i].LATITUDE);
            larray.push(mapPoint);
            if (i != routeArray.length - 1) {
                var sPoint:MapPoint = new MapPoint(routeArray[i + 1].LONGITUDE, routeArray[i + 1].LATITUDE);
                var lx:Number = sPoint.x - mapPoint.x;
                var ly:Number = sPoint.y - mapPoint.y;
                var dista:Number = Math.sqrt(lx * lx + ly * ly);
                var sx:Number = mapPoint.x;
                var sy:Number = mapPoint.y;
                for (var j:int = 0; j < 10; j++) {
                    sx += lx / 10;
                    sy += ly / 10;
                    var mPoint:MapPoint = new MapPoint(sx, sy);
                    larray.push(mPoint);

                }
                larray.push(sPoint);
            }

        }
        return larray;
    }
}
}