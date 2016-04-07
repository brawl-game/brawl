tests:
	run_tests -c

docs:
	dartdoc

sample:
	dart example/brawl.dart

setup:
	pub global activate test_runner
	run_tests -c
