package {
	
	import dto.Category;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import model.BanditModel;
	
	public class BanditLoader extends EventDispatcher {
		
		public static var LOADED:String = 'loaded';
		
		public var juanXML:XML;
		public var tonyXML:XML;
		
		private var jul:URLLoader;
		private var tul:URLLoader;
		private var juanLoaded:Boolean;
		private var tonyLoaded:Boolean;
		
		private var tbModel:BanditModel = BanditModel.getInstance();
		
		public function load():void {
			jul = new URLLoader();
			tul = new URLLoader();
			jul.addEventListener(Event.COMPLETE, loadComplete);
			tul.addEventListener(Event.COMPLETE, loadComplete);
			jul.load(new URLRequest('juan@scalenine.com.xml'));
			tul.load(new URLRequest('tony.hillerson@effectiveui.com.xml'));
		}
		
		public function loadComplete(e:Event):void {
			if (e.target == jul) {
				juanLoaded = true;
				juanXML = XML(jul.data);
			} else if (e.target == tul) {
				tonyLoaded = true;
				tonyXML = XML(tul.data);
			}
			
			if (tonyLoaded && juanLoaded) {
				loadXML();
				tbModel.mapAvailableDates(juanXML..date);
				tbModel.mapAvailableDates(tonyXML..date);
				tbModel.mapCategoryColors();
				dispatchEvent(new Event(LOADED));
			}
		}
		
		private function loadXML():void {
			var xml:XML;
			for each (xml in juanXML..category) {
				tbModel.juan.addCategory( Category.fromXML(xml) );
				tbModel.juan.mapUsages(xml);
			}

			for each (xml in tonyXML..category) {
				tbModel.tony.addCategory( Category.fromXML(xml) );
				tbModel.tony.mapUsages(xml);
			}
		}
	}
}