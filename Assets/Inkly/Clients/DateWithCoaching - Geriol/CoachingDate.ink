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


/*#Match#pause-2,5
Geriol: Oh man… Me nervous. Me not know if I can do this. What if they not come?
#Player#pause-2,5
Juliet: No worry, they come, I’ve saw them leave the bus.
#Match#pause-2,5
Geriol: Okay, goo- Whaaa! Where is that voice coming from?
#Player#pause-2,5
Juliet: Yaho! Its’a me, Juliet!
#Match#pause-2,5
Geriol: Wh- where are you? Are you in my head?
#Player#pause-2,5
Juliet: I guess? More in your soul. Look behind you.
#Match#pause-2,5
Geriol: Whoa!
#Player#pause-2,5
Juliet: Cool right? I can fly now. Wiiie!
#Match#pause-2,5
Geriol: You ghost? In my soul? Is the soul a real thing?
#Player#pause-2,5
Juliet: Not a ghost, just projecting from my booth onto here connected to you(show a shot of her spasming body at the booth??).
#Player#pause-2,5
Juliet: Souls are like a thing, ish. Complex meta things— basically yeah. Call it soulbonding. Only you can see and hear me. Told you I would be here to help.
#Match#pause-2,5
Geriol: I don’t like this. You never told me about doing this!
#Player#pause-2,5
Juliet: Just think of it like a very good walkie-talkie. I’m here to help and coach you. You will be successful if you follow my guidance.
#Match#pause-2,5
Geriol: This was a bad idea, I’m leaving!
#Player#pause-2,5
Juliet: They are here!*/

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