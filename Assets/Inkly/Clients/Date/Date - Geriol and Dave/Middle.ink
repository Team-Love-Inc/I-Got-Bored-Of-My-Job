
// Intro page. Here we can find all intro stories and their branches.

// List containing all possible stories. 
// We can set each element to false in order to know when we cannot choose new intros.
LIST MIDDLE = (middleDay), (middleDate), (middleHobby)

=== pickMiddle ===
{LIST_COUNT(MIDDLE) == 0: 
    #Client#pause-2,5
    Oh I just remember, my stove is on at home. cya. //Geriol
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

#Narrator#pause-2,5
Eating food/picnic tiiiime.
#Client#pause-2,5
 I got picknick bag! Hope you like food. Many different. //Geriol
#Match#pause-2,5
 Sure it good, thanks. //Dave
Speech bubble to show if Match like Geriol food choice or not. Affect Match mood -10 if bad food match. (No player to affect food choice cause this be personality.)

-> pickMiddle

// Ending knot for intro, call at the end to check mood and start middle story.
=== MiddleEnd ===
~ temp cm = checkMood(clientMood, 50)
~ temp mm = checkMood(matchMood, 50)
{
 - cm && mm: -> EndStart                                         // If client and match mood is good.
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

=== MiddleDay ===
#EnableFeedBack                                                     // Use this tag to tell unity to record player input. Can be a timer also.    
#Client#pause-2,5
 So what you do? //Geriol

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
      -> MiddleDayNeutral1 ->    
   - YES:
      -> MiddleDayYes1 ->
}
-> MiddleEnd


///// Start of choice 1

// Knot for neutral choice 1. The story here could be kept the same as the Yes choice. 
// If it is different, then further knots should be called from here instead of going back up with '->->'
=== MiddleDayNeutral1  ===
#Match#pause-2,5
 With what? //Dave
#Client#pause-2,5
 Eh?... I guess in general? //Geriol
#Match#pause-2,5
 Oh right! Of course that's what you meant. //Dave
#Client#pause-2,5
 … //Geriol
#Match#pause-2,5
 Are you thinking? //Dave
#Client#pause-2,5
 Oh? No, I was just waiting for you to say something. //Geriol
#Match#pause-2,5
 Oh okay. Well I Just work in a repair shop and do some small stuff at the side. //Dave
#Client#pause-2,5
 What kind of repairs? //Geriol
#Match#pause-2,5
 You know, computer stuff. Nothing fancy, just if something is faulty. Usually its just people who doesn’t know most of their problems could be solved by just restarting it. So not so stimulating. //Dave
#Client#pause-2,5
 But you get paid to work on computers? //Geriol
#Match#pause-2,5
 What little pay I get, sure. //Dave
#Client#pause-2,5
 Sounds like a dream job for me. //Geriol
#Match#pause-2,5
 Oh, is that something you like to do? //Dave
#Client#pause-2,5
 Well… I always liked to tinker with things and solve math and logic problems. So your work sounds like something for me. //Geriol

#EnableFeedBack
#Match#pause-2,5
 Well it’s not something I would want to do my whole life though. I got bigger dreams. //Dave
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
 I bet. I just dream of not being late for classes. //Geriol
#Match#pause-2,5
 Hehe. small dreams seems easier to achieve. //Dave
#Client#pause-2,5
 Trust me. This is a long-term one. //Geriol
#Match#pause-2,5
 I guess I should start with that dream for my work also. Also need that fulfilled. //Dave

~changeMood(clientMood, -5)
~changeMood(matchMood, -5)
->->

// Knot for yes choice 1.
=== MiddleDayYes1 ===
#Match#pause-2,5
 With what? //Dave
#Client#pause-2,5
 Eh?... I guess in general? //Geriol
#Match#pause-2,5
 Oh right! Of course that's what you meant. //Dave
#Client#pause-2,5
 No no! I was just very vague asking that. Like, I dunno… I would probably think that's something creepy if a stranger would just come up to me and ask that suddenly. //Geriol
#Match#pause-2,5
 So are you a stranger or a creep to me? //Dave
#Client#pause-2,5
 Eeh… I’am a stranger to you no? We just met like a few minutes ago. And creepy?? I hope not. //Geriol
#Match#pause-2,5
 I was just kidding! I don’t see you as creepy so far atleast. //Dave
#Client#pause-2,5
 Hoho… Thats good. Mutual feelings. //Geriol

#EnableFeedBack
#Match#pause-2,5
 So you still want to know? //Dave
~OverExcited = true
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
 It’s okay, if you don’t want to tell me. Maybe it’s to sudden just to ask something like that. //Geriol
#Match#pause-2,5
 As I said it’s fine. We can come back to it later instead of making a big deal about it. //Dave
#Client#pause-2,5
 Yeah sure. //Geriol
#Match#pause-2,5
 So what more did you pack in that basket then? //Dave
#Client#pause-2,5
 Eehmm… let’s see… I brought toothbrush. //Geriol
#Match#pause-2,5 
 Toothbrush? //Dave
#Client#pause-2,5
 I like to brush after I eat something. It’s a double pack if you… would… like to also? //Geriol
#Match#pause-2,5
 … Eh sure why not! Better to keep the dentist away then to get dragged in there in pain. //Dave

~changeMood(clientMood, -10)
~changeMood(matchMood, -10)
->->

///// Start of choice 2

// Knot for neutral choice 2.
// Uses the OverExcited variable. This enables selective memory from previous events.
=== MiddleDayNeutral2 ===
#Client#pause-2,5
{
- OverExcited:
 …Yes please. //Geriol
#Match#pause-2,5
 So formal. Well, Well There’s nothing really special that I do. I work in a repair shop for computers and such. Not a booming industry right now but I bet one day it could be! //Dave
 #Match#pause-2,5
 Whenever I have the time I do some coding gig on the side. //Dave
#Client#pause-2,5
 That’s really interesting. //Geriol
#Match#pause-2,5
 You think so? Most would just call me a nerd and that I’m wasting my time on it. //Dave
#Client#pause-2,5
 Computers are just getting bigger and bigger! Otherwise a repair shop for it wouldn’t exist, no? //Geriol
#Match#pause-2,5
 I guess so. You’re probably right on that. When I grew up it was still hard to just get news quickly. Now you can just search up on it. When someone isn’t using the phone. //Dave
#Client#pause-2,5
 I still like the feeling of paper though. //Geriol
#Match#pause-2,5
 I’m whatever with that. Just a bother to throw it out later when you’re done. //Dave
#Client#pause-2,5
 Yeah I guess so… //Geriol


                       // If overExicted is true
~changeMood(clientMood, 5)
~changeMood(matchMood, 5)
 - !OverExcited:
#Client#pause-2,5
 What kind? //Geriol
#Match#pause-2,5
 You know, doing bigger things in life. That stuff. //Dave
#Client#pause-2,5
 Something in particular? //Geriol
#Match#pause-2,5
 …I guess something more practical, you can say. Do you have any? //Dave
#Client#pause-2,5
 Hmm… I guess waking up in time for classes and such? //Geriol
#Match#pause-2,5
 Seems easy enough. //Dave
#Client#pause-2,5
 Tell that to my professor. I think she's given up on me with that. //Geriol
#Match#pause-2,5 
 Hehe. Well it doesn’t get easier when you work, mostly harder with that. //Dave
#Client#pause-2,5
 I need to buy a rooster at this pace. //Geriol

~OverExcited = false
~changeMood(clientMood, 2)
~changeMood(matchMood, 2)
}
->->

// Knot for yes choice 2.
=== MiddleDayYes2 === 
#Client#pause-2,5
{
- OverExcited: 
 Uhm yeah! Tell me what you want to tell me. //Geriol
#Match#pause-2,5
 Well There’s nothing really special that I do. I work in a repair shop for computers and such. Not a booming industry right now but I bet one day it could be! 
 #Match#pause-2,5
 Whenever I have the time I do some coding gig on the side. //Dave
#Client#pause-2,5
 That is… //Geriol
#Match#pause-2,5
 Pretty nerdy, no? //Dave
#Client#pause-2,5
 I was going to say pretty cool. //Geriol
#Match#pause-2,5
 Sarcastically? //Dave
#Client#pause-2,5
 Not even sure how to be sarcastic. //Geriol
#Match#pause-2,5
 Just now was sarcastic? //Dave
#Client#pause-2,5
 Was it? //Geriol
#Match#pause-2,5
 Maybe its just your tone then. But no most people say what I do is very nerdy and it won’t really get me anywhere. //Dave
#Client#pause-2,5
 Then they don’t understand the potential this technology has! It will, pardon my language, FROGGING revolutionize the world! //Geriol
#Match#pause-2,5
 Right right?? Then I guess you also have a interest in this? //Dave
#Client#pause-2,5
 Basically the only thing I’m good at. Sitting and tinkering and play with the computer. I’m still just a student though so I can't live on it as you can. //Geriol
#Match#pause-2,5
 Well it is a little like everyone says, its not a very glamorous nor paying job. //Dave
#Client#pause-2,5
 So far. //Geriol
#Match#pause-2,5
 But you like tinkering stuff? What kind? //Dave
#Client#pause-2,5
 Usually some existing gadget and combining it with other things. Haven’t figured out something cool to do yet. //Geriol
#Match#pause-2,5
 Then maybe I can share something with you? //Dave
#Client#pause-2,5
 What?  //Geriol
#Match#pause-2,5
 …I’m building robots. //Dave
#Client#pause-2,5
 …Get the pound out of  here!!! Woah… What kind? What do they do? Can they solve equations? Can they think? Will they burn us??? //Geriol
#Match#pause-2,5
 Well so far they can walk. Mostly into walls. But one can butter a toast very slowly. My greatest achievement so far! //Dave
#Client#pause-2,5
 I’m sorry to say this but you are too cool for me. //Geriol
#Match#pause-2,5
 Sense unintended sarcasm again. //Dave
#Client#pause-2,5
 No seriously. Never really met someone that has these interest, especially at home. So this is kind of mindblowing for me. //Geriol
#Match#pause-2,5
 Would say the feelings are pretty mutual then. //Dave
#Client#pause-2,5
 giggling Cool.  //Geriol

        ~changeMood(matchMood, 20)
        ~changeMood(clientMood, 20) 
        
- !OverExcited:

#Client#pause-2,5
 What kind? //Geriol
#Match#pause-2,5
 Oh man, maybe it’s too personal to bring it up like this. //Dave
#Client#pause-2,5
 I-if you don’t want to, it's okay… //Geriol
#Match#pause-2,5
 Nah it’s okay. Just most people don't seem to think “it’s worth it”. But I… I want to build robots! //Dave
#Client#pause-2,5
 R-ROBOTS?! //Geriol
#Match#pause-2,5
 Shh! It’s a little embarrassing. I try to do something in my spare time. So far, I just got one that can butter my toast. //Dave
#Client#pause-2,5
 That’s super cool! //Geriol
#Match#pause-2,5
 Can’t tell if you mean it or just seem sarcastic again. //Dave
#Client#pause-2,5
 I-I think it actually is cool… //Geriol
#Match#pause-2,5
 Sorry. Not used to people not mocking me for it. But well. If I can’t make a living on cool robots then atleast I don’t need to think about my toasts in the future. Haha. //Dave
#Client#pause-2,5
 Haha… Yeah it is pretty annoying to butter things. //Geriol
#Match#pause-2,5
 Especially if you get buttery fingers. Then everything you touch get Buttered. //Dave
#Client#pause-2,5
 Buttastic. //Geriol
#Match#pause-2,5
 Hehe, yeah. //Dave

        ~changeMood(matchMood, 20)
        ~changeMood(clientMood, 20) 
~OverExcited = false
}
->->
=== MiddleDate ===
#EnableFeedBack                                                     // Use this tag to tell unity to record player input. Can be a timer also.    
#Client#pause-2,5
 So what made you wanna have this date? //Geriol

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
      -> MiddleDateNeutral1 ->    
   - YES:
      -> MiddleDateYes1 ->
}
-> MiddleEnd


///// Start of choice 1

// Knot for neutral choice 1. The story here could be kept the same as the Yes choice. 
// If it is different, then further knots should be called from here instead of going back up with '->->'
=== MiddleDateNeutral1  ===
#Client#pause-2,5
 Have you done something like this before? //Geriol
#Match#pause-2,5
 Like what? //Dave
#Client#pause-2,5
 You know, like just meeting up someone you haven’t really met before for… certain intentions? //Geriol
#Match#pause-2,5
 Not really. //Dave
#Match#pause-2,5
 I met your friend before. //Dave
#Client#pause-2,5 
 A friend? What friend? //Geriol
#Match#pause-2,5
 You know your best friend. Juliet. //Dave
#Client#pause-2,5
 Best?... -Sees Juliet behind Dave giving thumbs up- //Geriol
#Match#pause-2,5
 Yeah I got to know her and she started to talk about you that I might find you interesting. And here we are! //Dave
#Client#pause-2,5
 Just like that you believed her? //Geriol
#Match#pause-2,5
 Well I'm here to test her claim. //Dave

#EnableFeedBack
#Client#pause-2,5
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
      ->->  
   - YES:
      ->->
}
->->
= No1
#Client#pause-2,5
 Maybe we should talk about something else?  //Geriol
#Match#pause-2,5
 Sorry, is it weird? //Dave
#Client#pause-2,5
 I don’t know. Maybe it just makes thing a little… eeeh?? //Geriol
#Match#pause-2,5
 Hmm… I can see that make it a little… eeeh. //Dave
#Client#pause-2,5
 Super. //Geriol

~changeMood(clientMood, -5)
~changeMood(matchMood, -5)
->->

// Knot for yes choice 1.
=== MiddleDateYes1 ===
#Client#pause-2,5
 Have you done something like this before? //Geriol
#Match#pause-2,5
 Like what? //Dave
#Client#pause-2,5
 You know, like just meeting up someone you haven’t really met before for… certain intentions? //Geriol
#Match#pause-2,5 
 Not really. //Dave
#Client#pause-2,5
 What persuaded you to it? //Geriol
#Match#pause-2,5
 Oh, I met your best friend a couple of weeks ago and she told me about you.  //Dave
#Client#pause-2,5
 My BEST friend? //Geriol
#Match#pause-2,5
 You know, Juliet. //Dave
#Client#pause-2,5
 Juliet? -Sees Juliet behind Dave giving thumbs up- //Geriol
#Match#pause-2,5
 Yeah, I was just out, for once. And she just came up to me and started to talk to me. //Dave
 #Match#pause-2,5
 We talked a few more times and we got into friends and dating and such and she seemed keen to bring up you in it. //Dave
#Client#pause-2,5
 Oh. So what did she tell you about me??? //Geriol
#Match#pause-2,5
 Heh, that’s between her and me.  //Dave

#EnableFeedBack
#Client#pause-2,5
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
      ->->  
   - YES:
      ->->
}
->->
= No1
#Client#pause-2,5
 Maybe we shouldn’t get to much into the niddy gritty of this situation. //Geriol
#Match#pause-2,5
 Yeah, sometimes that just ruins the moment. //Dave
#Client#pause-2,5
 … //Geriol
#Match#pause-2,5
 … //Dave
#Client#pause-2,5
 Look! Ants. A lot of them. CraaaaAAWLING ON ME!!!- No wait. It’s just an itch. //Geriol
#Match#pause-2,5
 Your way of breaking the silence? //Dave
#Client#pause-2,5
 Huh? Eh… Lets go with that. //Geriol
#Match#pause-2,5
 Haha. //Dave

~changeMood(clientMood, -5)
~changeMood(matchMood, -5)
->->

///// Start of choice 2

// Knot for neutral choice 2.
// Uses the OverExcited variable. This enables selective memory from previous events.
=== MiddleDateNeutral2 ===
#Client#pause-2,5
{
- OverExcited:
 Well she didn’t tell me anything about you. //Geriol
#Match#pause-2,5
 So I’m a mystery box for you then? //Dave
#Client#pause-2,5
 Pretty much. And I’m terrible at reading people. //Geriol
#Match#pause-2,5
 Same here. I just got good intel.  //Dave
#Client#pause-2,5
 Did she mention any of my weird habits? //Geriol
#Match#pause-2,5
 I don’t know. Which one? //Dave
#Client#pause-2,5
 The one with- NO I SEE. I will just keep my mouth shut about this whole thing. //Geriol
#Match#pause-2,5
 Hehe. But trust me, she just said good things about you. //Dave
#Client#pause-2,5
 Which only gives out barely half the truth… //Geriol
#Match#pause-2,5 
 Isn’t that how marketing usually works, but we still buy into things despite that? //Dave
#Client#pause-2,5
 I guess so if you phrase it like that. //Geriol


                       // If overExicted is true
~changeMood(clientMood, 3)
~changeMood(matchMood, 3)
 - !OverExcited:
#Client#pause-2,5
 Well so far I find you interesting if that isn’t weird. Just interesting in a general way! Not… creepy… //Geriol
#Match#pause-2,5
 I didn’t think it creepy! We’ve just met but I sense good vibes from you. Someone very kind, just like Juliet said. //Dave
#Client#pause-2,5
 She said that? //Geriol
#Match#pause-2,5
 And some more. //Dave
#Client#pause-2,5
 And you reeeally can’t tell me what she told you?? //Geriol
#Match#pause-2,5
 That would spoil it a little. //Dave
#Client#pause-2,5
 Spoil away! I like spoilers. I usually listen to what people talk about a movie after they’ve seen it just so I know what’s gonna happen. //Geriol
#Match#pause-2,5
 And that doesn’t… spoil it for you? //Dave
#Client#pause-2,5
 It makes me comfortable. //Geriol
#Match#pause-2,5
 Sometimes you need a little unknown in life. //Dave
#Client#pause-2,5
 Not in science. //Geriol
#Match#pause-2,5
 Everything in science is unknown! Even known things can become new unknowns! //Dave
#Client#pause-2,5
 I see your point. But she didn’t mention anything weird about me? //Geriol
#Match#pause-2,5
 Keep trying but you won’t get anything more out. //Dave
#Client#pause-2,5
 Fine… I… I try to live in the unknown a little. //Geriol
#Match#pause-2,5
 Haha! There you go! //Dave
 
~OverExcited = false
~changeMood(clientMood, 3)
~changeMood(matchMood, 3)
}
->->

// Knot for yes choice 2.
=== MiddleDateYes2 === 
#Client#pause-2,5
{
- OverExcited: 
 So what kind of expectations do you have with this? I think maybe… my friend sold my image too much. //Geriol
#Match#pause-2,5
 I don’t know. I don’t really have big expectations. NOT that I don’t have expectations from you in that way. Just… See whatever this is. //Dave
#Client#pause-2,5
 Yeah, I-I guess I have similar expectations with that. Honestly I don’t have that much of a social life in general. //Geriol
 #Client#pause-2,5
 So, not sounding desperate or anything, but SOMETHING at all would be nice. //Geriol
#Match#pause-2,5
 So anything at all, even me would be good enough. //Dave
#Client#pause-2,5
 N-not like that! Just you know… eeh… //Geriol
#Match#pause-2,5
 I’m just messing with you! I think we both kind of have the same thinking here. Which makes me think Juliet didn’t exaggerate that much about you. //Dave
#Client#pause-2,5
 Hmm… //Geriol
#Match#pause-2,5
 Don’t think about what she said! Just enjoy the moment. //Dave
#Client#pause-2,5
 …Okay //Geriol

        ~changeMood(matchMood, 20)
        ~changeMood(clientMood, 20) 
        
- !OverExcited:

#Client#pause-2,5
 So how is the testing going so far? //Geriol
#Match#pause-2,5
 Hard to say. We’ve just been sitting here with picnic. So so far its been nice. //Dave
#Client#pause-2,5
 That’s good to hear. Haven’t really done picnic before. Its a foreign concept. Do you really have to have a red-white patterned blanket? It wasn’t easy to find one. //Geriol
#Match#pause-2,5 
 Ah! So you did some pre-planning? Not really, it’s just a common used one in stuff I guess. //Dave
#Client#pause-2,5
 But everything else is right? //Geriol
#Match#pause-2,5
 As far as I’m knowledgeable about picnics. Not really my alley either. //Dave
#Client#pause-2,5
 Even toothbrushes? //Geriol
#Match#pause-2,5
 …I think that is a taste thing. //Dave
#Client#pause-2,5
 Okay I see… //Geriol

        ~changeMood(matchMood, 20)
        ~changeMood(clientMood, 20) 
~OverExcited = false
}
->->
=== MiddleHobby ===
#EnableFeedBack                                                     // Use this tag to tell unity to record player input. Can be a timer also.    
#Client#pause-2,5
 So what you like to do? Got any hobbies? //Geriol

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
      -> MiddleHobbyNeutral1 ->    
   - YES:
      -> MiddleHobbyYes1 ->
}
-> MiddleEnd


///// Start of choice 1

// Knot for neutral choice 1. The story here could be kept the same as the Yes choice. 
// If it is different, then further knots should be called from here instead of going back up with '->->'
=== MiddleHobbyNeutral1  ===
#Match#pause-2,5
 Hmm… When I really think about it there isn’t that much that I actually do that could be considered a hobby. //Dave
#Client#pause-2,5
 I think everyone has something, no? //Geriol

#EnableFeedBack
#Match#pause-2,5
 Well that would make sense. But its pretty mundane stuff in my life. Wake up and work and then home and sleep if nothing else. //Dave
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
      ->->  
   - YES:
      ->->
}
->->
= No1
#Client#pause-2,5
 I do the same then. Just wake up and study and not so much else. //Geriol
#Match#pause-2,5
 I guess we both have a pretty boring life. //Dave
#Client#pause-2,5
 So far maybe. But not forever. I think it will get better after I finish my studies. //Geriol
#Match#pause-2,5
 Don’t take that as certainty. Usually life gets more of the same AFTER school. //Dave
#Client#pause-2,5
 Hmm… Then I’m worried. //Geriol
#Match#pause-2,5
 Well it’s up to you how it will be. //Dave
#Client#pause-2,5
 …That’s even more worrisome! //Geriol
#Match#pause-2,5
 Haha! Don’t stress about it right now. Just enjoy it. //Dave
#Client#pause-2,5
 Hmm… //Geriol

~changeMood(clientMood, -5)
~changeMood(matchMood, -5)
->->

// Knot for yes choice 1.
=== MiddleHobbyYes1 ===
#Match#pause-2,5
 Hmm… When I really think about it there isn’t that much that I actually do that could be considered a hobby. //Dave
#Client#pause-2,5
 Why? //Geriol
#Match#pause-2,5
 Well I usually just wake up, go to work, work more from home if anything comes up and then go to bed. Pretty mundane stuff. //Dave
#Client#pause-2,5
 I’m pretty sure everyones days are like that. //Geriol

#EnableFeedBack
#Match#pause-2,5
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
      ->->  
   - YES:
      ->->
}
->->
= No1
#Client#pause-2,5
 I guess I’m the same with that then. I wake up, study and then go to bed. Not doing so much else. //Geriol
#Match#pause-2,5
 I guess we are pretty same then. //Dave
#Client#pause-2,5
 I guess so. //Geriol
#Match#pause-2,5
 Funny how we got here if we both just do those things and also stay at home a lot. //Dave
#Client#pause-2,5
 I guess… circumstances create other circumstances -Looks at Juliet that just smiles back- //Geriol

~changeMood(clientMood, -5)
~changeMood(matchMood, -5)
->->

///// Start of choice 2

// Knot for neutral choice 2.
// Uses the OverExcited variable. This enables selective memory from previous events.
=== MiddleHobbyNeutral2 ===
#Client#pause-2,5
{
- OverExcited:
 Well I do kind of the same things like you then. But I do like to tinker with stuff. //Geriol
#Match#pause-2,5
 What kind of stuff? //Dave
#Client#pause-2,5
 Just regular household stuff you know. Picking them apart and smash them together and see if something new comes from that. //Geriol
#Match#pause-2,5
 Isn’t that dangerous. //Dave
#Client#pause-2,5
 Sometimes… Happens a few time it creates a big spark. But I got the fire extinguisher close by since last time. //Geriol
#Match#pause-2,5
 Burned anything down? //Dave
#Client#pause-2,5
 Mostly half my table. I got books stacked on eachother to make new legs for it. //Geriol
#Match#pause-2,5
 You didn’t buy a new one?? //Dave
#Client#pause-2,5
 They’re expensive! //Geriol
#Match#pause-2,5
 There is secondhand stuff you know.  //Dave
#Client#pause-2,5
 Family heirloom? //Geriol
#Match#pause-2,5
 … //Dave
#Client#pause-2,5
 I guess I can’t bother to get a new table.  //Geriol
#Match#pause-2,5
 Haha, guessed as much. I broke my beds bottom legs and now its a slightly elevated bed. //Dave
#Client#pause-2,5
 Get a new bed? //Geriol
#Match#pause-2,5
 Same with me. Can’t be bothered.  //Dave
#Client#pause-2,5
 Good you could be honest about it. //Geriol
#Match#pause-2,5
 Haha, one got to be! //Dave


                       // If overExicted is true
~changeMood(clientMood, 5)
~changeMood(matchMood, 5)
 - !OverExcited:
#Client#pause-2,5
 You don’t do any sports or something? //Geriol
#Match#pause-2,5
 Not really. Unless you count stretching in the morning and evening a sport. A sport of yoga! //Dave
#Client#pause-2,5
 Could be called a sport considering how painful it is to stretch. //Geriol
#Match#pause-2,5
 Eeh, it gets easier with time! But what about you? //Dave
#Client#pause-2,5
 Uhm… Not much really. When I can i do swim. //Geriol
#Match#pause-2,5
 Well thats much better than stretching. Outclassing me here. //Dave
#Client#pause-2,5
 Haven’t been able to do it for a while though. No good places around for me to use. //Geriol
#Match#pause-2,5
 Not even a swimming pool? //Dave
#Client#pause-2,5
 Well they are too short for my taste, and those places costs! I live on a budget. //Geriol
#Match#pause-2,5
 Well then I guess we both don’t have so much to say about this subject? //Dave
#Client#pause-2,5
 Affirmative so far. Lets get back to it after consideration? //Geriol
#Match#pause-2,5
 Roger roger.  //Dave

~OverExcited = false
~changeMood(clientMood, 3)
~changeMood(matchMood, 3)
}
->->

// Knot for yes choice 2.
=== MiddleHobbyYes2 === 
#Client#pause-2,5
{
- OverExcited: 
 But you don’t have anything you like to do? Sorry if I’m pushing on this or if it sounds judgy… //Geriol
#Match#pause-2,5
 Its fine. It’s just not something I’ve been thinking about before. Hmm… Well I like to sit at home most of the time. //Dave
 #Match#pause-2,5
 I got the telly on. I call home to my family often. I  help out my friends if they need help with something. And I like to build stuff. //Dave
#Client#pause-2,5
 Build what kind of stuff? //Geriol
#Match#pause-2,5
 Robots. //Dave
#Client#pause-2,5
 R-robots?? //Geriol
#Match#pause-2,5
 Yeah. Tiny ones so far. //Dave
#Client#pause-2,5
 Well that’s something worth sharing! //Geriol
#Match#pause-2,5
 Is it? Huh, I guess I see it more as a work thing than a hobby. I got a dream of building robots eventually in the future. //Dave
#Client#pause-2,5
 That is… admirable. What kind of robots do you have? What can they do? //Geriol
#Match#pause-2,5
 Nothing you think of probably. So far they stop running into walls. A big milestone for me with that. Though I got one that butter my toast. //Dave
#Client#pause-2,5
 Only butter it? //Geriol
#Match#pause-2,5
 Gotta start simple. Even doing something like that is hard. Still barely functioning that too. It starts but never stops.  //Dave
#Client#pause-2,5
 Can I see them someday??? //Geriol
#Match#pause-2,5
 Sure. You’re the first one to seem interesting in it. //Dave
#Client#pause-2,5
 Can’t see how one can’t be. //Geriol
#Match#pause-2,5
 Okay. Then. But what about you? //Dave
#Client#pause-2,5
 My hobbies? Hmm… I guess tinkering with stuff and swim. //Geriol
#Match#pause-2,5
 What kind of stuff? //Dave
#Client#pause-2,5
 Nothing cool as robots. Just smashing things together basically and see if there is some use to it so far. And without explosions.  //Geriol
#Match#pause-2,5
 As I said. Just solving simple stuff is a art. But you swim also? //Dave
#Client#pause-2,5
 Yeah. Only real physical activity I do. Though I have to travel a bit to find a place that fits me. //Geriol
#Match#pause-2,5
 Isn’t a swimming hall good enough? //Dave
#Client#pause-2,5
 Too small for me. Plus too expensive for what I get. So I guess my swimming thing is on hold right now. //Geriol
#Match#pause-2,5
 I see. Well thats just more time to do other things, ain’t it? //Dave
#Client#pause-2,5
 True true. //Geriol

        ~changeMood(matchMood, 20)
        ~changeMood(clientMood, 20) 
        
- !OverExcited:

#Client#pause-2,5
 And if there is something else? //Geriol
#Match#pause-2,5
 What? //Dave
#Client#pause-2,5
 You said if there is nothing else. What if there is something else? //Geriol
#Match#pause-2,5
 Oh. Uhm… I guess I like to, you know, read and stuff. //Dave
#Client#pause-2,5
 What kind? //Geriol
#Match#pause-2,5
 Mostly Sci-Fi. You read any of it? //Dave
#Client#pause-2,5
 No sorry, if there were something I would read then it would be more of a thriller noir. //Geriol
#Match#pause-2,5
 You didn’t strike me of a noir reader. //Dave
#Client#pause-2,5
 Well I don’t really know whats going on in those books. But the characters are usually pretty cool and say cool stuff. //Geriol
#Match#pause-2,5
 Aren’t they all pretty gruffy? //Dave
#Client#pause-2,5
 Pretty much. I think I may have a soft spot for those kind of characters. They just seem so sad all the time, until they solve the crime and they figure out their problems! //Geriol
#Match#pause-2,5
 Do they? //Dave
#Client#pause-2,5
 Until a sequel or spin-off comes out. Then they need to be that gruffy person again and all their growth has been redacted. //Geriol
#Match#pause-2,5
 Guess they want newcomers to be able to just jump in into the serie. //Dave
#Client#pause-2,5
 Well there is a thing called - Start at the beginning. It’s just annoying for me to kind of re-reading parts they’ve already fixed. //Geriol
#Match#pause-2,5
 I guess its a usual thing despite genre. //Dave
#Client#pause-2,5
 Happens in Sci-Fi also? //Geriol
#Match#pause-2,5
 Yeah, but then mostly with the whole “Saving the universe” thing. The universe gets saved and they get the fame for it just to be poor and despited again in the next book. //Dave
#Client#pause-2,5
 Seem like they don’t like consequences in their stories. //Geriol
#Match#pause-2,5
 Feel the same. But I hope the next book in the serie I read doesn’t do it! //Dave
#Client#pause-2,5
 High hopes? //Geriol
#Match#pause-2,5
 No… Not really.
#Client#pause-2,5
 Well then I hope for it too. //Geriol
#Match#pause-2,5
 Thanks. //Dave

        ~changeMood(matchMood, 10)
        ~changeMood(clientMood, 10) 
~OverExcited = false
}
->->