
// Intro page. Here we can find all intro stories and their branches.

// List containing all possible stories. 
// We can set each element to false in order to know when we cannot choose new intros.
LIST MIDDLE = (middleDay), (middleDate), (middleHobby)

=== pickMiddle ===
{LIST_COUNT(MIDDLE) == 0: 
    #Client#pause-5
    Maybe... This was a mistake. Sorry. //Geriol    
    #Match#pause-5
     Yeah, maybe. Thank you for your time.  //Dave
    #Client#pause-5
     Thank you to you too. //Geriol
    -> END
}

~temp value = LIST_RANDOM(MIDDLE)
{value:
    - middleDay:
        ~ MIDDLE -= middleDay
        -> MiddleDay
    - middleDate:
        ~ MIDDLE -= middleDate
        -> MiddleDate
    - middleHobby:
        ~MIDDLE -= middleHobby
        -> MiddleHobby
}
-> END

// Entry knot for intro, only happens once.
// Call from main.
=== MiddleStart ===

// #Narrator#pause-5
// Eating food/picnic tiiiime.
#Client#pause-5
 I got picknick bag! Hope you like food. Many different. //Geriol
#Match#pause-5
 Sure it good, thanks. //Dave

-> pickMiddle

// Ending knot for intro, call at the end to check mood and start middle story.
=== MiddleEnd ===
~ temp cm = checkMood(clientMood, 50)
~ temp mm = checkMood(matchMood, 50)
{
 - cm && mm: -> EndStart                                         // If client and match mood is good.
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
     Sorry, I... Just got a text from my boss, saying I'm needed at work. //Dave
     #Client#pause-5
     Oh... Okay. Then I'll see you later? //Geriol
     #Match#pause-5
     Maybe. //Dave
}
-> END

=== MiddleDay ===
#EnableFeedBack-5                                                     // Use this tag to tell unity to record player input. Can be a timer also.    
#Client#pause-5
 So what you do? //Geriol

#DisableFeedBack
~getFeedBack()
{FeedBack:
   - NO:
     #Client#pause-5
      Never mind, that might not be important. //Geriol
     ~changeMood(clientMood, -5)                               // Decrease client mood after we tell it that it should not talk about the weather.
     ~changeMood(matchMood, 5)                                 // Increase match mood, it doesn't like to talk about weather..
     -> pickMiddle                                             // Here, we told the client no right away. Story could now lead to another intro
   - NEUTRAL:
      -> MiddleDayNeutral1 ->    
   - YES:
      -> MiddleDayYes1 ->
}
-> MiddleEnd


///// Start of choice 1

// Knot for neutral choice 1. The story here could be kept the same as the Yes choice. 
// If it is different, then further knots should be called from here instead of going back up with '->->'
=== MiddleDayNeutral1  ===
#Match#pause-5
With what? //Dave
#Client#pause-5
In… general? //Geriol
#Match#pause-5
Oh okay. Well I Just work in a repair shop and do some small stuff at the side. //Dave
#Client#pause-5
 What kind of repairs? //Geriol
#Match#pause-5
You know, computers and technology. Nothing fancy, just faulty stuff that people bring in. 
#Match#pause-5
Usually, it's just folks who don't realize that most of their problems can be solved by simply restarting it. So, it's not really all that exciting. //Dave
#Client#pause-5
But you get paid to work with computers? //Geriol
#Match#pause-5
What little pay I get, sure. //Dave
#Client#pause-5
Then it sounds like a dream job for me. //Geriol
#Match#pause-5
Is that something you would like to do? //Dave
#Client#pause-5
 Well… I always liked to tinker with things and solve math and logic problems. So your work sounds like something for me. //Geriol

#EnableFeedBack-5
#Match#pause-5
 Well it's not something I would want to do my whole life though. I have bigger dreams. //Dave
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
      ->MiddleDayNeutral2->  
   - YES:
      ->MiddleDayYes2->
}
->->
= No1
#Client#pause-5
I bet. I just dream of not being late for classes. //Geriol
#Match#pause-5
Hehe. Small dreams seem easier to achieve. //Dave
#Client#pause-5
Trust me. This is a long-term one. //Geriol
#Match#pause-5
 I guess I should start with that dream for my work also. I also need that fulfilled. //Dave

~changeMood(clientMood, -5)
~changeMood(matchMood, -5)

->->

// Knot for yes choice 1.
=== MiddleDayYes1 ===
#Match#pause-5
Well There's nothing really special that I do. I work in a repair shop for computers and such. 
#Match#pause-5
It's not a booming industry at the moment, but who knows, maybe it will be one day! //Dave
#Match#pause-5
Otherwise I do some coding work on the side when I have the time. //Dave
#Client#pause-5
 That's pretty cool. //Geriol 
#Match#pause-5
 Saying sarcastically? //Dave
#Client#pause-5
 No, not at all!
#Match#pause-5
Just the tone then, maybe. Most people say what I do is very nerdy and won't really get me anywhere in life... //Dave
#Client#pause-5
 Then they don't understand the potential this technology has! It will, pardon my language, FROGGING revolutionize the world! //Geriol
#Match#pause-5
 Right?! I guess you also have an interest? //Dave
#Client#pause-5
 Basically the only thing I'm good at. Sitting and tinkering and playing with the computer. I'm still studying so I can't live off it like you do. //Geriol
#Match#pause-5
 Well it's a little like everyone says, it's not a very glamorous nor paying job. //Dave
#Client#pause-5
 So far. //Geriol

#EnableFeedBack-5
#Match#pause-5
 But you like tinkering stuff? What kind? //Dave
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
      ->MiddleDayNeutral2->  
   - YES:
      ->MiddleDayYes2->
}
->->
= No1
#Client#pause-5
Ah, uhm, it's not really anything special. It would probably be boring… //Geriol
#Match#pause-5
As I said, it's fine. We can come back to it later instead of making a big deal of it. //Dave
#Client#pause-5
Yeah sure. //Geriol

~changeMood(clientMood, -10)
~changeMood(matchMood, -10)

->->

///// Start of choice 2

// Knot for neutral choice 2.
// Uses the OverExcited variable. This enables selective memory from previous events.
=== MiddleDayNeutral2 ===
#Client#pause-5
{
- OverExcited:
Just combining things into new stuff. Not very interesting. //Geriol
#Match#pause-5
I'm sure it's more interesting than you think! //Dave
#Client#pause-5
I don't do much else, to be honest. Sometimes things go well, sometimes they don't. Sometimes it even blows up, so… 
#Client#pause-5
I'm not super successful with it. I'm better with computers and codes. //Geriol
#Match#pause-5
Haha. Well, what have you done with coding, then? //Dave
#Client#pause-5
Websites! And also a program that compares variables in a large list with minimal user input. It was pretty hard to make, but I managed. 
#Client#pause-5
I've also looked into making text-based games, but I'm not creative enough to write and my grammar is pretty bad. //Geriol
#Match#pause-5
I've heard of those kinds of games. Seems interesting, but I'm more for building things with my hands than through a screen. //Dave
#Client#pause-5
That's fair. //Geriol


                   	// If overExicted is true
~changeMood(clientMood, 10)
~changeMood(matchMood, 10)

 - !OverExcited:
#Client#pause-5
What kind? //Geriol
#Match#pause-5
You know, doing bigger things in life. That stuff. //Dave
#Client#pause-5
Something in particular? //Geriol
#Match#pause-5
…I guess something more practical, you can say. Do you have any? //Dave
#Client#pause-5
Hmm… I guess waking up in time for classes and such? //Geriol
#Match#pause-5
Seems easy enough. //Dave
#Client#pause-5
Tell that to my professor. I think she's given up on me with that. //Geriol
#Match#pause-5
Hehe. Well it doesn't get easier when you work, mostly harder instead. //Dave
#Client#pause-5
I need to get a rooster then. //Geriol

~OverExcited = false
~changeMood(clientMood, 2)
~changeMood(matchMood, 2)

}
->->

// Knot for yes choice 2.
=== MiddleDayYes2 === 
#Client#pause-5
{
- OverExcited: 
#Client#pause-5
Usually some existing gadget and combining it with other things. Haven't figured out how to make something cool with it yet. //Geriol
#Match#pause-5
Then maybe I can share something with you? //Dave
#Client#pause-5
What?  //Geriol
#Match#pause-5
…I'm building robots. //Dave
#Client#pause-5
…Get the pound out of here!!! Woah… 
#Client#pause-5
What kind? What do they do? Can they solve equations? Can they think? Will they burn us in a robotic holy flame??? //Geriol
#Match#pause-5
Well so far they can mostly just walk into walls. But one can at least butter a toast very slowly! My greatest achievement so far. //Dave
#Client#pause-5
I'm sorry to say this but you are too cool for me! //Geriol
#Match#pause-5
Sensing unintended sarcasm here again. //Dave
#Client#pause-5
 No, seriously! I've never really met someone that shares these interests, especially back at home. So this is kind of mindblowing to me. //Geriol
#Match#pause-5
Would say the feelings are pretty mutual then. //Dave
#Client#pause-5
Hihi. Cool.  //Geriol

    	~changeMood(matchMood, 20)
    	~changeMood(clientMood, 20) 
        
- !OverExcited:

#Client#pause-5
What kind? //Geriol
#Match#pause-5
Oh man, maybe it's too personal to bring it up like this. //Dave
#Client#pause-5
 I-If you don't want to, it's okay… //Geriol
#Match#pause-5
Nah it's okay. Most people don't seem to think “it's worth it”. But I… I want to build robots! //Dave
#Client#pause-5
R-ROBOTS?! //Geriol
#Match#pause-5
Shh! It's a little embarrassing. I try to do it in my spare time. So far I just got one that can butter my toast. //Dave
#Client#pause-5
That's super cool! //Geriol
#Match#pause-5
Can't tell if you mean it or just being unintended sarcastic again. //Dave
#Client#pause-5
I-I think it's actually cool… //Geriol
#Match#pause-5
Sorry. Not used to people being sincere with me about it. But, well, if I can't make a living on cool robots, then at least I don't need to think about my toasts in the future. Haha. //Dave
#Client#pause-5
Haha… Yeah it is pretty annoying to butter things. //Geriol
#Match#pause-5
Especially if you get buttery fingers. Then everything you touch gets buttered. //Dave
#Client#pause-5
Buttastic. //Geriol
#Match#pause-5
Hehe, yeah. //Dave

    	~changeMood(matchMood, 15)
    	~changeMood(clientMood, 15) 
~OverExcited = false
}
->->
=== MiddleDate ===
#EnableFeedBack-5                                                     // Use this tag to tell unity to record player input. Can be a timer also.    
#Client#pause-5
So what made you want to have this date? Have you done something like this before? //Geriol

#DisableFeedBack
~getFeedBack()
{FeedBack:
   - NO:
     #Client#pause-5
      Never mind, that might not be important. //Geriol
     ~changeMood(clientMood, -5)                               // Decrease client mood after we tell it that it should not talk about the weather.
     ~changeMood(matchMood, 5)                                 // Increase match mood, it doesn't like to talk about weather..
     -> pickMiddle                                             // Here, we told the client no right away. Story could now lead to another intro
   - NEUTRAL:
      -> MiddleDateNeutral1 ->    
   - YES:
      -> MiddleDateYes1 ->
}
-> MiddleEnd


///// Start of choice 1

// Knot for neutral choice 1. The story here could be kept the same as the Yes choice. 
// If it is different, then further knots should be called from here instead of going back up with '->->'
=== MiddleDateNeutral1  ===
#Match#pause-5
Like what? //Dave
#Client#pause-5
You know, like just meeting up with someone you haven't really met before for… certain intentions? //Geriol
#Match#pause-5
Not really. I met your friend before. //Dave
#Client#pause-5
A friend? What friend? //Geriol
#Match#pause-5
You know your best friend. Juliet. //Dave
#Client#pause-5
Best?...  //Geriol
#Match#pause-5
Yeah I got to know her and she started to talk about you, that I might find you interesting. And here we are! //Dave
#Client#pause-5
Just like that you believed in her? //Geriol
#Match#pause-5
Well I'm here to test her claim I guess. //Dave

#EnableFeedBack-5
#Client#pause-5
Yeah, right… //Geriol
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
      ->MiddleDateNeutral2->  
   - YES:
      ->MiddleDateYes2->
}
->->
= No1
#Client#pause-5
Maybe we should talk about something else?  //Geriol
#Match#pause-5
Sorry, is it weird? //Dave
#Client#pause-5
I don't know. Maybe it just makes things a little… eeeh?? //Geriol
#Match#pause-5
Hmm… I can see that it makes it a little… eeeh. //Dave
#Client#pause-5
Super. //Geriol

~changeMood(clientMood, -5)
~changeMood(matchMood, -5)

->->

// Knot for yes choice 1.
=== MiddleDateYes1 ===
#Match#pause-5
Like what? //Dave
#Client#pause-5
You know, just meeting up with someone you haven't really met before for… certain intentions? //Geriol
#Match#pause-5
Not really. //Dave
#Client#pause-5
What persuaded you to do it then? //Geriol
#Match#pause-5
 Oh, I met your best friend a week ago and she told me about you.  //Dave
#Client#pause-5
 My BEST friend? //Geriol
#Match#pause-5
 You know, Juliet. //Dave
#Client#pause-5
 Juliet? Aah, I see. Yes. My best friend… //Geriol
#Match#pause-5
 Yeah, I was just going out for once and she just came up to me and started to talk. 
#Match#pause-5
We talked a few more times after that and we got into friends and dating and such and she seemed keen to bring up you in it. //Dave
#Client#pause-5
 Oh. So what did she tell you about me??? //Geriol
#Match#pause-5
 Heh, that's between her and me.  //Dave

#EnableFeedBack-5
#Client#pause-5
 Okay… //Geriol
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
      ->MiddleDateNeutral2->  
   - YES:
      ->MiddleDateYes2->
}
->->
= No1
#Client#pause-5
Maybe we shouldn't get too much into the nitty gritty of this situation. //Geriol
#Match#pause-5
Yeah, sometimes that just ruins the moment. //Dave
#Client#pause-5
 … //Geriol
#Match#pause-5
 … //Dave
#Client#pause-5
 R-Right. //Geriol

~changeMood(clientMood, -5)
~changeMood(matchMood, -5)

->->

///// Start of choice 2

// Knot for neutral choice 2.
// Uses the OverExcited variable. This enables selective memory from previous events.
=== MiddleDateNeutral2 ===
#Client#pause-5
{
- OverExcited:
#Client#pause-5
Well she didn't tell me anything about you. //Geriol
#Match#pause-5
So I'm a mystery box for you then? //Dave
#Client#pause-5
Pretty much. And I'm terrible at reading people. //Geriol
#Match#pause-5
Same here. I just got good intel.  //Dave
#Client#pause-5
Did she mention any of my weird habits? //Geriol
#Match#pause-5
I don't know. Which one? //Dave
#Client#pause-5
The one with- NO I SEE. I will just keep my mouth shut about this whole thing. //Geriol
#Match#pause-5
Hehe. But trust me, she just said good things about you. //Dave
#Client#pause-5
Which only gives out half the truth barely… //Geriol
#Match#pause-5
Isn't that how marketing usually works? We still buy into things despite that? //Dave
#Client#pause-5
 I guess so if you phrase it like that. //Geriol


                   	// If overExicted is true
~changeMood(clientMood, 3)
~changeMood(matchMood, 3)

 - !OverExcited:
#Client#pause-5
Well so far I find you interesting if that isn't weird. Just interesting in a general way! Not… creepy… //Geriol
#Match#pause-5
I didn't think it was creepy! We've just met but I sense good vibes from you. Someone who's very kind, just like Juliet said. //Dave
#Client#pause-5
She said that? //Geriol
#Match#pause-5
And some more. //Dave
#Client#pause-5
And you reeeally can't tell me what she told you?? //Geriol
#Match#pause-5
That would spoil it a little. //Dave
#Client#pause-5
Spoil away! I like spoilers. I usually listen to what people talk about a movie after they've seen it just so I know what's gonna happen. //Geriol
#Match#pause-5
And that doesn't… spoil the movie for you? //Dave
#Client#pause-5
It makes me comfortable. //Geriol
#Match#pause-5
Sometimes you need a little unknown in life. //Dave
#Client#pause-5
Not in science. //Geriol
#Match#pause-5
Everything in science is unknown! Even known things can become new unknowns! //Dave
#Client#pause-5
I see your point. But she didn't mention anything weird about me? //Geriol
#Match#pause-5
Keep trying, you won't get anything more out. //Dave
#Client#pause-5
Fine… I… I try to live in the unknown a little. //Geriol
#Match#pause-5
Haha! There you go! //Dave
 
~OverExcited = false
~changeMood(clientMood, 3)
~changeMood(matchMood, 3)

}
->->

// Knot for yes choice 2.
=== MiddleDateYes2 === 
#Client#pause-5
{
- OverExcited: 
So what kind of expectations do you have with this? I think that maybe… my friend exaggerated my qualities. //Geriol
#Match#pause-5
I don't know. I didn't really have big expectations. NOT that I don't have expectations at all from you! Just… Let's see whatever this is. //Dave
#Client#pause-5
Yeah, I-I guess I have some similar expectations with that. Honestly I don't have that much of a social life in general. 
#Client#pause-5
So, not trying to sound desperate or anything, but SOME kind of connection at all would be nice. //Geriol
#Match#pause-5
So anything at all… Even someone like me would be good enough? //Dave
#Client#pause-5
N-not like that! Just you know… eeh… //Geriol
#Match#pause-5
I'm just messing with you! I think we both kind of have the same thinking here. Which makes me think Juliet didn't exaggerate that much about you. //Dave
#Client#pause-5
Hmm… //Geriol
#Match#pause-5
Don't think about what she said! Just enjoy this moment. //Dave
#Client#pause-5
…Okay //Geriol

    	~changeMood(matchMood, 15)
    	~changeMood(clientMood, 15) 
        
- !OverExcited:

#Client#pause-5
So how is the testing going so far? //Geriol
#Match#pause-5
Hard to say. We've just been standing here talking. But so far it's been nice. //Dave
#Client#pause-5
That's good to hear. I wanted to have a picnic but I have never done it before. It's a foreign concept to me. 
#Client#pause-5
Do you really have to have a red-white patterned blanket? //Geriol
#Match#pause-5
Not really, it's just a commonly used one in paintings and stories, I guess. //Dave
#Client#pause-5
But everything else is right? //Geriol
#Match#pause-5
As far as I know about picnics. It's not really my alley either. //Dave
#Client#pause-5
Even toothbrushes? //Geriol
#Match#pause-5
…I think that is a taste thing. //Dave
#Client#pause-5
 Okay I see… //Geriol

    	~changeMood(matchMood, 10)
    	~changeMood(clientMood, 10) 
~OverExcited = false
}
->->
=== MiddleHobby ===
#EnableFeedBack-5                                                     // Use this tag to tell unity to record player input. Can be a timer also.    
#Client#pause-5
So what do you like to do? Got any hobbies? //Geriol

#DisableFeedBack
~getFeedBack()
{FeedBack:
   - NO:
     #Client#pause-5
      Never mind, that might not be important. //Geriol
     ~changeMood(clientMood, -5)                               // Decrease client mood after we tell it that it should not talk about the weather.
     ~changeMood(matchMood, 5)                                 // Increase match mood, it doesn't like to talk about weather..
     -> pickMiddle                                             // Here, we told the client no right away. Story could now lead to another intro
   - NEUTRAL:
      -> MiddleHobbyNeutral1 ->    
   - YES:
      -> MiddleHobbyYes1 ->
}
-> MiddleEnd


///// Start of choice 1

// Knot for neutral choice 1. The story here could be kept the same as the Yes choice. 
// If it is different, then further knots should be called from here instead of going back up with '->->'
=== MiddleHobbyNeutral1  ===
#Match#pause-5
Hmm… When I really think about it there isn't that much that I actually do that could be considered a hobby. //Dave
#Client#pause-5
I think everyone has something, no? //Geriol

#EnableFeedBack-5,5
#Match#pause-5,5
Well that would make sense. But it's pretty mundane stuff in my life. Wake up and work and then home and sleep if nothing else. //Dave
#DisableFeedBack
~changeMood(clientMood, -5)
~changeMood(matchMood, -5)


~getFeedBack()
{FeedBack:
   - NO:                                        
      ~OverExcited = false
      -> No1->                                             // Here, we told the client no in the second round. Here it also could go to a "no" option
                                                                // instead of going back to a new intro.
   - NEUTRAL:
      ->MiddleHobbyNeutral2->  
   - YES:
      ->MiddleHobbyYes2->
}
->->
= No1
#Client#pause-5
I do the same then. Just wake up and study and not so much else. //Geriol
#Match#pause-5
I guess we both have a pretty boring life. //Dave
#Client#pause-5
So far maybe. //Geriol

~changeMood(clientMood, -5)
~changeMood(matchMood, -5)

->->

// Knot for yes choice 1.
=== MiddleHobbyYes1 ===
#Match#pause-5
Hmm… When I really think about it there isn't that much that I actually do that could be considered a hobby. //Dave
#Client#pause-5
Why? //Geriol
#Match#pause-5
Well, I usually just wake up, go to work, work more from home if anything comes up and then go to bed. Pretty mundane stuff. //Dave
#Client#pause-5
I'm pretty sure everyone's days are like that. //Geriol

#EnableFeedBack-5
#Match#pause-5
In general, sure. //Dave
~OverExcited = true
~changeMood(clientMood, 3)
~changeMood(matchMood, 3)

#DisableFeedBack
~getFeedBack()
{FeedBack:
   - NO:                                        
      ~OverExcited = false
      -> No1->                                             // Here, we told the client no in the second round. Here it also could go to a "no" option
                                                                // instead of going back to a new intro.
   - NEUTRAL:
      ->MiddleHobbyNeutral2->  
   - YES:
      ->MiddleHobbyYes2->
}
->->
= No1
#Client#pause-5
I guess I'm the same with that then. I wake up, study and then go to bed. Not doing so much else. //Geriol
#Match#pause-5
I guess we're pretty same then. //Dave
#Client#pause-5
I guess so. //Geriol


~changeMood(clientMood, -5)
~changeMood(matchMood, -5)

->->

///// Start of choice 2

// Knot for neutral choice 2.
// Uses the OverExcited variable. This enables selective memory from previous events.
=== MiddleHobbyNeutral2 ===
#Client#pause-5
{
- OverExcited:
 Well I kind of do the same things as you. But I do like to tinker with stuff. //Geriol
#Match#pause-5
 What kind of stuff? //Dave
#Client#pause-5
Just regular household things, you know. Picking them apart and smashing them together and seeing if something new comes from that. //Geriol
#Match#pause-5
Isn't that dangerous? //Dave
#Client#pause-5
 Sometimes… Spark flies sometimes, but I got the fire extinguisher close by now after I've learned my lesson to have one near. //Geriol
#Match#pause-5
Burned anything down? //Dave
#Client#pause-5
Half of my table. I got books stacked on eachother to make new legs for it. //Geriol
#Match#pause-5
You didn't buy a new one?? //Dave
#Client#pause-5
They're expensive! //Geriol
#Match#pause-5
There is secondhand stuff, you know.  //Dave
#Client#pause-5
… Family heirloom?? //Geriol
#Match#pause-5
 … //Dave
#Client#pause-5
I guess I can't be bothered to get a new one.  //Geriol
#Match#pause-5
Haha, I guessed as much. I broke my bed's bottom legs and now it's a slightly elevated bed. //Dave
#Client#pause-5
Did you get a new bed? //Geriol
#Match#pause-5
Same as you, I can't be bothered.  //Dave
#Client#pause-5
Good that you're honest about it. //Geriol
#Match#pause-5
Haha, one has to be! //Dave


                   	// If overExicted is true
~changeMood(clientMood, 5)
~changeMood(matchMood, 5)

 - !OverExcited:
#Client#pause-5
You don't do any sports or anything? //Geriol
#Match#pause-5
Not really. Unless you count stretching in the morning and evening a sport. A sport of yoga! //Dave
#Client#pause-5
Could be called a sport considering how painful it is to stretch. //Geriol
#Match#pause-5
Eeh, it gets easier with time! But what about you? //Dave
#Client#pause-5
Uhm… Not much really. When I can, I swim. //Geriol
#Match#pause-5
Well that's much better than stretching. Outclassing me here. //Dave
#Client#pause-5
Haven't been able to do it for a while though. There's no good places closeby for me to use. //Geriol
#Match#pause-5
 Not even in a swimming hall? //Dave
#Client#pause-5
 They are too short for my taste, and those places are expensive! I live on a budget. //Geriol

~OverExcited = false
~changeMood(clientMood, 3)
~changeMood(matchMood, 3)

}
->->

// Knot for yes choice 2.
=== MiddleHobbyYes2 === 
#Client#pause-5
{
- OverExcited: 
#Client#pause-5
But you don't have anything you like to do? Sorry if I'm pushing on this or if it sounds judgy… //Geriol
#Match#pause-5
It's fine. It's not something I've been thinking about before. Hmm… Well I like to sit at home most of the time. I got the television on. I call home to my family often. 
#Match#pause-5
I help out my friends if they need help with something. And I like to build stuff. //Dave
#Client#pause-5
What kind of stuff? //Geriol
#Match#pause-5
Robots. Only tiny ones so far. //Dave
#Client#pause-5
Well that's something worth sharing! //Geriol
#Match#pause-5
I guess I see it more as a work thing. I have a dream of building robots in the future. //Dave
#Client#pause-5
That is… admirable. What kind of robots do you have? What can they do? //Geriol
#Match#pause-5
Nothing you think of probably. So far they stop running into walls. But I've managed to make one that butter my toast. Only simple stuff. //Dave
#Client#pause-5
Can I see them??? //Geriol
#Match#pause-5
 Sure. You're the first one to be interested in it. But what about you? //Dave
#Client#pause-5
 My hobbies? Hmm… I guess tinkering with stuff and swimming. //Geriol
#Match#pause-5
 What kind of stuff? //Dave
#Client#pause-5
 Nothing cool as robots. Just smashing things together and seeing if there is some use for it so far. And without explosions.  //Geriol
#Match#pause-5
 As I said. Just solving simple stuff is an art. But you swim also? //Dave
#Client#pause-5
 Yeah. Though I have to travel a bit to find a place that fits me. //Geriol
#Match#pause-5
Isn't a swimming hall good enough? //Dave
#Client#pause-5
Too small for me, sadly, and the sea isn't good for my skin. //Geriol
#Match#pause-5
I see. //Dave

    	~changeMood(matchMood, 12)
    	~changeMood(clientMood, 15) 
        
- !OverExcited:

#Client#pause-5
And if there is something else? //Geriol
#Match#pause-5
What? //Dave
#Client#pause-5
You said if there is nothing else. What if there is something else? //Geriol
#Match#pause-5
Oh. Uhm… I guess I like to, you know, read and stuff. //Dave
#Client#pause-5
What kind? //Geriol
#Match#pause-5
Mostly Sci-Fi. Have you read any of it? //Dave
#Client#pause-5
No, I guess thriller noir would be more of my thing. //Geriol
#Match#pause-5
You don't strike me as a noir reader. //Dave
#Client#pause-5
Well I don't really know what's going on in those books. But the characters are usually pretty cool and say cool stuff. //Geriol
#Match#pause-5
Aren't they all pretty gruff? //Dave
#Client#pause-5
Pretty much. But sometimes those kinds of typical things are pulling me in. //Geriol
#Match#pause-5
Feel the same with Sci-Fi sometimes. Usually it's just a story about saving the universe again, but I find it very engaging for some reason. //Dave
#Client#pause-5
Cliches work for a reason, I guess. //Geriol
#Match#pause-5
Yeah. I always think I can be interested in other plots, but then I get more excited for the same type of plot as the last book I read. //Dave
#Client#pause-5
Almost like we can read the same books over and over again and save some money? //Geriol
#Match#pause-5
But I'm really waiting for a sequel that I need to read! //Dave
#Client#pause-5
Hehe. We really are stuck in this. //Geriol
#Match#pause-5
Such a sad fate! //Dave

    	~changeMood(matchMood, 10)
    	~changeMood(clientMood, 10) 
~OverExcited = false
}
->->