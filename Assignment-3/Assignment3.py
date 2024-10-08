import random
def determine_winner(user_choice, computer_choice):
    if user_choice == computer_choice:
        return 'Tie'
    elif (user_choice == 'rock' and computer_choice == 'scissors') or \
         (user_choice == 'paper' and computer_choice == 'rock') or \
         (user_choice == 'scissors' and computer_choice == 'paper'):
        return 'User wins'
    else:
        return 'Computer wins'
    
def main():
    choices = {1: 'rock', 2: 'paper', 3: 'scissors'}
    
    a = int(input("Enter your choice: (1 for rock, 2 for paper, 3 for scissors): "))
    #b = int(input("Enter computer's choice: (1 for rock, 2 for paper, 3 for scissors): "))
    b = random.randint(1,3)
    # Convert the numeric input into a choice string
    user_choice = choices[a]
    computer_choice = choices[b]
    
    result = determine_winner(user_choice, computer_choice)
    print(f"User chose: {user_choice}")
    print(f"Computer chose: {computer_choice}")
    print(result)

if __name__ == "__main__":
    main()
    
    # Sieng Nguyen
    
