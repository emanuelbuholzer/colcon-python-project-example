import pep517_example_library_dependent


def test_hello_pep():
    assert example_library_dependent.wrapped_hello() == "wrapped_world_pep"
