package model {
	
	import dto.Category;
	import dto.Person;
	
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;
	import mx.collections.Sort;
	import mx.collections.SortField;
	
	[Bindable]
	public class BanditModel {
		
		public static var instance:BanditModel;

		public var currentDate:Date;
		public var availableDates:ArrayCollection = new ArrayCollection();
		public var juan:Person = new Person('Juan');
		public var tony:Person = new Person('Tony');
		
		// Dear Juan,
		// please vary these variables, verily.
		public var categoryLimit:int = 4;
		public var durationLimit:int = 1800;
		public var durationDivisor:int = 200;

		private var dateMap:Dictionary = new Dictionary();
		private var currentDateIndex:int;
		
		public var comparableCategories:Object = {
			'design/presentations'	: 0xD5E200,
			'comm (other)'			: 0x00ACE5,
			'dev tools'				: 0xFF2D74,
			'business/finance'		: 0xFCFB00,
			'research/search'		: 0xFF9100,
			'system utilities'		: 0xA32290,
			'news blog'				: 0x999999,
			'fun (audio/video)'		: 0xCE9C6A,
			'social networking'		: 0xD51F1F
		}
		
		public static function getInstance():BanditModel {
			if (instance == null) {
				instance = new BanditModel();
			}
			return instance;
		}
		
		public function mapAvailableDates(dateList:XMLList):void {
			var d:Date;
			var dateXML:XML;
			for each (dateXML in dateList) {
				d = new Date(Date.parse(dateXML.@date + " 00:00:00 GMT-0700"));
				if (dateMap[d.time] == null) {
					availableDates.addItem(d);
					dateMap[d.time] = d
				}
			}
			var s:Sort = new Sort();
			s.fields = [new SortField('time', false, false, true)];
			availableDates.sort = s;
			availableDates.refresh();
		}
		
		public function advanceDate():Boolean {
			currentDate = availableDates[currentDateIndex];
			juan.setCurrentUsages(currentDate);
			tony.setCurrentUsages(currentDate);
			
			currentDateIndex++;
			if (currentDateIndex == availableDates.length) {
				return false;
			} else {
				return true;
			}
		}
		
		public function mapCategoryColors():void {
			var color:Number;
			var category:Category;
			
			for each (category in juan.categories) {
				if (comparableCategories[category.name.toLowerCase()]) {
					color = comparableCategories[category.name.toLowerCase()] as Number;
				} else {
					color = comparableCategories['other'] as Number;
				}
				category.color = color
			}

			for each (category in tony.categories) {
				if (comparableCategories[category.name.toLowerCase()]) {
					color = comparableCategories[category.name.toLowerCase()] as Number;
				} else {
					color = comparableCategories['other'] as Number;
				}
				category.color = color
			}


		}


	}
}