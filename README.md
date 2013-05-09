NSSerialisationTests
====================

Tests for NSJSONSerialization, NSPropertyListSerialization, NSKeyedArchiver

Test app for various native object serialisation APIS

Results on a 1.8GHz i7 MacBook Air:

	NSJSONSerialization 		3.577512
	NSKeyedArchiver 			8.480273
	NSPropertyListSerialization 3.176268

Winner: NSJSONSerialization