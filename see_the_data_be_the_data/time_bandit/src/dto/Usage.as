package dto {
	
	import model.BanditModel;
	
	[Bindable]
	public class Usage {
		
		
		public var app:App;
		public var duration:int;
		public var date:Date;

		private var tbModel:BanditModel = BanditModel.getInstance();
		 
		public function get radius():int {
			return Math.min(int(duration / tbModel.durationDivisor), 50);
		}

	}
}