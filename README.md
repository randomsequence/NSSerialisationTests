NSSerialisationTests
====================

Tests for NSJSONSerialization, NSPropertyListSerialization, NSArchiver, NSKeyedArchiver

Test app for various native object serialisation APIs

Sample model object:

  {
      UUID = "90B471CC-C740-4C1E-A421-EA996E34B505";
      point = "{1026495492, 1745139186}";
      rect = "{{1026495492, 1745139186}, {2609842131, 1633372867}
  }

Results serialising / deserialising 100,000 model objects on a 2.66GHz Mac Pro (seconds):

    NSJSONSerialization         2.359547
    NSPropertyListSerialization 3.560538
    NSArchiver                  3.681572
    NSKeyedArchiver             9.563317
