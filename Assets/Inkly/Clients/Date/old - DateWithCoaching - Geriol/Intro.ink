
// Intro page. Here we can find all intro stories and their branches.

// List containing all possible stories. 
// We can set each element to false in order to know when we cannot choose new intros.
LIST INTRO = (introWeather), (introTwo), (introThree)

// Example variable that can be used to have some memory of previous choice.
// If complete memory is required, each choice should be a unique branch.
VAR OverExcited = false

// Functional knot to pick intro. Call when a new intro is needed.
// If all intros are used, the story ends.
=== pickIntro ===
{LIST_COUNT(INTRO) == 0: 
    #Client#pause-2,5
    Oh I just remember, my stove is on at home. cya.
    -> END
}

~temp value = LIST_RANDOM(INTRO)
{value:
    - introWeather:
        ~ INTRO -= introWeather
        -> IntroArrive
    - introTwo:
        ~ INTRO -= introTwo
        -> IntroSorry
    - introThree:
        ~INTRO -= introThree
        -> IntroWeather
}
-> END

// Entry knot for intro, only happens once.
// Call from main.
=== IntroStart ===
#Narrator#pause-2,5
The day has come for the date. Its a sunny day with a nice breeze at the park where Geriol is waiting at a bench nervously.

#Narrator#pause-2,5
The date comes up to Geriol.

#Match#pause-2,5
Dave: Hello! Sorry I’m late, are you Geriol?
#Client#pause-2
Geriol: Ah! Y-yes that is I, Me, that person… Sorry what was your name again?
#Match#pause-2,5
Dave: No problem, I’m Dave. Nice to meet you.
#Client#pause-2
Geriol: Nice to meet you too. I’m Geriol. Again…

-> pickIntro

// Ending knot for intro, call at the end to check mood and start middle story.
=== IntroEnd ===
~ temp cm = checkMood(clientMood, 50)
~ temp mm = checkMood(matchMood, 50)
{
 - cm && mm: -> MiddleStart                                         // If client and match mood is good.
 - !cm && !mm:                                                      // If client and match mood is bad
    #Match#pause-2,5
    Dave: This is akward dont you think?
    #Client#pause-2,5
    Geriol: Yes, I agree bye.
 - !cm:                                                             // If client mood is bad.
    #Client#pause-2,5
    Geriol: hey this was great but I have to run
 - !mm:                                                             // If match mood is bad.
    #Match#pause-2,5
    Dave: oh someone is calling, brb (runs away)
}
-> END
        
////////// Start of the weather intro conversation ////////// 

// Knot representing the weather intro exchange.
// This is an example of how a story can be written. 
// I chose to use tunnels, where it goes down but then up in the story.
// Can also just have branching, when we care about previous choices.
=== IntroArrive ===
#EnableFeedBack                                                     // Use this tag to tell unity to record player input. Can be a timer also.    
#Client#pause-2,5
Geriol: Did you get here okay? Live close-by?

#DisableFeedBack
~getFeedBack()
{FeedBack:
   - NO:
     #Client#pause-2,5
     Geriol: Never mind, that might not be important.
     ~changeMood(clientMood, -5)                               // Decrease client mood after we tell it that it should not talk about the weather.
     ~changeMood(matchMood, 5)                                 // Increase match mood, it doesn't like to talk about weather..
     -> pickIntro()                                            // Here, we told the client no right away. Story could now lead to another intro
   - NEUTRAL:
      -> IntroArriveNeutral1 ->    
   - YES:
      -> IntroArriveYes1 ->
}
~getFeedBack()
{FeedBack:
   - NO:                                        
     #Client#pause-2,5
     {OverExcited: Sorry I get too excited, the weather is not that cool | Ah but wind isnt that exciting }
      ~OverExcited = false
      -> pickIntro                                              // Here, we told the client no in the second round. Here it also could go to a "no" option
                                                                // instead of going back to a new intro.
   - NEUTRAL:
     #Match#pause-2,5
     {OverExcited: wind? Yes sure, but have you tried their pasta? | I love the ice cream kingdom, their pasta is so good, have you tried it?  }
      -> IntroArriveNeutral2 ->
   - YES:
     #Match#pause-2,5
     {OverExcited: wind? Yes sure, but have you tried their pasta? | I love the ice cream kingdom, their pasta is so good, have you tried it?  }
      -> IntroArriveYes2 ->
}
-> IntroEnd


///// Start of choice 1

// Knot for neutral choice 1. The story here could be kept the same as the Yes choice. 
// If it is different, then further knots should be called from here instead of going back up with '->->'
=== IntroArriveNeutral1  ===
#Match#pause-2,5
Dave: Uhm, yeah! I got here good. I live 2 buses away. Some accident on road make me late.
#Client#pause-2,5
Geriol: I see. Good you make it here. 
#Match#pause-2,5
Dave: What about you?
#Client#pause-2,5
Geriol: I just walked. Or more like ran. Thought I would be late. Alarm broke so woke up late.

#EnableFeedBack
#Match#pause-2,5
Dave: Sounds very stressful though if you had to run far.
#DisableFeedBack
~changeMood(clientMood, 5)
~changeMood(matchMood, 5)
->->

// Knot for yes choice 1.
=== IntroArriveYes1 ===
#Match#pause-2,5
Dave: Uhm, yeah! I got here good. I live 2 buses away. Some accident on road make me late.
#Client#pause-2,5
Geriol: Oh my! What kind?
#Match#pause-2,5
Dave: Not sure. Not look out window. Reading book. I’m very distracted.
#Client#pause-2,5
Geriol: …What? sorry, I got distracted. Something about a book?
#Match#pause-2,5
Dave: Hehe, that’s cool. Yeah, I read a very nerdy book and missed the accident.
#Client#pause-2,5
Geriol: What’s it about?
#Match#pause-2,5
Dave: Stuff about gravitational stuff and such. Mostly focused on celestial stuff.
#Client#pause-2,5
Geriol: Oh! Sounds very interesting. Me probably like.
#Match#pause-2,5
Dave: Not sure. Very mathy.
#Client#pause-2,5
Geriol: I’m very into math.
#Match#pause-2,5
Dave: Really so? Want me show? Here.
#Client#pause-2,5
Geriol: Cool. Me remember to get it.
#Match#pause-2,5
Dave: Sound good good.

#EnableFeedBack
#Match#pause-2,5
Dave: Sound good good.
~OverExcited = true
~changeMood(clientMood, 10)
~changeMood(matchMood, 5)
#DisableFeedBack
->->

///// Start of choice 2

// Knot for neutral choice 2.
// Uses the OverExcited variable. This enables selective memory from previous events.
=== IntroArriveNeutral2 ===
#Client#pause-2,5
{
- OverExcited:                                                      // If overExicted is true
Geriol: Maybe show me more of the book later?
#Match#pause-2,5
Dave: Yeah if interested.
#Client#pause-2,5
Geriol: Yeah me pretty interested. Got a big shelf of books!
#Match#pause-2,5
Dave: Read a lot?
#Client#pause-2,5
Geriol: …Eventually of course. Just haven’t had the time yet.
#Match#pause-2,5
Dave: Have you made the time for it?
#Client#pause-2,5
Geriol: …I gotta MAKE my own time for it? Haven’t thought about it like that?
#Match#pause-2,5
Dave: Easier to not think like that. I try to forget that kind of thinking so I don’t feel as guilty.
#Client#pause-2,5
Geriol: I already feel the guilt eating at me. Or it’s just hunger. You hungry?
#Match#pause-2,5
Dave: I could eat something. 
~changeMood(clientMood, 5)
- !OverExcited:
#Client#pause-2,5
Geriol: No I just had to get around a few corners and then I got here. Just had to stuff some breakfast in mouth.
#Match#pause-2,5
Dave: Think you still got some on.
#Client#pause-2,5
Geriol: Oh no! Gone now?
#Match#pause-2,5
Dave: …Sure!
#Client#pause-2,5
Geriol: Hehe…
}
~OverExcited = false
~changeMood(clientMood, 3)
~changeMood(matchMood, 3)
->->

// Knot for yes choice 2.
=== IntroArriveYes2 === 
#Client#pause-2,5
{
- OverExcited: 
Geriol: Maybe show me more of the book later?
#Match#pause-2,5
Dave: Yeah if interested.
#Client#pause-2,5
Geriol: But 2 buses away? pretty far away. Glad you could bother to come and meet.
#Match#pause-2,5
Dave: Of course. Gotta make some effort to get anything.
#Client#pause-2,5
Geriol: A lot of effort from me. Just walk a little.
#Match#pause-2,5
Dave: It’s still more than I do on daily basis.
#Client#pause-2,5
Geriol: Haha, hard to believe.
#Match#pause-2,5
Dave: You should have seen me walking from bus. Sweaty.
#Client#pause-2,5
Geriol: Me think we both have hard to do these stuff.
#Match#pause-2,5
Dave: Pretty much so.
#Client#pause-2,5
Geriol: Easier to just stay at home.
#Match#pause-2,5
Dave: Exactly! Big brains here.
#Client#pause-2,5
Geriol: Definitely.

~changeMood(matchMood, 20)
~changeMood(clientMood, 20) 
- !OverExcited:
#Client#pause-2,5
Geriol: Maybe show me more of the book later?
#Match#pause-2,5
Dave: Yeah if interested.
#Client#pause-2,5
Geriol: Yeah me pretty interested. Got a big shelf of books!
#Match#pause-2,5
Dave: Read a lot?
#Client#pause-2,5
Geriol: …Eventually of course. Just haven’t had the time yet.
#Match#pause-2,5
Dave: Have you made the time for it?
#Client#pause-2,5
Geriol: …I gotta MAKE my own time for it? Haven’t thought about it like that?
#Match#pause-2,5
Dave: Easier to not think like that. I try to forget that kind of thinking so I don’t feel as guilty.
#Client#pause-2,5
Geriol: I already feel the guilt eating at me. Or it’s just hunger. You hungry?
#Match#pause-2,5
Dave: I could eat something.
}
~OverExcited = false

->->

////////// Start of anothter intro conversation ////////// 

// Unimplemented 
=== IntroSorry ===
#Client#pause-2,5
I dont want to talk about this (2)
 -> pickIntro()

////////// Start of yet anothter intro conversation ////////// 

// Unimplemented
=== IntroWeather ===
#Client#pause-2,5
I dont want to talk about this (3)
 -> pickIntro()