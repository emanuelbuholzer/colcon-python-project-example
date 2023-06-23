import example_library_dependent


def test_hello():
    assert example_library_dependent.wrapped_hello() == "wrapped_world"
