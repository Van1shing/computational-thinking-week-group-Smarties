import iskrasavtsev
import Yinan
import Yifan
import Phoebe
import olessyuh

from is_story import paragraphs as is_paragraphs
from yinen_story import paragraphs as yinen_paragraphs
from yifan_story import paragraphs as yifan_paragraphs
from phoebe_story import paragraphs as phoebe_paragraphs
from olesya_story import paragraphs as olesya_paragraphs

# Map variables from each file
name1 = iskrasavtsev.my_name
name2 = Yinan.my_name
name3 = Yifan.my_name
name4 = Phoebe.my_name
name5 = olessyuh.my_name

def team_intro():
    print("This is Team Smarties. We are:")
    print(iskrasavtsev.my_story_name())
    print(Yinan.my_story_name())
    print(Yifan.my_story_name())
    print(Phoebe.my_story_name())
    print(olessyuh.my_story_name())
    print()

def print_story():
    acts = [0, 1, 2]
    team_names = [
        ("Is", is_paragraphs),
        ("Yinen", yinen_paragraphs),
        ("Yifan", yifan_paragraphs),
        ("Phoebe", phoebe_paragraphs),
        ("Olesya", olesya_paragraphs)
    ]

    for act in acts:
        print(f"--- Act {act+1} ---\n")
        for author_name, paragraphs in team_names:
            print(f"{author_name} says:")
            print(paragraphs[act].format(
                name1=name1, name2=name2, name3=name3, name4=name4, name5=name5
            ) + "\n")

if __name__ == "__main__":
    team_intro()
    print_story()