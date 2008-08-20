package dto {
	
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;
	
	[Bindable]
	public class Person {

		public var name:String;
		public var usageMap:Dictionary				= new Dictionary();
		public var currentUsages:ArrayCollection	= new ArrayCollection();
		public var apps:ArrayCollection				= new ArrayCollection();
		public var categories:ArrayCollection		= new ArrayCollection();
		public var appMap:Dictionary				= new Dictionary();
		public var categoryMap:Dictionary			= new Dictionary();
		
		public function Person(name:String) {
			this.name = name;
		}
		
		public function addCategory(category:Category):void {
			var app:App;
			if (categoryMap[category.id] == null) {
				categoryMap[category.id] = category;
				categories.addItem(category);
				for each (app in category.apps) {
					if (appMap[app.id] == null) {
						appMap[app.id] = app;
						apps.addItem(app);
					}
				}
			}
		}
		
		public function mapUsages(categoryXML:XML):void {
			var dateXML:XML;
			var appXML:XML;
			var date:Date;
			var usage:Usage;
			var app:App;
			var a:Array;
			var id:String;
			
			for each (dateXML in categoryXML..date) {
				date = new Date(Date.parse(dateXML.@date + " 00:00:00 GMT-0700"));
				if (usageMap[date.time] == null) {
					usageMap[date.time] = [];
				}
				a = usageMap[date.time];
				
				for each (appXML in dateXML..app) {
					id = appXML.@id;
					app = appMap[id]
					usage = new Usage();
					usage.app = app;
					usage.duration = int(appXML.@duration);
					usage.date = date;
					a.push(usage);
				}
				a.sortOn('duration', Array.NUMERIC);
			}
		}
		
		public function setCurrentUsages(d:Date):void {
			var usages:Array = usageMap[d.time];
			currentUsages.source = usages;
			currentUsages.refresh();
		}
	
	}
}