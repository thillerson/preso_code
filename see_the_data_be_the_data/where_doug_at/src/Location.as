package {
	
	import com.google.maps.LatLng;
	
	public class Location {

		public var id:int;
		public var date:Date;
		public var lat:Number;
		public var long:Number;
		public var distanceFromHome:Number;
		
		public static function fromXML(location:XML):Location {
			var newLocation:Location = new Location();
			newLocation.id = int(location.@id[0]);
			newLocation.long = Number(location.@long[0]);
			newLocation.lat = Number(location.@lat[0]);
			newLocation.distanceFromHome = Number(location.@distance_from_home[0]);
			
			var dateString:String = location.@date
			var timeString:String = location.@time
			newLocation.date = new Date(Date.parse(dateString + " " + timeString + " GMT-0800"))
			return newLocation;
		}
		
		public function toLatLng():LatLng {
			return new LatLng(lat, long);
		}
		
	}
}