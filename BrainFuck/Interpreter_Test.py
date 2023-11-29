import unittest
from Ex_BrainFuck import BrainfuckInterpreter, TextCannotBeValid

class BrainFuckTest(unittest.TestCase):

    def test_text(self):
        interpreter = BrainfuckInterpreter()
        text = "++[>++++<-]>[>+++++++++<-]>."
        interpreter.load_text(text)
        output = interpreter.execute()
        self.assertEqual(output, "H")

    def test_invalid_text(self):
        interpreter = BrainfuckInterpreter()
        text = "Hello World"

        with self.assertRaises(TextCannotBeValid):
            interpreter.load_text(text)

    
if __name__ == "__main__":
    unittest.main()