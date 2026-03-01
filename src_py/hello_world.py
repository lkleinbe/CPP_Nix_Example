"""Main hello world script."""

from .addition import add


def main():
    """Main entry point for the hello world application."""
    print("hello world")
    print(f"1 und 2 sind: {add(1, 2)}")


if __name__ == "__main__":
    main()
