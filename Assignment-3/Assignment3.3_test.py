import unittest
from Assignment3 import determine_winner

class Assignment3Test(unittest.TestCase):
    
    def test_tie(self):
        # Test cases where both player and computer choose the same
        self.assertEqual(determine_winner("rock", "rock"), "Tie")
        self.assertEqual(determine_winner("paper", "paper"), "Tie")
        self.assertEqual(determine_winner("scissors", "scissors"), "Tie")
    
    def test_player_wins(self):
        # Test cases where player should win
        self.assertEqual(determine_winner("rock", "scissors"), "User wins")
        self.assertEqual(determine_winner("scissors", "paper"), "User wins")
        self.assertEqual(determine_winner("paper", "rock"), "User wins")
    
    def test_computer_wins(self):
        # Test cases where computer should win
        self.assertEqual(determine_winner("scissors", "rock"), "Computer wins")
        self.assertEqual(determine_winner("paper", "scissors"), "Computer wins")
        self.assertEqual(determine_winner("rock", "paper"), "Computer wins")

if __name__ == '__main__':
    unittest.main()
    
    # Sieng Nguyen
