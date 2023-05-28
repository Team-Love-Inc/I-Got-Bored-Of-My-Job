
// Intro page. Here we can find all intro stories and their branches.

// List containing all possible stories. 
// We can set each element to false in order to know when we cannot choose new intros.
LIST INTRO = (introArrive), (introSorry), (introWeather)

// Example variable that can be used to have some memory of previous choice.
// If complete memory is required, each choice should be a unique branch.
VAR OverExcited = false
# N: Match = Dave
# N: Client = Geriol

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
    - introArrive:
        ~ INTRO -= introArrive
        -> IntroArrive
    - introSorry:
        ~ INTRO -= introSorry
        -> IntroSorry
    - introWeather:
        ~INTRO -= introWeather
        -> IntroWeather
}
-> END

// Entry knot for intro, only happens once.
// Call from main.
=== IntroStart ===
#Narrator#pause-2,5
The date comes up to Geriol.
#Match#pause-2,5
Hello! Sorry I’m late, are you Geriol? //Dave
#Client#pause-2
 Ah! Y-yes that is I, Me, that person… Sorry what was your name again? //Geriol
#Match#pause-2,5
 No problem, I’m Dave. Nice to meet you. //Dave
#Client#pause-2
 Nice to meet you too. I’m Geriol. Again… //Geriol

-> pickIntro

// Ending knot for intro, call at the end to check mood and start middle story.
=== IntroEnd ===
~ temp cm = checkMood(clientMood, 50)
~ temp mm = checkMood(matchMood, 50)
{clientMood} {matchMood}
{
 - cm && mm: -> MiddleStart                                         // If client and match mood is good.
 - !cm && !mm:                                                      // If client and match mood is bad
    #Match#pause-2,5
     This is akward dont you think? //Dave
    #Client#pause-2,5
     Yes, I agree bye. //Geriol
 - !cm:                                                             // If client mood is bad.
    #Client#pause-2,5
     hey this was great but I have to run //Geriol
 - !mm:                                                             // If match mood is bad.
    #Match#pause-2,5
     oh someone is calling, brb (runs away) //Dave
}
-> END
        
////////// Start of the weather intro conversation ////////// 

// Knot representing the weather intro exchange.
// This is an example of how a story can be written. 
// I chose to use tunnels, where it goes down but then up in the story.
// Can also just have branching, when we care about previous choices.
=== IntroArrive ===
#EnableFeedBack-2,5                                                     // Use this tag to tell unity to record player input. Can be a timer also.    
#Client#pause-2,5
 Did you get here okay? Live close-by? //Geriol

#DisableFeedBack
~getFeedBack()
{FeedBack:
   - NO:
     #Client#pause-2,5
      Never mind, that might not be important. //Geriol
     ~changeMood(clientMood, -5)                               // Decrease client mood after we tell it that it should not talk about the weather.
     ~changeMood(matchMood, 5)                                 // Increase match mood, it doesn't like to talk about weather..
     -> pickIntro()                                             // Here, we told the client no right away. Story could now lead to another intro
   - NEUTRAL:
      -> IntroArriveNeutral1 ->    
   - YES:
      -> IntroArriveYes1 ->
}
-> IntroEnd


///// Start of choice 1

// Knot for neutral choice 1. The story here could be kept the same as the Yes choice. 
// If it is different, then further knots should be called from here instead of going back up with '->->'
=== IntroArriveNeutral1  ===
#Match#pause-2,5
 Uhm, yeah! I got here good. I live 2 buses away. Some accident on road make me late. //Dave
#Client#pause-2,5
 I see. Good you make it here. //Geriol
#Match#pause-2,5
 What about you? //Dave
#Client#pause-2,5
 I just walked. Or more like ran. Thought I would be late. Alarm broke so woke up late. //Geriol

#EnableFeedBack-2,5
#Match#pause-2,5
 Sounds very stressful though if you had to run far. //Dave
#DisableFeedBack
~changeMood(clientMood, 5)
~changeMood(matchMood, 5)

~getFeedBack()
{FeedBack:
   - NO:                                        
      ~OverExcited = false
      -> No1->                                             // Here, we told the client no in the second round. Here it also could go to a "no" option
                                                                // instead of going back to a new intro.
   - NEUTRAL:
      ->->  
   - YES:
      ->->
}
->->
= No1
#Client#pause-2,5
 Not so far. You? //Geriol
#Match#pause-2,5
 Already told you I took the bus. //Dave
#Client#pause-2,5
 Right right… //Geriol
#Match#pause-2,5
 … //Dave
#Client#pause-2,5
 Wanna go and sit down somewhere? //Geriol
#Match#pause-2,5
 Sure sure. //Dave
~changeMood(clientMood, -2)
~changeMood(matchMood, -5)
->->

// Knot for yes choice 1.
=== IntroArriveYes1 ===
#Match#pause-2,5
 Uhm, yeah! I got here good. I live 2 buses away. Some accident on road make me late. //Dave
#Client#pause-2,5
 Oh my! What kind? //Geriol
#Match#pause-2,5
 Not sure. Not look out window. Reading book. I’m very distracted. //Dave
#Client#pause-2,5
 …What? sorry, I got distracted. Something about a book? //Fly flies by? Geriol
#Match#pause-2,5
 Hehe, that’s cool. Yeah, I read a very nerdy book and missed the accident. //Dave
#Client#pause-2,5
 What’s it about? //Geriol
#Match#pause-2,5
 Stuff about gravitational stuff and such. Mostly focused on celestial stuff. //Dave
#Client#pause-2,5
 Oh! Sounds very interesting. Me probably like. //Geriol
#Match#pause-2,5
 Not sure. Very mathy. //Dave
#Client#pause-2,5
 I’m very into math. //Geriol
#Match#pause-2,5
 Really so? Want me show? Here. //Dave
#Client#pause-2,5
 Cool. Me remember to get it. //Geriol

#EnableFeedBack-2,5
#Match#pause-2,5
 Sound good good.
~OverExcited = true
~changeMood(clientMood, 10)
~changeMood(matchMood, 10)
#DisableFeedBack
~getFeedBack()
{FeedBack:
   - NO:                                        
      ~OverExcited = false
      -> No1->                                             // Here, we told the client no in the second round. Here it also could go to a "no" option
                                                                // instead of going back to a new intro.
   - NEUTRAL:
      ->->  
   - YES:
      ->->
}
->->
= No1
#Client#pause-2,5
 Maybe show me more of the book later? //Geriol
#Match#pause-2,5
 Yeah if interested. //Dave
~changeMood(clientMood, -5)
~changeMood(matchMood, -5)
->->

///// Start of choice 2

// Knot for neutral choice 2.
// Uses the OverExcited variable. This enables selective memory from previous events.
=== IntroArriveNeutral2 ===
#Client#pause-2,5
{
- OverExcited:
 Maybe show me more of the book later? //Geriol
#Match#pause-2,5
 Yeah if interested. //Dave
#Client#pause-2,5
 Yeah me pretty interested. Got a big shelf of books! //Geriol
#Match#pause-2,5
 Read a lot? //Dave
#Client#pause-2,5
 …Eventually of course. Just haven’t had the time yet. //Geriol
#Match#pause-2,5
 Have you made the time for it? //Dave
#Client#pause-2,5
 …I gotta MAKE my own time for it? Haven’t thought about it like that? //Geriol
#Match#pause-2,5
 Easier to not think like that. I try to forget that kind of thinking so I don’t feel as guilty. //Dave
#Client#pause-2,5
 I already feel the guilt eating at me. Or it’s just hunger. You hungry? //Geriol
#Match#pause-2,5
 I could eat something.  //Dave

                       // If overExicted is true
    ~changeMood(clientMood, 5)
    ~changeMood(matchMood, 5)
 - !OverExcited:
#Client#pause-2,5
 No I just had to get around a few corners and then I got here. Just had to stuff some breakfast in mouth. //Geriol
#Match#pause-2,5
 Think you still got some on. //Dave
#Client#pause-2,5
 Oh no! Gone now? //Geriol
#Match#pause-2,5
 …Sure! //Dave
#Client#pause-2,5
 Hehe… //Geriol

 
~OverExcited = false
~changeMood(clientMood, 3)
~changeMood(matchMood, 3)
}
->->

// Knot for yes choice 2.
=== IntroArriveYes2 === 
#Client#pause-2,5
{
- OverExcited: 
 Maybe show me more of the book later? //Geriol
#Match#pause-2,5
 Yeah if interested. //Dave
#Client#pause-2,5
 But 2 buses away? pretty far away. Glad you could bother to come and meet. //Geriol
#Match#pause-2,5
 Of course. Gotta make some effort to get anything. //Dave
#Client#pause-2,5
 A lot of effort from me. Just walk a little. //Geriol
#Match#pause-2,5
 It’s still more than I do on daily basis. //Dave
#Client#pause-2,5
 Haha, hard to believe. //Geriol
#Match#pause-2,5
 You should have seen me walking from bus. Sweaty. //Dave
#Client#pause-2,5
 Me think we both have hard to do these stuff. //Geriol
#Match#pause-2,5
 Pretty much so. //Dave
#Client#pause-2,5
 Easier to just stay at home. //Geriol
#Match#pause-2,5
 Exactly! Big brains here. //Dave
#Client#pause-2,5
 Definitely. //Geriol

        ~changeMood(matchMood, 20)
        ~changeMood(clientMood, 20) 
        
- !OverExcited:

#Client#pause-2,5
 Not very long. Me live like 10 minutes ago. //Geriol
#Match#pause-2,5
 Sound very convenient. //Dave
#Client#pause-2,5
 Yes but the area around place very sketchy. //Geriol
#Match#pause-2,5
 You live very central, to be expected? //Dave
#Client#pause-2,5
 It is expected for me next time. Just took very cheap. You live in sketchy place? //Geriol
#Match#pause-2,5
 Would not say sketchy, but we got our funny characters around. //Dave
#Client#pause-2,5
 What they do? //Geriol
#Match#pause-2,5
 Like to dress like a mermaid and pretend swim on the street. //Dave
#Client#pause-2,5
 Sounds scary. //Geriol
#Match#pause-2,5
 Think they just like to do those stuff. Haven’t talked with them but I try to say hello and they sound happy. //Dave

~OverExcited = false
        ~changeMood(matchMood, 10)
        ~changeMood(clientMood, 10) 
}
->->

////////// Start of anothter intro conversation ////////// 

// Unimplemented 
=== IntroSorry ===
#EnableFeedBack-2,5                                                    // Use this tag to tell unity to record player input. Can be a timer also.    
#Client#pause-2,5
 …Sorry, haven’t been many dates. Not sure how to start. //Geriol

#DisableFeedBack
~getFeedBack()
{FeedBack:
   - NO:
     #Client#pause-2,5
      Never mind, that might not be important. //Geriol
     ~changeMood(clientMood, -5)                               // Decrease client mood after we tell it that it should not talk about the weather.
     ~changeMood(matchMood, 5)                                 // Increase match mood, it doesn't like to talk about weather..
     -> pickIntro()                                             // Here, we told the client no right away. Story could now lead to another intro
   - NEUTRAL:
      -> IntroSorryNeutral1 ->    
   - YES:
      -> IntroSorryYes1 ->
}
-> IntroEnd


///// Start of choice 1

// Knot for neutral choice 1. The story here could be kept the same as the Yes choice. 
// If it is different, then further knots should be called from here instead of going back up with '->->'
=== IntroSorryNeutral1  ===
#Match#pause-2,5
 No worry, I no know much either. What usually talk about? //Dave
#Client#pause-2,5
 Don’t know… Don’t want bore you either. Talk weather? //Geriol
#Match#pause-2,5
 I suppose…? Uh, nice weather. Warm, comfy. //Dave
#Client#pause-2,5
 *laugh* Yes, warm, comfy. Good description. Photosynthesis is cool. //Geriol

#EnableFeedBack-2,5
#Match#pause-2,5
 It is. Not many clouds either. //Dave
~changeMood(clientMood, 5)
~changeMood(matchMood, 5)
#DisableFeedBack
~getFeedBack()
{FeedBack:
   - NO:                                        
      ~OverExcited = false
      -> No1->                                             // Here, we told the client no in the second round. Here it also could go to a "no" option
                                                                // instead of going back to a new intro.
   - NEUTRAL:
      ->->  
   - YES:
      ->->
}
->->
= No1
#Client#pause-2,5
 Nice with nice weather. Makes picnic easier. No umbrella. //Geriol
#Match#pause-2,5
 No wind either. Comfy. //Dave
#Client#pause-2,5
 Yes. Let’s find place. //Geriol
~changeMood(clientMood, 5)
~changeMood(matchMood, 5)
->->

// Knot for yes choice 1.
=== IntroSorryYes1 ===
#Match#pause-2,5
 No worry, I no know much either. What usually talk about? //Dave
#Client#pause-2,5
 We say name, that’s start! //Geriol
#Match#pause-2,5
 *Laugh* Yes, that start. I don’t go outside meeting other much. //Dave
#Client#pause-2,5
 Me neither! Stay home most time. Like being alone. But alone become lonely. //Geriol

#EnableFeedBack-2,5
#Match#pause-2,5
 Know what mean. Same here. Glad you feel same! //Dave
~OverExcited = true
~changeMood(clientMood, 10)
~changeMood(matchMood, 5)
#DisableFeedBack
~getFeedBack()
{FeedBack:
   - NO:                                        
      ~OverExcited = false
      -> No1->                                             // Here, we told the client no in the second round. Here it also could go to a "no" option
                                                                // instead of going back to a new intro.
   - NEUTRAL:
      ->->  
   - YES:
      ->->
}
->->
= No1
#Client#pause-2,5
 Glad you think so. I’m sure we be fine. Seem to have much talk about already without knowing what do. //Geriol
#Match#pause-2,5
 Yes. No pressure. //Dave
#Client#pause-2,5
 Yes. //Geriol
~changeMood(clientMood, 10)
~changeMood(matchMood, 10)
->->
->->

///// Start of choice 2

// Knot for neutral choice 2.
// Uses the OverExcited variable. This enables selective memory from previous events.
=== IntroSorryNeutral2 ===
#Client#pause-2,5
{
- OverExcited:
 I glad you feel same too. Thank you for agreeing date. Or, no need to be date. Want someone spend time with. //Geriol
#Match#pause-2,5
 Oh, your friend no say that. No worry, we go what feels best then. I don’t mind either. Nice to have friend too. //Dave
#Client#pause-2,5
 Yes, let’s see. So far, you’re very nice. //Geriol
#Match#pause-2,5
 You’re very nice too. Even if it be both our first date time. //Dave

                       // If overExicted is true
    ~changeMood(clientMood, 5)
    ~changeMood(matchMood, 10)
 - !OverExcited:
#Client#pause-2,5
 You know most photosynthesis happen out in sea under water? //Geriol
#Match#pause-2,5
 Yes, it cool. People only see tree and flowers. Below water important too. //Dave
#Client#pause-2,5
 Yes, water nice. Flowers nicer to see though. //Geriol
#Match#pause-2,5
 You like flowers?
#Client#pause-2,5
 No clear opinion. Nice to see, smell lots, but unfamiliar. //Geriol
#Match#pause-2,5
 Ecosystem is very cool. Flowers important for many things. //Dave
 
~OverExcited = false
~changeMood(clientMood, 3)
~changeMood(matchMood, 3)
}
->->

// Knot for yes choice 2.
=== IntroSorryYes2 === 
#Client#pause-2,5
{
- OverExcited: 
 Me too! Usually stay inside at computer. Easiest to interact with. //Geriol
#Match#pause-2,5
 Know what mean. Computers easier than people. Computers have algorithm to follow. People be emotional and unpredictable. //Dave
#Client#pause-2,5
 Me don’t want others to dislike me either. Hard to know what say and do. Haven’t been on surface very long… //Geriol
#Match#pause-2,5
 Oh? Where from?  //Dave
#Client#pause-2,5
 River community. //Geriol
#Match#pause-2,5
 Oooh, cool. //Dave

        ~changeMood(matchMood, 20)
        ~changeMood(clientMood, 20) 
        
- !OverExcited:

#Client#pause-2,5
 Look, cloud like dog! //Geriol
#Match#pause-2,5
 Yes, I see. Oh, kite flying there. Didn’t think it blew enough to fly. //Dave
#Client#pause-2,5
 No feel much wind. Could be magic too… //Geriol
#Match#pause-2,5
 Could be magic, yes. At least kid having fun. Haven’t played kite a long time. //Dave
#Client#pause-2,5
 Me neither… Play together sometime when windy? //Geriol
#Match#pause-2,5
 Could try. Not sure me good, though. //Dave
#Client#pause-2,5
 I haven’t been out much, not sure good either. We’ll see! //Geriol

~OverExcited = false
        ~changeMood(matchMood, 10)
        ~changeMood(clientMood, 10) 
}
->->
 -> pickIntro()

////////// Start of yet anothter intro conversation ////////// 

// Unimplemented
=== IntroWeather ===
#EnableFeedBack                                                     // Use this tag to tell unity to record player input. Can be a timer also.    
#Client#pause-2,5
 …THE WEATHER SURE IS NICE SO FAR! Didn’t look at today's forecast how it will stay. Have you? //Geriol

#DisableFeedBack
~getFeedBack()
{FeedBack:
   - NO:
     #Client#pause-2,5
      Never mind, that might not be important. //Geriol
     ~changeMood(clientMood, -5)                               // Decrease client mood after we tell it that it should not talk about the weather.
     ~changeMood(matchMood, 5)                                 // Increase match mood, it doesn't like to talk about weather..
     -> pickIntro()                                             // Here, we told the client no right away. Story could now lead to another intro
   - NEUTRAL:
      -> IntroWeatherNeutral1 ->    
   - YES:
      -> IntroWeatherYes1 ->
}
-> IntroEnd


///// Start of choice 1

// Knot for neutral choice 1. The story here could be kept the same as the Yes choice. 
// If it is different, then further knots should be called from here instead of going back up with '->->'
=== IntroWeatherNeutral1  ===
#Match#pause-2,5
 Ah, no, haven’t seen forecast. Don’t know how weather be. //Dave
#Client#pause-2,5
 Then, we can only hope it stays nice. At least no wind to blow things away. //Geriol
#Match#pause-2,5
 Yes, much wind would be annoying. //Dave
#Client#pause-2,5
 Would be hard taking out blanket with wind. But wind good for kite fly. //Geriol
#Match#pause-2,5
 True. Oh, kite fly there. See? How fly with no wind…? //Dave
#Client#pause-2,5
 Magic wind…? No too important. //Geriol

#EnableFeedBack
#Match#pause-2,5
 True. //Dave
#DisableFeedBack
~changeMood(clientMood, -10)
~changeMood(matchMood, -10)

~getFeedBack()
{FeedBack:
   - NO:                                        
      ~OverExcited = false
      -> No1->                                             // Here, we told the client no in the second round. Here it also could go to a "no" option
                                                                // instead of going back to a new intro.
   - NEUTRAL:
      ->->  
   - YES:
      ->->
}
->->
= No1
#Client#pause-2,5
 As long kid having fun and kite no crash on us, it fine. //Geriol
#Match#pause-2,5
 Yes. Seems having fun. //Dave
#Client#pause-2,5
 Seems like, yes. Let’s find somewhere to sit. //Geriol
~changeMood(clientMood, -5)
~changeMood(matchMood, -5)
->->

// Knot for yes choice 1.
=== IntroWeatherYes1 ===
#Match#pause-2,5
 Ah, no, haven’t seen forecast. Don’t know how weather be. //Dave
#Client#pause-2,5
 Oh, too bad. If enough clouds, could have mix of sun and cloud and have nice shade time while picnic. That nice, yes? //Geriol
#Match#pause-2,5
 Uh, yes. That nice.  //Dave
#Client#pause-2,5
 Not much wind either. Could have brought umbrella for shade, too. Would be good if it rain to have umbrella.  //Geriol
#Match#pause-2,5
 R-Right… //Dave
#Client#pause-2,5
 Not I think it rain, want sun, but can never be too prepared! You like the sun? //Geriol

#EnableFeedBack-2,5
#Match#pause-2,5
 Sun is important to survive, so.. Yes? //Dave
~OverExcited = true
~changeMood(clientMood, -10)
~changeMood(matchMood, -10)
#DisableFeedBack
~getFeedBack()
{FeedBack:
   - NO:                                        
      ~OverExcited = false
      -> No1->                                             // Here, we told the client no in the second round. Here it also could go to a "no" option
                                                                // instead of going back to a new intro.
   - NEUTRAL:
      ->->  
   - YES:
      ->->
}
->->
= No1
#Client#pause-2,5
 Right, yes. Sun is important. Gives life to things. Glad we have… sun. //Geriol
#Match#pause-2,5
 Yes. Glad for sun. //Dave
#Client#pause-2,5
 Let’s find someplace to sit. //Geriol

~changeMood(clientMood, -5)
~changeMood(matchMood, -5)
->->

///// Start of choice 2

// Knot for neutral choice 2.
// Uses the OverExcited variable. This enables selective memory from previous events.
=== IntroWeatherNeutral2 ===
#Client#pause-2,5
{
- OverExcited:
#Client#pause-2,5
 Yes, sun important for life.  //Geriol
#Match#pause-2,5
 … //Dave
#Client#pause-2,5
 … //Geriol
#Client#pause-2,5
 I’m sorry I didn’t know what to say… //Geriol
#Match#pause-2,5
 I… noticed. I’m nervous too. //Dave
#Client#pause-2,5
 R-Right. *clear throat* With weather nice, let’s find someplace? To sit? //Geriol
#Match#pause-2,5
 Yes. Let’s sit where the sun has dried the grass nicely, yes? //Dave
#Client#pause-2,5
 Where sun dried grass nicely. //Geriol

~changeMood(clientMood, 3)
~changeMood(matchMood, 3)

                       // If overExicted is true
 - !OverExcited:
#Client#pause-2,5
 Kites nice. Not had one for many years. //Geriol
#Match#pause-2,5
 Me neither. No remember how long kite last played. //Dave
#Client#pause-2,5
 Same… Glad kid can play kite. //Geriol
#Match#pause-2,5
 Yes. Not kite weather but good weather picnic. //Dave
#Client#pause-2,5
 It is. //Geriol
 
~OverExcited = false
~changeMood(clientMood, 5)
~changeMood(matchMood, 5)
}
->->

// Knot for yes choice 2.
=== IntroWeatherYes2 === 
#Client#pause-2,5
{
- OverExcited: 
 Sun very important! If rain come, we go someplace else. Still picnic okay if in tunnel, yes? Don’t want to have bad time cause weather! //Geriol
#Match#pause-2,5
 Ah, yes… That would be shame… //Dave
#Client#pause-2,5
 Like sound and smell of rain. Remind me of home. All wet and soft. But you fur have. Like rain? //Geriol
#Match#pause-2,5
 Like rain against my window…? Not on fur. //Dave
#Client#pause-2,5
 I see! I got mucus skin. Mucus skin like rain much much. Don’t like sun. Easy get dry. It why I have many water bottles! Don’t want dry during date! -nervous laughter- //Geriol
#Match#pause-2,5
 I… see… //Dave

        ~changeMood(matchMood, -10)
        ~changeMood(clientMood, -15) 
        
- !OverExcited:

#Client#pause-2,5
 You like flying kite? //Geriol
#Match#pause-2,5
 Haven’t flown kite in long time. Many years since. //Dave
#Client#pause-2,5
 Me neither. Mostly stay inside. //Geriol
#Match#pause-2,5
Same. Outside mean people. Inside is nicer than outside. //Dave
#Client#pause-2,5
Agree, inside better. Also cooler. Sun good, but very warm. //Geriol
#Match#pause-2,5
Yes, very warm. Very bright. //Dave

        ~changeMood(matchMood, -5)
        ~changeMood(clientMood, -5) 

~OverExcited = false
}
->->
 -> pickIntro()