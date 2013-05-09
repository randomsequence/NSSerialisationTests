NSSerialisationTests
====================

Tests for NSJSONSerialization, NSPropertyListSerialization, NSKeyedArchiver

Test app for various native object serialisation APIs

Sample model object:

	{
	    UUID = "90B471CC-C740-4C1E-A421-EA996E34B505";
	    point = "{1026495492, 1745139186}";
	    rect = "{{1026495492, 1745139186}, {2609842131, 1633372867}
	}

Results serialising / deserialising 100,000 model objects on a 1.8GHz i7 MacBook Air (seconds):

	NSJSONSerialization 		3.577512
	NSKeyedArchiver 			8.480273
	NSPropertyListSerialization 3.176268

Winner: NSJSONSerialization