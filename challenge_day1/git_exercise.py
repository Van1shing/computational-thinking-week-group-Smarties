# Import team modules
import iskrasavtsev
import Phoebe
import Yinan
import Yifan
import olessyuh

# Import story paragraphs
from iskrasavtsev import paragraphs as is_paragraphs
from Yinan import paragraphs as yinen_paragraphs
from Yifan import paragraphs as yifan_paragraphs
from Phoebe import paragraphs as phoebe_paragraphs
from olessyuh import paragraphs as olesya_paragraphs

# Function to print team intro
def team_intro():
    print("This is Team Smarties. We are:")
    print(iskrasavtsev.get_my_name())
    print(Phoebe.get_my_name())
    print(Yinan.get_my_name())
    print(Yifan.get_my_name())
    print(olessyuh.get_my_name())
    print()  # blank line after intro

# Function to print the story
def print_story():
    # Organize paragraphs per act
    acts = [0, 1, 2]  # indices for first, second, third paragraph of each person
    team_names = [
        ("Is", is_paragraphs),
        ("Yinen", yinen_paragraphs),
        ("Yifan", yifan_paragraphs),
        ("Phoebe", phoebe_paragraphs),
        ("Olesya", olesya_paragraphs)
    ]

    for act in acts:
        print(f"--- Act {act + 1} ---\n")
        for author_name, paragraphs in team_names:
            # Use f-string formatting in case paragraphs contain variables like {name1}, {name2}
            print(f"{author_name} says:")
            print(paragraphs[act].format(
                name1="Is",
                name2="Yinen",
                name3="Yifan",
                name4="Phoebe",
                name5="Olesya"
            ) + "\n")

# Run everything
if __name__ == "__main__":
    team_intro()
    print_story()