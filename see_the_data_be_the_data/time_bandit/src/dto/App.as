package dto {
	
	[Bindable]
	public class App {
		
		public var id:String;
		public var name:String;
		public var category:Category;
		
		public static function fromXML(x:XML):App {
			var a:App	= new App();
			a.id		= x.@id;
			a.name		= x.@name;
			return a;
		}
		
	}
}