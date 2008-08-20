package dto {
	
	import com.degrafa.paint.SolidFill;
	
	[Bindable]
	public class Category {
		
		public var id:String;
		public var name:String;
		public var duration:int;
		public var apps:Array = [];
		public var color:Number;
		
		private var phil:SolidFill;
		
		public static function fromXML(x:XML):Category {
			var appXML:XML
			var app:App;

			var c:Category = new Category();
			c.id = x.@id;
			c.name = x.@name;
			for each (appXML in x..app) {
				app = App.fromXML(appXML);
				app.category = c;
				c.apps.push( app );
			}
			return c;
		}
		
		public function get fill():SolidFill {
			if (phil == null) {
				phil = new SolidFill();
				phil.color = color;
				if (color == 0xFFFFFF) {
					phil.alpha = 0;
				}
			}
			return phil;
		}
		
	}
}