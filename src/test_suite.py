import unittest
from app import *

class TestStringMethods(unittest.TestCase):
    def test_home(self):
        self.assertEqual(home(), "<h3>Hello World!</h3>")

if __name__ == '__main__':
    unittest.main()