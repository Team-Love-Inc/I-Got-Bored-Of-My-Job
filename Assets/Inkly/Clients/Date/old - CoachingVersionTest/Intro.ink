
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
        -> IntroWeather
    - introTwo:
        ~ INTRO -= introTwo
        -> IntroTwo
    - introThree:
        ~INTRO -= introThree
        -> IntroThree
}
-> END

// Entry knot for intro, only happens once.
// Call from main.
=== IntroStart ===
#Client#pause-2
Hello hi, my is bobby.
#Match#pause-2,5
Hi, ah my name is donald.
-> pickIntro

// Ending knot for intro, call at the end to check mood and start middle story.
=== IntroEnd ===
~ temp cm = checkMood(clientMood, 50)
~ temp mm = checkMood(matchMood, 50)
{
 - cm && mm: -> MiddleStart                                         // If client and match mood is good.
 - !cm && !mm:                                                      // If client and match mood is bad
    #Match#pause-2,5
    This is akward dont you think?
    #Client#pause-2,5
    Yes, I agree bye.
 - !cm:                                                             // If client mood is bad.
    #Client#pause-2,5
    hey this was great but I have to run
 - !mm:                                                             // If match mood is bad.
    #Match#pause-2,5
    oh someone is calling, brb (runs away)
}
-> END
        
////////// Start of the weather intro conversation ////////// 

// Knot representing the weather intro exchange.
// This is an example of how a story can be written. 
// I chose to use tunnels, where it goes down but then up in the story.
// Can also just have branching, when we care about previous choices.
=== IntroWeather ===
#EnableFeedBack-5                                                     // Use this tag to tell unity to record player input. Can be a timer also.    
#Client#pause-2,5
Nice weather we're having right?
#Match#pause-2,5
Yes its quite sunny
#DisableFeedBack
~getFeedBack()
{FeedBack:
   - NO:
     #Client#pause-2,5
     Never mind, the weather is boring..
     ~changeMood(clientMood, -5)                               // Decrease client mood after we tell it that it should not talk about the weather.
     ~changeMood(matchMood, 5)                                 // Increase match mood, it doesn't like to talk about weather..
     -> pickIntro()                                             // Here, we told the client no right away. Story could now lead to another intro
   - NEUTRAL:
      -> IntroWeatherNeutral1 ->    
   - YES:
      -> IntroWeatherYes1 ->
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
      -> IntroWeatherNeutral2 ->
   - YES:
     #Match#pause-2,5
     {OverExcited: wind? Yes sure, but have you tried their pasta? | I love the ice cream kingdom, their pasta is so good, have you tried it?  }
      -> IntroWeatherYes2 ->
}
-> IntroEnd


///// Start of choice 1

// Knot for neutral choice 1. The story here could be kept the same as the Yes choice. 
// If it is different, then further knots should be called from here instead of going back up with '->->'
=== IntroWeatherNeutral1  ===
#Client#pause-2,5
Yea, yesterday it was raining. I don't really like rain.
#Match#pause-2,5
.. rain is atleast good for the plants
#Client#pause-2,5
well it makes you wet and that is not nice
#EnableFeedBack-2,5
#Client#pause-2,5
It was very windy when I visited the ice cream kingdom last week.
#DisableFeedBack
~changeMood(clientMood, 5)
~changeMood(matchMood, 5)
->->

// Knot for yes choice 1.
=== IntroWeatherYes1 ===
#Client#pause-2,5
Yes!! And yesterday it was raining?? I hate rain soo much.
#Match#pause-2,5
.. uh rain is not that bad
#Client#pause-2,5
It destorys my clothes and its soo annoying!!
#EnableFeedBack-2,5
#Client#pause-2,5
OOOOOOOH I just rememberd. There were SO MUCH WIND when I visited the ice cream kingdom last week. WIND IS SO COOL.
~OverExcited = true
~changeMood(clientMood, 10)
~changeMood(matchMood, -10)
#DisableFeedBack
->->

///// Start of choice 2

// Knot for neutral choice 2.
// Uses the OverExcited variable. This enables selective memory from previous events.
=== IntroWeatherNeutral2 ===
#Client#pause-2,5
{OverExcited: 
  - Right, nvm the wind. Yes, their pasta is so tasty.                      // If overExicted is true
    ~changeMood(clientMood, -2)
 - Yes I love them too, and their pasta is so nice.
 }
~OverExcited = false
#Match#pause-2,5
and the architecture is so cool too. Lots of ice cream.
~changeMood(clientMood, 2)
~changeMood(matchMood, 2)
->->

// Knot for yes choice 2.
=== IntroWeatherYes2 === 
#Client#pause-2,5
{OverExcited: 
    - AH their pasta is cool I guess..  but THE WIND IS SO STRONG???
        ~changeMood(matchMood, -20)
        ~changeMood(clientMood, 20)
    - yea its tasty, but the wind is SO COOL THERE!
        ~changeMood(matchMood, -5)
        ~changeMood(clientMood, 20)
}
#Match#pause-2,5
.. I didn't noice the wind at all? I did see loads of ice cream houses though.
->->

////////// Start of anothter intro conversation ////////// 

// Unimplemented 
=== IntroTwo ===
#Client#pause-2,5
I dont want to talk about this (2)
 -> pickIntro()

////////// Start of yet anothter intro conversation ////////// 

// Unimplemented
=== IntroThree ===
#Client#pause-2,5
I dont want to talk about this (3)
 -> pickIntro()