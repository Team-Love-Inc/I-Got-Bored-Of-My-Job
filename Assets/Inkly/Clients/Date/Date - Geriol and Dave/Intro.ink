// List containing all possible stories. 
LIST INTRO = (introArrive), (introSorry), (introWeather)

VAR OverExcited = false
VAR Match = "Dave"
VAR Client = "Geriol"

// Functional knot to pick intro. Call when a new intro is needed.
// If all intros are used, the story ends.
=== pickIntro ===
{LIST_COUNT(INTRO) == 0: 
    #Client#pause-5
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
#Match#pause-5
 Hello! Sorry for being late. Are you Geriol? //Dave
#Client#pause-5
 Ah! Y-Yes that is I, me, that person… Sorry, what was your name again? //Geriol
#Match#pause-5
 Nothing to apologise for, I'm Dave. It's nice to meet you. //Dave
#Client#pause-5
 Nice to meet you too. I'm Geriol. Again… //Geriol
~DateSuccess = true
-> END
// -> pickIntro

// Ending knot for intro, call at the end to check mood and start middle story.
=== IntroEnd ===
~ temp cm = checkMood(clientMood, 50)
~ temp mm = checkMood(matchMood, 50)
{clientMood} {matchMood}
{
 - cm && mm: -> MiddleStart                                         // If client and match mood is good.
 - !cm && !mm:                                                      // If client and match mood is bad
    #Match#pause-5
     This... Could have gone better.  //Dave
    #Client#pause-5
     I'm sorry... Maybe it's best if we cut it off here, then. //Geriol
    #Match#pause-5
     Yeah, that would be best. Thank you for your time.  //Dave
    #Client#pause-5
     Thank you to you too. //Geriol
 - !cm:                                                             // If client mood is bad.
    #Client#pause-5
     Uhm... I think I just got a call from Juliet, she says she n-needs me. //Geriol
    #Match#pause-5
     Oh, alright. Then don't let me keep you.  //Dave
     #Client#pause-5
     Yeah, sure, bye. //Geriol
 - !mm:                                                             // If match mood is bad.
    #Match#pause-5
     Sorry, I... Just got a text from my boss, saying I'm needed at work. //Dave
     #Client#pause-5
     Oh... Okay. Then I'll see you later? //Geriol
     #Match#pause-5
     Maybe. //Dave
}
-> END

=== IntroArrive ===
#EnableFeedBack-5     
#Client#pause-5
 Did you get here okay? Do you live close-by? //Geriol


#DisableFeedBack
~getFeedBack()
{FeedBack:
   - NO:
     #Client#pause-5
      Never mind, that might not be important. //Geriol
     ~changeMood(clientMood, -5)                               // Decrease client mood after we tell it that it should not talk about the weather.
     ~changeMood(matchMood, 5)                                 // Increase match mood, it doesn't like to talk about weather..
     -> pickIntro                                             // Here, we told the client no right away. Story could now lead to another intro
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
#Match#pause-5
Hey, I made it here fine. I live just two bus rides away, but there was an accident on the road, so I got delayed. //Dave
#Client#pause-5
Oh, I see. It's good that you still made it here. //Geriol
#Match#pause-5
 What about you? //Dave
#Client#pause-5
 I just walked. Or more like ran, I thought I would be late. My alarm broke so I woke up late. //Geriol

#EnableFeedBack-5
#Match#pause-5
 Sounds very stressful if you had to run here. //Dave
#DisableFeedBack
~changeMood(clientMood, 5)
~changeMood(matchMood, 5)

~getFeedBack()
{FeedBack:
   - NO:                                        
      ~OverExcited = false
      -> No1->
   - NEUTRAL:
      ->IntroArriveNeutral2->  
   - YES:
      ->IntroArriveYes1->
}
->->
= No1
#Client#pause-5
 Not so far away. You? //Geriol
#Match#pause-5
 Already told you I took the bus here. //Dave
#Client#pause-5
 Right right… //Geriol
#Match#pause-5
 … //Dave
#Client#pause-5
 Wanna go sit somewhere in the park? //Geriol
#Match#pause-5
 Sure, sure. //Dave
~changeMood(clientMood, -2)
~changeMood(matchMood, -5)
->->

// Knot for yes choice 1.
=== IntroArriveYes1 ===
#Match#pause-5
Uh yeah! I made it here easily. I live just two buses away. I was only late because there was an accident on the road, which caused some traffic jams. //Dave
#Client#pause-5
 Oh my! What kind of accident? //Geriol
#Match#pause-5
 I'm not sure… I didn't pay attention. I was engrossed in a book. //Dave
#Client#pause-5
Oh, what book is it? //Geriol
#Match#pause-5
It's mostly about the stars, the possibilities beyond it and how we might be able to see it eventually. It also included some interesting calculations… //Dave
#Client#pause-5
 That sound just up my alley! I'd probably like it as well, with the stars and such. //Geriol
#Match#pause-5
It focused more on calculations rather than the stars themselves, though. //Dave
#Client#pause-5
 Even better then. I like math a lot, haha. //Geriol
#Match#pause-5
Oh, really? Well, let me jot down the book's name for you so you can borrow it from somewhere. The title is quite lengthy. Feel free to share your thoughts with me later.
//Dave
#Client#pause-5
 Thank you! I'll be sure to check it out. //Geriol

#EnableFeedBack-5
#Match#pause-5
 Haha, great.
~OverExcited = true
~changeMood(clientMood, 10)
~changeMood(matchMood, 10)


#DisableFeedBack
~getFeedBack()
{FeedBack:
   - NO:                                        
      ~OverExcited = false
      -> No1->
   - NEUTRAL:
      ->IntroArriveNeutral2->  
   - YES:
      ->IntroArriveYes1->
}
->->
= No1
#Client#pause-5
 Maybe you can show me more of the book later? //Geriol
#Match#pause-5
 Yeah if you are interested. //Dave
~changeMood(clientMood, -5)
~changeMood(matchMood, -5)

->->

///// Start of choice 2

// Knot for neutral choice 2.
// Uses the OverExcited variable. This enables selective memory from previous events.
=== IntroArriveNeutral2 ===
#Client#pause-5
{
- OverExcited:
Maybe you can show me more of the book later? //Geriol
#Match#pause-5
Sure, if you are interested. //Dave
#Client#pause-5
Yeah, I'm pretty interested. I got a large collection of books myself! //Geriol
#Match#pause-5
Do you read a lot? //Dave
#Client#pause-5
…I will eventually, of course. Just haven't had the time yet. //Geriol
#Match#pause-5
Have you made the time for it? //Dave
#Client#pause-5
…I gotta MAKE my own time for it??? //Geriol
#Match#pause-5
 Yeah, it's difficult to read otherwise. Personally, I have managed to avoid thinking I'm putting off something else to make time for books so I don't feel as guilty when I read. //Dave
#Client#pause-5
I already feel the guilt eating at me. Or it's just hunger. Are you hungry? //Geriol
#Match#pause-5
I could eat something. //Dave

                   	// If overExicted is true
~changeMood(clientMood, 5)
~changeMood(matchMood, 5)

 - !OverExcited:
#Client#pause-5
 No, I just had to get around a few corners to get here. Just had to shove breakfast in my mouth. //Geriol
#Match#pause-5
 I think you still got some on. //Dave
#Client#pause-5
 Oh no! Is it gone now? //Geriol
#Match#pause-5
 …Sure! //Dave
#Client#pause-5
 Hehe… //Geriol

 
~OverExcited = false
~changeMood(clientMood, 3)
~changeMood(matchMood, 3)


}
->->

// Knot for yes choice 2.
=== IntroArriveYes2 === 
#Client#pause-5
{
- OverExcited: 
 Maybe tell me more about  the book later? //Geriol
#Match#pause-5
 Sure, if you are interested. //Dave
#Client#pause-5
 But two buses away? Sounds far away. Glad you wanted to come and meet up though. //Geriol
#Match#pause-5
 Of course. You have to make some effort in life to get anything. //Dave
#Client#pause-5
Oh yes! A looooot of effort for me. Just had to walk a short distance. //Geriol
#Match#pause-5
 Still more than I do on a daily basis. //Dave
#Client#pause-5
 Haha, I find that hard to believe. //Geriol
#Match#pause-5
You should have seen me walking here from the bus. I feel the sweat building up here. //Dave
#Client#pause-5
It's just a hot day. But I think we both have some difficulties doing these kinds of things. Meeting new people. //Geriol
#Match#pause-5
 Pretty much //Dave
#Client#pause-5
 It's just easier to stay at home. //Geriol
#Match#pause-5
 Exactly! Big brains here. //Dave
#Client#pause-5
 Definitely. //Geriol

~changeMood(matchMood, 20)
~changeMood(clientMood, 20)

        
- !OverExcited:

#Client#pause-5
It wasn't too far. I live only 10 minutes away. //Geriol
#Match#pause-5
Sounds very convenient. //Dave
#Client#pause-5
Yeah, but my area is pretty sketchy though. //Geriol
#Match#pause-5
You live very central so that is to be expected? //Dave
#Client#pause-5
True, but I hope my next home won't be as bad. This one was pretty cheap so I just took it. Do you live in a sketchy place? //Geriol
#Match#pause-5
I wouldn't say “not” sketchy, but there are some funny characters around. //Dave
#Client#pause-5
What kind? //Geriol
#Match#pause-5
Well there's a man that likes to dress up like a mermaid and pretend to swim on the streets. //Dave
#Client#pause-5
That just sounds scary. //Geriol
#Match#pause-5
He is a very nice and okay guy though. I just think he likes to do that kind of stuff. For some reason. //Dave

~OverExcited = false
    	~changeMood(matchMood, 10)
    	~changeMood(clientMood, 10)

}
->->

////////// Start of anothter intro conversation ////////// 

// Unimplemented 
=== IntroSorry ===
#EnableFeedBack-5                                                     // Use this tag to tell unity to record player input. Can be a timer also.    
#Client#pause-5
 …Sorry, I haven't been on many so called dates. Not sure how to start. //Geriol

#DisableFeedBack
~getFeedBack()
{FeedBack:
   - NO:
     #Client#pause-5
      Never mind, that might not be important. //Geriol
     ~changeMood(clientMood, -5)                               // Decrease client mood after we tell it that it should not talk about the weather.
     ~changeMood(matchMood, 5)                                 // Increase match mood, it doesn't like to talk about weather..
     -> pickIntro                                             // Here, we told the client no right away. Story could now lead to another intro
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
#Match#pause-5
 No worries, I don't know much either. What do people usually talk about? //Dave
#Client#pause-5
I don't know… Don't wanna bore you either. Maybe… Talk about the weather? //Geriol
#Match#pause-5
 I suppose…? Uh, it's nice weather today. Warm, comfy. //Dave
#Client#pause-5
 Haha. Yes, warm and comfy. A good description. Photosynthesis is cool. //Geriol

#EnableFeedBack-5
#Match#pause-5
 It is. There aren't many clouds hanging around either. //Dave
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
      ->IntroSorryNeutral2->  
   - YES:
      ->IntroSorryYes2->
}
->->
= No1
#Client#pause-5
 Nice with some nice weather. Makes everything easy peasy.  //Geriol
#Match#pause-5
 There's no wind either. Very comfy. //Dave
#Client#pause-5
Yeah. Well, let's find someplace nice here. //Geriol
~changeMood(clientMood, 5)
~changeMood(matchMood, 5)


->->

// Knot for yes choice 1.
=== IntroSorryYes1 ===
#Match#pause-5
 No worries, I don't know that much either. What would people usually talk about? //Dave
#Client#pause-5
 We can introduce ourselves? That's a start! //Geriol
#Match#pause-5
 Haha. Yes, that's a start. I don't really go outside to meet people that much. //Dave
#Client#pause-5
 Me neither! I stay home most of the time. I like being alone, but sometimes too much is too much. You know? //Geriol

#EnableFeedBack-5
#Match#pause-5
I understand what you're saying, I feel the same way. It's cool we both share that! //Dave
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
      ->IntroSorryNeutral2->  
   - YES:
      ->IntroSorryYes2->
}
->->
= No1
#Client#pause-5
 Glad you think so. I'm sure we will be fine. We seem to have a lot to talk about already, even without knowing what to do. //Geriol
#Match#pause-5
 Yes. No pressure. //Dave
#Client#pause-5
 Yeah. //Geriol
~changeMood(clientMood, 8)
~changeMood(matchMood, 8)
->->


///// Start of choice 2

// Knot for neutral choice 2.
// Uses the OverExcited variable. This enables selective memory from previous events.
=== IntroSorryNeutral2 ===
#Client#pause-5
{
- OverExcited:
 I'm glad you feel the same. Thank you for agreeing on this date. Or like just wanting to hangout. //Geriol
#Match#pause-5
No worry or pressure, we'll just go for what feels best here. I don't mind calling this a hangout. It's nice to have friends too. //Dave
#Client#pause-5
 Yes, We'll see. So far you're very nice. //Geriol
#Match#pause-5
 You're very nice too. So no complaining so far.  //Dave

                   	// If overExicted is true
	~changeMood(clientMood, 5)
	~changeMood(matchMood, 10)

 - !OverExcited:
#Client#pause-5
 You know most photosynthesis happens out in the sea underwater? //Geriol
#Match#pause-5
 Yes, it's cool. People usually only think of it connected to trees and flowers. But it's very important below water too. //Dave
#Client#pause-5
Though, it's easier and nicer to see flowers. //Geriol
#Match#pause-5
 Do you like flowers?
#Client#pause-5
Eeh… Don't really know any flower names. But they are nice to see and smell.  //Geriol
#Match#pause-5
 The ecosystem sure is pretty cool and pretty. //Dave

~OverExcited = false
~changeMood(clientMood, 3)
~changeMood(matchMood, 3)


}
->->

// Knot for yes choice 2.
=== IntroSorryYes2 === 
#Client#pause-5
{
- OverExcited: 
 Me too! I usually just stay inside at the computer. Easiest to hangout with. //Geriol
#Match#pause-5
I know what you mean. Computers are way easier to understand than people. Easier algorithms to follow while people are like, you know. //Dave
#Client#pause-5
I don't want other people to dislike me either. It's hard to know what to say and do sometimes. It feels like I haven't been here long enough to know that stuff… //Geriol
#Match#pause-5
 Oh? Where are you from?  //Dave
#Client#pause-5
 A river community. //Geriol
#Match#pause-5
 Oooh, cool. //Dave

    	~changeMood(matchMood, 20)
    	~changeMood(clientMood, 20)

        
- !OverExcited:
#Client#pause-5
 Look, clouds looking like dogs! //Geriol
#Match#pause-5
 Yes, I see. Oh, and some kites flying. I didn't think it was windy enough for that. //Dave
#Client#pause-5
Same. Could be wind magic… //Geriol
#Match#pause-5
At least the kid is having fun. Haven't flown a kite in a long time. //Dave
#Client#pause-5
 Me neither… Wanna play together sometime when it's actually windy? //Geriol
#Match#pause-5
 We could try. Not sure if I'm good at it, though. //Dave
#Client#pause-5
 Well, same here. So we'll see! //Geriol

~OverExcited = false
    	~changeMood(matchMood, 10)
    	~changeMood(clientMood, 8)

}
->->
 -> pickIntro

////////// Start of yet anothter intro conversation ////////// 

=== IntroWeather ===
#EnableFeedBack-5                                                     // Use this tag to tell unity to record player input. Can be a timer also.    
#Client#pause-5
 …THE WEATHER SURE IS NICE SO FAR! Didn't look at today's forecast at how it will stay though. Have you? //Geriol

#DisableFeedBack
~getFeedBack()
{FeedBack:
   - NO:
     #Client#pause-5
      Never mind, that might not be important. //Geriol
     ~changeMood(clientMood, -5)                               // Decrease client mood after we tell it that it should not talk about the weather.
     ~changeMood(matchMood, 5)                                 // Increase match mood, it doesn't like to talk about weather..
     -> pickIntro                                             // Here, we told the client no right away. Story could now lead to another intro
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
#Match#pause-5
 Ah, no, I haven't seen the forecast. I don't know what the weather will be like. //Dave
#Client#pause-5
 Then, we can only hope it stays nice. At least there is no wind to blow things or me away. //Geriol
#Match#pause-5
 Yes,that would've been annoying, and impressive of the wind. //Dave
#Client#pause-5
Good for kite flying though. //Geriol
#Match#pause-5
True. Oh, kites are flying over there. See? How can they fly without wind…? //Dave
#Client#pause-5
Wind magic…? Not important. //Geriol

#EnableFeedBack-5
#Match#pause-5
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
      ->IntroWeatherNeutral2->  
   - YES:
      ->IntroWeatherYes2->
}
->->
= No1
#Client#pause-5
 As long as kids have fun and no kites flies into our eyes, I find it okay. //Geriol
#Match#pause-5
 Yes. They seem to have fun. //Dave
#Client#pause-5
 Seems like it. But let's go somewhere else, maybe just in case. //Geriol
~changeMood(clientMood, -5)
~changeMood(matchMood, -5)
->->

// Knot for yes choice 1.
=== IntroWeatherYes1 ===
#Match#pause-5
 Ah, no, I haven't seen the forecast. I don't know how the weather will be. //Dave
#Client#pause-5
 Oh, okay… Would be nice if it stayed nice for the whole day. //Geriol
#Match#pause-5
 Uh, yes. That would be nice.  //Dave
#Client#pause-5
 Not so much wind either. Could have brought an umbrella for shade though… Would've been good in case it rains later in the day.  //Geriol
#Match#pause-5
 R-Right… //Dave
#Client#pause-5
 Not that I think it will rain but you can never be too prepared! Do you like the sun? //Geriol

#EnableFeedBack-5
#Match#pause-5
 Sun is important to survive, so.. Yes? //Dave
~OverExcited = true
~changeMood(clientMood, -10)
~changeMood(matchMood, -15)
#DisableFeedBack

~getFeedBack()
{FeedBack:
   - NO:                                        
      ~OverExcited = false
      -> No1->                                             // Here, we told the client no in the second round. Here it also could go to a "no" option
                                                                // instead of going back to a new intro.
   - NEUTRAL:
      ->IntroWeatherNeutral2->  
   - YES:
      ->IntroWeatherYes2->
}
->->
= No1
#Client#pause-5
 Right, yes. The sun is important. Grants life onto things. Glad we have… sun. //Geriol
#Match#pause-5
 Yes, same. Very glad for the sun. //Dave
#Client#pause-5
… Let's find someplace to settle down. //Geriol

~changeMood(clientMood, -5)
~changeMood(matchMood, -5)

->->

///// Start of choice 2

// Knot for neutral choice 2.
// Uses the OverExcited variable. This enables selective memory from previous events.
=== IntroWeatherNeutral2 ===
#Client#pause-5
{
- OverExcited:
#Client#pause-5
 Yes, the sun is very important for life.  //Geriol
#Match#pause-5
 … //Dave
#Client#pause-5
 … //Geriol
#Client#pause-5
 I'm sorry. I didn't know what to say or talk about… //Geriol
#Match#pause-5
 I… noticed. I'm nervous too so don't worry. //Dave
#Client#pause-5
 R-Right. Hrrm… With nice weather, let's find someplace? To sit? Or stand? Or whatever. //Geriol
#Match#pause-5
 Sure. It's a big park so somewhere gotta be nice for us, yes?//Dave
#Client#pause-5
A nice place for two! Let's go. //Geriol

~changeMood(clientMood, 3)
~changeMood(matchMood, 3)


                       // If overExicted is true
 - !OverExcited:
#Client#pause-5
 Kites are nice. I haven't used one for a long time.  //Geriol
#Match#pause-5
 Me neither. I don't remember when I did it. //Dave
#Client#pause-5
 Same… Glad kids can fly kites. //Geriol
#Match#pause-5
 Yes. Not really a kite weather but good enough to just be outside. //Dave
#Client#pause-5
 It is. //Geriol
 
~OverExcited = false
~changeMood(clientMood, 5)
~changeMood(matchMood, 5)

}
->->

// Knot for yes choice 2.
=== IntroWeatherYes2 === 
#Client#pause-5
{
- OverExcited: 
 The sun is very important! If it would rain we could go somewhere else. Still okay even if we would be in a tunnel, yes? //Geriol
 #Client#pause-5
 Don't want us to have a bad time because of the weather. //Geriol
#Match#pause-5
 Ah, yes… That would be a shame. But a tunnel… //Dave
#Client#pause-5
But boy I like the sound and smell of rain! Reminds me of home. But hmm… Maybe not for you with your fur?  //Geriol
#Match#pause-5
I like the rain against my window…? But not on my fur. //Dave
#Client#pause-5
 I see! I got mucus on my skin and it loves the rain. Not a big fan of the sun, it dries up easily. So rehydrating is the key to my fair complexion! //Geriol
 #Client#pause-5
 Heh… Haha… //Geriol
#Match#pause-5
 I… see… //Dave

    	~changeMood(matchMood, -10)
    	~changeMood(clientMood, -15)
        
- !OverExcited:

#Client#pause-5
 You like flying kites? //Geriol
#Match#pause-5
 Haven't flown a kite in a long time. //Dave
#Client#pause-5
 Me neither. I mostly just stay inside. //Geriol
#Match#pause-5
Same here. There are a lot of weird people outside of home. The inside only has… very few dangerous things compared to that. //Dave
#Client#pause-5
I agree. Also inside is a lot cooler. The sun is good, but sometimes a little ridiculous with how warm it can get. //Geriol
#Match#pause-5
Yeah, it's heating up here. And what feels like 10% brighter than usual. If that is true then it would be very worrisome.  //Dave

    	~changeMood(matchMood, 5)
    	~changeMood(clientMood, 5)

~OverExcited = false
}
->->