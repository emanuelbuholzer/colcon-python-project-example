import pep517_example_library


def test_hello_pep():
    assert example_library.hello() == "world_pep"
