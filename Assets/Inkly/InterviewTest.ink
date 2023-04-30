# Q: NormalQuestion = "What do you like to eat?"
# Q: StrangeQuestion = "Do you hate rocks?"
# Q: SensitiveQuestion = "Did you get enough love as a child?"
# Q: Question1 = "How many fingers am I holding up?"
# Q: Question2 = "How many hours do you sleep per night?"

EXTERNAL InterviewPreparation()
EXTERNAL NextQuestion()

-> start

=== start ===
After reading through the character sheet, you sit down.

* [Start interview planning] -> plan

=== plan ===
~InterviewPreparation()
-> END

=== NormalQuestion ===
You: What do you like to eat?
Client: uh I like sand.
* [Next] -> Next

=== StrangeQuestion ===
You: Do you hate rocks?
Client: I don't like big rocks. Small ones on the other hand (￣▽￣).

* [Next] -> Next

=== SensitiveQuestion ===
You: Did you get enough love as a child?
Client: (⊙o⊙) wtf  
* [Next] -> Next

=== Question1 ===
You: How many fingers am I holding up?
Client: 3.
* [Next] -> Next

=== Question2 ===
You: How many hours do you sleep per night?
Client: I don't sleep at night. I am an owl.
* [Next] -> Next

=== Next ===
~NextQuestion()
-> END

=== function InterviewPreparation() ===
~ return

=== function NextQuestion() ===
~ return