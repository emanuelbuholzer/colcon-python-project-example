import example_library


def wrapped_hello():
    world = example_library.hello()
    return f"wrapped_{world}"
