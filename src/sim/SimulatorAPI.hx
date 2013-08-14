package sim;

import sim.Simulator;
import sim.Simulator.print;
import sim.Simulator.printHL;
import sim.Simulator.println;

class SimulatorAPI extends mcli.CommandLine {
	
	private var sim:Simulator;

	public function new( _sim:Simulator ) {
		sim = _sim;
		super();
	}

	/**
		[advanced] Run the unit tests.
	**/
	public function unitTests() {
		println( "Running the unit tests" );
		printHL( "-" );
		var app = new test.unit.UnitTests();
		app.run();
		printHL( "-" );
	}

	/**
		[advanced] Enable the code profiler.
		Only available on C++ versions; NOOP elsewhere.
	**/
	public function enableProfiling( basePath:String ) {
		sim.profiling = basePath;
	}

	/**
		[advanced] Disable the code profiler.
		Only available on C++ versions; NOOP elsewhere.
	**/
	public function disableProfiling() {
		sim.profiling = null;
	}

	/**
		[undocumented] Space for testing.
	**/
	@:access( graph.linkList.Digraph )
	public function something() {
		var v = 10;
		var a = 20;
		for ( n in 1...#if neko 4 #else 5 #end ) {
			v *= 10;
			a *= 10;
			trace( '====== #v=$v, #a=$a ======' );
			var d = new graph.linkList.Digraph();
			trace( 'initialized a new digraph' );
			var t0 = haxe.Timer.stamp();
			for ( i in 0...v )
				d.addVertex( new def.Node( i, i, i ) );
			var tel = haxe.Timer.stamp() - t0;
			trace( 'added $v vertices in $tel' );
			var auto = new def.VehicleClass( 1, 1, 1, "Auto" );
			var speed = new def.Speed();
			speed.set( auto, 60 );
			t0 = haxe.Timer.stamp();
			for ( i in 0...a ) {
				var s = d.vs.get( Std.random( v ) );
				var t = s;
				while ( s == t )
					t = d.vs.get( Std.random( v ) );
				d.addArc( new def.Link( i, s.node, t.node, Math.random()*10, speed, 0. ) );
			}
			tel = haxe.Timer.stamp() - t0;
			trace( 'added $a arcs in $tel' );
			t0 = haxe.Timer.stamp();
			var ucost = new def.UserCostModel( 1., 0., 0. );
			for ( i in 0...10 ) {
				var s = d.vs.get( i );
				d.simpleSSSPT( s.node, 0., auto, ucost );
			}
			tel = haxe.Timer.stamp() - t0;
			trace( 'ran 10 single source shortest paths in $tel' );
			trace( '... ${tel/10} per source, on average' );
			trace( "" );
		}
	}

	/**
		Show simulator version.
	**/
	public function version() {
		println( "RodoTollSim version "+Simulator.VERSION );
	}

	/**
		Show simulator version and platform information.
	**/
	public function fullVersion() {
		println( "RodoTollSim version "+Simulator.VERSION+" ("+Simulator.PLATFORM+")" );
	}

	/**
		Print usage.
	**/
	public function help() {
		println( "Usage:" );
		printHL( "-" );
		print( this.showUsage() );
		printHL( "-" );
	}

	/**
		Quit.
	**/
	public function quit() {
		Sys.exit( 0 );
	}

}
