INCLUDE Intro.ink
INCLUDE Middle.ink
INCLUDE End.ink

// Variables representing the mood of each character.
// Should be seen as a scale from 0 - 100, where 100 is best mood.
VAR clientMood = 50
VAR matchMood = 50

// List representing the player choice.
// Note that this kind of list (elements are not surrounded by '()' like for LIST INTRO in intro)
// is more of a state machine variable. It can only be one of NO, NEUTRAL or YES.
LIST FeedBack = NO, NEUTRAL, YES

EXTERNAL getFeedBack()

// Story start. Temporarly triggered by a button press from player.
* [Start] -> IntroStart

// Function to get feedback. Must be implement in unity.
// Right now, it gets a random choice.
=== function getFeedBack() ===
{shuffle:
    - ~FeedBack = NO
    - ~FeedBack = NEUTRAL
    - ~FeedBack = YES
}
~ return

// Function to increase (or decrease) mood. Could be implemented in unity.
=== function changeMood(ref mood, value) ===
~ temp newValue = mood + value 
{
 - newValue < 0:
    ~mood = 0
 - newValue > 100:
    ~mood = 100
 - else:
    ~mood = newValue
}

// Function to set check mood. Could be implemented in unity.
=== function checkMood(ref mood, threshold) ===
{
 - mood < threshold:
    ~return false
 - else:
    ~return true
}