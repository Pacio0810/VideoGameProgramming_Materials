class TextCannotBeValid(Exception):
    pass

class BrainfuckInterpreter:
    def __init__(self):
        self.tape = [0] * 30 # 30 celle
        self.head_position = 0  
        self.text = ""  # Il codice Brainfuck da eseguire
        self.index = 0  # Puntatore alla posizione corrente nel codice

    def load_text(self, text):
        self.text = text
        valid_char = "+-<>[],."
        for char in text:
            if char not in valid_char:
                raise TextCannotBeValid
        

    def execute(self):
        output = ""
        while self.index < len(self.text):
            current_char = self.text[self.index]

            # head position on tape
            if current_char == ">":
                self.head_position += 1
            elif current_char == "<":
                self.head_position -= 1

            # increment the value of the cell under the head
            elif current_char == "+":
                self.tape[self.head_position] += 1
            # decrement the value of the cell under the head
            elif current_char == "-":
                self.tape[self.head_position] -= 1

            # Output
            elif current_char == ".":
                output += chr(self.tape[self.head_position])

            # ignore input
            elif current_char == ",":
                pass

            elif current_char == "[":
                if self.tape[self.head_position] == 0:
                    # counter for [
                    loop_depth = 1
                    while loop_depth > 0:
                        self.index += 1
                        if self.text[self.index] == "[":
                            loop_depth += 1
                        elif self.text[self.index] == "]":
                            loop_depth -= 1
                else:
                    pass

            elif current_char == "]":
                if self.tape[self.head_position] != 0:
                    # counter for ]
                    loop_depth = 1
                    while loop_depth > 0:
                        self.index -= 1
                        if self.text[self.index] == "]":
                            loop_depth += 1
                        elif self.text[self.index] == "[":
                            loop_depth -= 1
                else:
                    pass

            self.index += 1

        return output


# bf = BrainfuckInterpreter()
# text = "ciao" 
# bf.load_text(text)
# output = bf.execute()
# print(output)