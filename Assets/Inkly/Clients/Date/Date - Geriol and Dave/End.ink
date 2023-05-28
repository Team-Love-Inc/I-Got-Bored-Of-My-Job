LIST END = (endFamily), (endPlaces), (endMemory)

=== pickEnd ===
{LIST_COUNT(END) == 0: 
    #Client#pause-2,5
    Oh I just remember, my stove is on at home. cya. //Geriol
    -> END
}

~temp value = LIST_RANDOM(END)
{value:
    - endFamily:
        ~ END -= endFamily
        -> EndFamily
    - endPlaces:
        ~ END -= endPlaces
        -> EndPlaces
    - endMemory:
        ~END -= endMemory
        -> EndMemory
}
-> END

// Entry knot for intro, only happens once.
// Call from main.
=== EndStart ===

#Narrator#pause-2,5
Ending food and admiring scenery with smol fruit platter eat.
#Client#pause-2,5
 I have some fruits for dessert, hope it ok. //Geriol
#Match#pause-2,5
 Yes, thanks. It fine.
Speech bubble to show if Match like Geriol food choice or not. Affect Match mood -10 if bad food match. (No player to affect food choice cause this be personality.)


-> pickEnd

// Ending knot for intro, call at the end to check mood and start End story.
=== EndEnd ===
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

=== EndFamily ===
#EnableFeedBack                                                     // Use this tag to tell unity to record player input. Can be a timer also.    
#Client#pause-2,5
 So you got friends and family here in town? //Geriol

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
      -> EndFamilyNeutral1 ->    
   - YES:
      -> EndFamilyYes1 ->
}
-> EndEnd


///// Start of choice 1

// Knot for neutral choice 1. The story here could be kept the same as the Yes choice. 
// If it is different, then further knots should be called from here instead of going back up with '->->'
=== EndFamilyNeutral1  ===
//Neutral
#Match#pause-2,5
 Yeah most of them. Mom and dad and one brother in town and my other brother outside. With friends… those few I still meet sometimes also lives close-by. //Dave
#Client#pause-2,5
 A few? //Geriol
#Match#pause-2,5
 Yeah, still friends from the school days. Meet maybe like once a month or so if we feel like it. //Dave
#Match#pause-2,5
They are like me that likes to be by themselves at home so we aren’t that driven to do stuff. //Dave
#Client#pause-2,5
What stuff do you guys usually do then? //Geriol


#EnableFeedBack
#Match#pause-2,5
Eeh… Watch movies I guess? We don’t really need to do much with each other. Just sitting on the sofa quietly is good enough for us. //Dave
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
//Neutral->No
#Client#pause-2,5
 Sounds nice. I just sit inside a lot. //Geriol
#Match#pause-2,5
 With your friends? //Dave
#Client#pause-2,5
 Oh, well... Mostly by myself. Don’t have that many friends. But that’s fine! //Geriol
#Match#pause-2,5
 Whatever floats your boat I guess.//Dave

~changeMood(clientMood, -5)
~changeMood(matchMood, -5)
->->

// Knot for yes choice 1.
=== EndFamilyYes1 ===
//Yes
#Client#pause-2,5
 Tell me about your family a little, I-if you want and don’t mind... //Geriol
#Match#pause-2,5
 Of course not! Well they are pretty normal, I guess. I got a mom and dad and two brothers. //Dave
#Match#pause-2,5
Mom and dad lives in the northern part of town. One brother lives around here and my other lives the next town over. //Dave
#Client#pause-2,5
 And you guys are going to go home this weekend?//Geriol
#Match#pause-2,5
 We do it every two week. Just to eat and hangout with everyone. My mom was always a lady for holding a family close so we see each other and talk to each other alot. //Dave
#Client#pause-2,5
 That’s so nice! Most people I’ve met are pretty distant with their families. //Geriol


#EnableFeedBack
#Match#pause-2,5
 I guess that is more of the default. But yeah. My family is pretty much the closest people I have. How about you and your family? //Dave
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
//Yes->No
#Client#pause-2,5
 Well we… You know we are pretty close also… //Geriol
#Match#pause-2,5
 Don’t want to talk about it? //Dave
#Client#pause-2,5
 Maybe not today, one of those days where I just miss them a little extra. Its been a while since I saw them. //Geriol
#Match#pause-2,5
 Eeh don’t worry about it.  //Dave

~changeMood(clientMood, -10)
~changeMood(matchMood, -10)
->->

///// Start of choice 2

// Knot for neutral choice 2.
// Uses the OverExcited variable. This enables selective memory from previous events.
=== EndFamilyNeutral2 ===
#Client#pause-2,5
{
- OverExcited:
//Yes->Neutral
Well I got five siblings and a mom and dad all living back home. //Geriol
#Match#pause-2,5
is it far? //Dave
#Client#pause-2,5
Really far. Its one of those river communities if you know about it. //Geriol
#Match#pause-2,5
Some of it. They’re pretty isolated from other places, no? //Dave
#Client#pause-2,5
A little so. We are all pretty tight with each other as we aren’t that many so you could say I got a big extension of family.  //Geriol
#Match#pause-2,5
Good people? //Dave
#Client#pause-2,5
Sometimes a little too much. Its a kind of overbearing that is on the edge from lovely to - get away from me. //Geriol
#Match#pause-2,5
Sounds healthy though. //Dave
#Client#pause-2,5
Love them all either way! //Geriol

                       // If overExicted is true
~changeMood(clientMood, 5)
~changeMood(matchMood, 5)
 - !OverExcited:
 //Neutral->Neutral
#Client#pause-2,5
 That sounds relaxing. //Geriol
#Match#pause-2,5
  Its very relaxing. Maybe too much as we’ve barely stayed awake finishing a movie. //Dave
#Client#pause-2,5
 Can you fall asleep in front of a movie? //Geriol
#Match#pause-2,5
  You can’t? //Dave
#Client#pause-2,5
 I find that difficult. //Geriol
#Match#pause-2,5
 Well share that energy with the rest of us. We’ve tried re-watching a movie like five times but always fall asleep. //Dave
#Client#pause-2,5
 Sounds like you guys need some coffee. //Geriol
#Match#pause-2,5
  Tried that too… You should join us sometime and keep us awake. //Dave
#Client#pause-2,5
 I-I don’t know about that…  //Geriol
#Match#pause-2,5
 You don’t have too if you don’t want to. But you are welcome to. Can’t hurt once at least? //Dave
 #Client#pause-2,5
 I-I’ll think about it.  //Geriol
#Match#pause-2,5
Sweet. //Dave

~OverExcited = false
~changeMood(clientMood, 2)
~changeMood(matchMood, 2)
}
->->

// Knot for yes choice 2.
=== EndFamilyYes2 === 
#Client#pause-2,5
{
- OverExcited: 
//Yes->Yes
 I guess I’m pretty much the same there, a mom and dad and five siblings. My mom works as a handyman and my dad is a fisherman. //Geriol
 #Client#pause-2,5
With my siblings… Not sure what they do right now. They switch it up pretty often. //Geriol
#Match#pause-2,5
 Sounds like a fun bunch. //Dave
#Client#pause-2,5
 Yeah, though we also got a little bigger thing with the whole family thing.//Geriol
#Match#pause-2,5
 How so? //Dave
#Client#pause-2,5
 Well I’m from one of the river communities if you know about them.//Geriol
#Match#pause-2,5
 Just a little. Its pretty isolated isn’t it? //Dave
 #Client#pause-2,5
 Not as much as people think. But yeah we usually stay within them. We’re also not that many, like a small village so everyone know everyone. //Geriol
 #Client#pause-2,5
It’s like having 50 sets of parents. And we celebrated everything together… //Geriol
#Match#pause-2,5
 But now? //Dave
 #Client#pause-2,5
 It’s just me. Moved here to study so it’s been a while since I’ve been home.//Geriol
#Match#pause-2,5
 Is it far away? //Dave
#Client#pause-2,5
 Very far and pretty expensive. So haven’t been able to visit home these two years.//Geriol
#Match#pause-2,5
 That’s pretty rough. I’m sure you’ll be able to visit soon.  //Dave
 #Client#pause-2,5
 Me too. But I’m okay so far. We still call and send letters with pictures in them. //Geriol


        ~changeMood(matchMood, 20)
        ~changeMood(clientMood, 20) 
        
- !OverExcited:
//Neutral->Yes
#Client#pause-2,5
 Sounds like my kind of friends. //Geriol
#Match#pause-2,5
 What do you do with your friends then? //Dave
#Client#pause-2,5
 Oh… Well I don’t have that many here in the city. Like… a half friend? //Geriol
#Match#pause-2,5
 Half? //Dave
#Client#pause-2,5
 You know, like say hello and how are you and such? //Geriol
#Match#pause-2,5
 That’s more an acquaintance. //Dave
 #Client#pause-2,5
 Always called them half friends. Or my mom usually calls them so. //Geriol
#Match#pause-2,5
 Well it sounds nicer like that though. //Dave
 #Client#pause-2,5
 But yeah, with those I have back home we usually just laze around or help people out with stuff. //Geriol
#Match#pause-2,5
 Sounds better than just melt into the sofa. //Dave
 #Client#pause-2,5
 Wouldn’t mind melting into a sofa just watching something. //Geriol
#Match#pause-2,5
 Want to join us on that someday? //Dave
#Client#pause-2,5
 Well I… I don’t want to impose with that really… It would be nice. Got some movies in mind I would want to see with someone. //Geriol
#Match#pause-2,5
 Then its probably fine! We’ve been out of luck finding new movies to watch so they would probably hail you for it. //Dave
#Client#pause-2,5
 That would make me uncomfortable. //Geriol
#Match#pause-2,5
 It would be more like a loud cheer and small arms raising up. So don’t worry. //Dave
 #Client#pause-2,5
 Well I could handle that maybe. Thanks. //Geriol

        ~changeMood(matchMood, 20)
        ~changeMood(clientMood, 20) 
~OverExcited = false
}
->->
=== EndPlaces ===
#EnableFeedBack                                                     // Use this tag to tell unity to record player input. Can be a timer also.    
#Client#pause-2,5
 What type of places you like go to? //Geriol

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
      -> EndPlacesNeutral1 ->    
   - YES:
      -> EndPlacesYes1 ->
}
-> EndEnd


///// Start of choice 1

// Knot for neutral choice 1. The story here could be kept the same as the Yes choice. 
// If it is different, then further knots should be called from here instead of going back up with '->->'
=== EndPlacesNeutral1  ===
//Neutral
#Match#pause-2,5
 Hmm… Thats hard to say really. //Dave
#Client#pause-2,5
 Yeah, I don’t really have much better to say of that either. I don’t go around that much. //Geriol
#Match#pause-2,5
 Well I guess I do sometimes go out just by myself. //Dave
#Client#pause-2,5
 Out as in what? //Geriol
 #Match#pause-2,5
 Just moving around places. Not like a bar or something. Never if not a good reason. Going between shops and such. Though I guess I’ve gone to places I wouldn’t really expect myself going to? //Dave
#Client#pause-2,5
 Like what? //Geriol
 
#EnableFeedBack
#Match#pause-2,5
 Like a historical museum. //Dave
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
//Neutral->No
#Client#pause-2,5
 Not the most exciting places. //Geriol
#Match#pause-2,5
 Well maybe not in terms of action and suspense. But I don’t know. I find something relaxing about just being in there. Hard to put my finger on it. //Dave
#Client#pause-2,5
 Well I haven’t been to many museums in my life so hard to add anything to it.
Dave: Maybe that’s not for you, then. //Geriol

~changeMood(clientMood, -5)
~changeMood(matchMood, -5)
->->

// Knot for yes choice 1.
=== EndPlacesYes1 ===
//Yes
#Match#pause-2,5
 Hmm… Thats hard to say really. //Dave
#Client#pause-2,5
 How come? //Geriol
#Match#pause-2,5
 Hmm… Thats hard to say really. //Dave
#Client#pause-2,5
 How come? //Geriol
#Match#pause-2,5
 I usually only move between work and home and not so many other places. //Dave
#Client#pause-2,5
 Well that’s on work days, no? Aren’t there any places you like to go to when you got the time? //Geriol
#EnableFeedBack
 #Match#pause-2,5
 Time time time… It just seems like I don’t have time for much else but that. But I guess places I like to go and do stuff at are… Like… I don’t know. A cake shop or something? //Dave
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
//Yes->No
#Client#pause-2,5
 It’s okay if you can’t think of something. I’m no better with that. I just move between school and home also and barely go to places. //Geriol
#Match#pause-2,5
 Oh, alright. Thank you. //Dave
#Client#pause-2,5
 No problem. //Geriol

~changeMood(clientMood, -5)
~changeMood(matchMood, -5)
->->

///// Start of choice 2

// Knot for neutral choice 2.
// Uses the OverExcited variable. This enables selective memory from previous events.
=== EndPlacesNeutral2 ===
#Client#pause-2,5
{
- OverExcited:
//Yes->Neutral
#Client#pause-2,5
 What kind of cake shop? //Geriol
#Match#pause-2,5
 Eeh… I kind of drift between different types. But I’ve been to one more than other recently. //Dave
#Client#pause-2,5
 Which one? //Geriol
#Match#pause-2,5
 Do you know “Refine Coffeé Taste”? //Dave
#Client#pause-2,5
 Not really. //Geriol
 #Match#pause-2,5
 As the name suggest they have a strong focus on the coffée side and cakes and such that goes well with their brands of coffée. //Dave
#Match#pause-2,5
And I’m pretty avid coffée drinker so Its nice to get something from there. //Dave
#Client#pause-2,5
 Does it really taste that distinct? //Geriol
 #Match#pause-2,5
 Well I’m not a coffée taste or anything, but it does taste better than my homemade. Though only if the prices weren’t as high as they are. //Dave
#Client#pause-2,5
 Everything is going up I guess. //Geriol
#Match#pause-2,5
 Yeah, they are. But anyway, the cakes they sell usually works best with their brand. I’ve tried taking some of it home and it just wasn’t the same. //Dave
#Client#pause-2,5
 Hmm… I’m not really a coffée person, but it does sound intriguing to check out at least. //Geriol
#Match#pause-2,5
 You don’t have to force yourself just because of me. //Dave
#Client#pause-2,5
  I-I’m not! You are just a good and honest commercial… guy for them. //Geriol
#Match#pause-2,5
 Haha, well thanks I guess. //Dave

                   	// If overExicted is true
~changeMood(clientMood, 3)
~changeMood(matchMood, 3)

 - !OverExcited:
 //Neutral->Neutral
#Client#pause-2,5
 Well that sounds a little special. Haven’t met a lot of people who likes to go to those places. //Geriol
#Match#pause-2,5
 Probably because a lot of them had to go to those places while in school, the time where learning stuff was uncool and reading was a snore. //Dave
#Match#pause-2,5
I hope at least I’m not like that anymore. Though I just usually wander around inside and just read bite sizes of information. //Dave
#Client#pause-2,5
 Then why go there? Isn’t it just a lot of money going to those places? //Geriol
#Match#pause-2,5
 Hehe, I go to those communal ones that have free entrance. //Dave
#Client#pause-2,5
 Smart. //Geriol
#Match#pause-2,5
 Very if I may say so myself. But what about you? //Dave
#Client#pause-2,5
 Me? Hmm… I guess maybe going to secondhand store? //Geriol
#Match#pause-2,5
 Secondhand? //Dave
#Client#pause-2,5
 Yeah. I usually don’t buy stuff there, but I like to just see what people have gotten rid of and such.//Geriol
#Match#pause-2,5
 A kind of windowshopping? //Dave
#Client#pause-2,5
 Yeah I guess so. //Geriol
 #Match#pause-2,5
 You know what? We both like to do things on a budget. //Dave
#Client#pause-2,5
 Hehe, I guess so. //Geriol
 #Match#pause-2,5
 Might as well if its nice. Like just hanging in the park with something eating stuff out of a basket or a bag even. //Dave
#Client#pause-2,5
 Yeah, it has been nice. //Geriol
#Match#pause-2,5
 Indeed. //Dave
 
~OverExcited = false
~changeMood(clientMood, 3)
~changeMood(matchMood, 3)

}
->->

// Knot for yes choice 2.
=== EndPlacesYes2 === 
#Client#pause-2,5
{
- OverExcited: 
//Yes->Yes
#Client#pause-2,5
 Really? //Geriol
#Match#pause-2,5
 I don’t know. Guess I don’t really remember places I’ve been to that I can’t feel joy from that isn’t my own place. //Dave
#Client#pause-2,5
 Well, you’d never had any places you went to and did stuff at when you were younger? //Geriol
#Match#pause-2,5
 You mean like my school years? //Dave
#Client#pause-2,5
 Yeah. Feels like a person did a lot more of different stuff then before becoming an adult and just… live in routine. Maybe you went somewhere that really made an impact on you?//Geriol
 #Match#pause-2,5
 Well, me and my friends usually just stayed inside and watching movies or playing games… But I guess we did something once that was really fun and pretty fantastic. Mountain camping. //Dave
#Client#pause-2,5
 Woah, really? //Geriol
#Match#pause-2,5
  Yeah. One of my two friends said out “Hey, lets just go to a mountain and like, sleep there”. //Dave
#Match#pause-2,5
  A few weeks later, after deciding on the place and buying the gears and equipments we headed off with the bus. //Dave
#Match#pause-2,5
It was like five hours away and this felt like the most difficult part of it all. The weather wasn’t the best either. //Dave
#Client#pause-2,5
 Was there rain? //Geriol
#Match#pause-2,5
 Some, but not enough to make us stop. When we arrived we were pumped to go climbing finally! But only like an hour in… //Dave
#Match#pause-2,5
My knees were hurting, the rain made the road all muddy, and we packed way too much so we all were pretty exhausted and annoyed when we arrived at the top. //Dave
#Client#pause-2,5
Wow… Did it feel worth it?  //Geriol
#Match#pause-2,5
 Yeah… The sunset was amazing. So far from the world… It had so many colours. I’ve never seen something like that before or since. //Dave
#Client#pause-2,5
 It sounds like a very painful experience. //Geriol
#Match#pause-2,5
 But one with a big reward. So yeah, I guess mountains would be a place I like to go to more often. But until then its cake shops for me. Sorry, I took up the whole conversation there. //Dave
#Client#pause-2,5
  No, it’s fine! It was very interesting to listen to. Thank you for sharing it with me. //Geriol


    	~changeMood(matchMood, 20)
    	~changeMood(clientMood, 20)

        
- !OverExcited:
//Neutral->Yes
#Client#pause-2,5
 What kind of history? //Geriol
#Match#pause-2,5
 Well it hasn’t really mattered which one. I’ve gone to several covering different things. //Dave
#Client#pause-2,5
 Been to the modern history museum? Heard it to be pretty engrossing. //Geriol
#Match#pause-2,5
 Not a fan of modern museum really. Its all so close to now and just happened so feels easy for it to change or being to bias toward. //Dave
#Client#pause-2,5
 Thinking about the moon and the conflict? //Geriol
#Match#pause-2,5
 Mostly. But I’m not really a fan of discussing takes on that. Heard enough bickering about it growing up and no one have changed their mind really. //Dave
#Client#pause-2,5
 Well as good, I’m not really into that also. //Geriol
 #Match#pause-2,5
 That’s a relief to hear. But no, usually its just something about being around like really really really old stuff displayed in a way that makes me intrigued. //Dave
#Match#pause-2,5
Everything gathered in a big place where a lot of people go to for learning. //Dave
#Client#pause-2,5
 Sounds like good enough reasoning for liking something. For me I guess I like to be around rivers and such mostly because it reminds me of home a lot. //Geriol
 #Match#pause-2,5
  Well thats as good enough as any. You don’t need to pour out pages after pages of reasoning for things sometimes. //Dave
#Client#pause-2,5
  I guess. Just wished I had something like yours. //Geriol
 #Match#pause-2,5
 You probably have but don’t really think about it. I didn’t before you started asking questions. //Dave
#Client#pause-2,5
 Oh, I see. Good then. //Geriol


    	~changeMood(matchMood, 20)
    	~changeMood(clientMood, 20)

~OverExcited = false
}
->->
=== EndMemory ===
#EnableFeedBack                                                     // Use this tag to tell unity to record player input. Can be a timer also.    
#Client#pause-2,5
 Do you have a favourite memory? //Geriol

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
      -> EndMemoryNeutral1 ->    
   - YES:
      -> EndMemoryYes1 ->
}
-> EndEnd


///// Start of choice 1

// Knot for neutral choice 1. The story here could be kept the same as the Yes choice. 
// If it is different, then further knots should be called from here instead of going back up with '->->'
=== EndMemoryNeutral1  ===
 //Neutral
#Match#pause-2,5
 Favourite memory? //Dave
#Client#pause-2,5
 If you don’t come up with anything, that’s okay. I was just wondering… //Geriol
#Match#pause-2,5
 No, it’s okay. Uhm… what’s your favourite memory, then? //Dave
#Client#pause-2,5
 Oh, mine is… When I went up to the surface for the first time. I lived under water when I was a kid and didn’t come up until teenager. Seeing the stars clearly… Seeing the people… Seeing what they could do up here. It made me want to join them, in a way? //Geriol
 #Match#pause-2,5
 Is that why you moved here? //Dave
#Client#pause-2,5
 Yes, but also to study computers. Once I found out how interesting computers were, I couldn’t stay away from the surface. //Geriol
#Client#pause-2,5
It’s beautiful up here. And seeing it for the first time made me really, really happy. I’d never seen a fire before. It was so cool to see back then. //Geriol

#EnableFeedBack
#Match#pause-2,5
 Haha, I can imagine. That’s really cool. //Dave
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
//Neutral->No
#Client#pause-2,5
 Surface for you must be just normal and boring… //Geriol
#Match#pause-2,5
 It’s not bad to have that as favourite memory! It’s a new sight and experience. I’d be same with seeing under water. //Dave
#Client#pause-2,5
 Heh, thanks! //Geriol

~changeMood(clientMood, -5)
~changeMood(matchMood, -5)
->->

// Knot for yes choice 1.
=== EndMemoryYes1 ===
//Yes
#Match#pause-2,5
 Favourite memory? //Dave
#Client#pause-2,5
 Yeah. Or a memory that really stuck with you that’s… positive? //Geriol
#Match#pause-2,5
 Hmm, difficult question… I don’t mind it though. I’d say… When I saw my first robot. //Dave
#Client#pause-2,5
 Oh? In what way? //Geriol
#Match#pause-2,5
 It gave me a lot of inspiration. It was so cool. A piece of metal that could move by itself through technology. //Dave
#Match#pause-2,5
I wanted to make same and make others awed like I was. Might not be the most awe inspiring memory for others to hear… //Dave
#Client#pause-2,5
 That sounds great! It sounds great to me. Nothing wrong with being inspired. And robots are super super cool! //Geriol
  #Match#pause-2,5
  Heh, thank you. I.. want to make my own proper robot one day. Something that could help people. //Dave
#Client#pause-2,5
 I’m sure you’ll be able to make it one day. //Geriol

#EnableFeedBack
#Match#pause-2,5
 What about you? //Dave
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
//Yes->No
#Client#pause-2,5
 Ah, no, I don’t think mine is as… interesting as yours. I wouldn’t want to bore you. //Geriol
#Match#pause-2,5
 I’m sure it’s not as bad as you think. //Dave
#Client#pause-2,5
 Maybe… Maybe another day. //Geriol

~changeMood(clientMood, -5)
~changeMood(matchMood, -5)
->->

///// Start of choice 2

// Knot for neutral choice 2.
// Uses the OverExcited variable. This enables selective memory from previous events.
=== EndMemoryNeutral2 ===
#Client#pause-2,5
{
- OverExcited:
//Yes->Neutral
 Well… Mine isn’t as grand or interesting as yours. //Geriol
#Match#pause-2,5
 Come on, indulge me. I shared mine! //Dave
#Client#pause-2,5
 Okay… Mine would be the first time I got to interact with a computer, I guess? Kinda the same as you? That it inspired me to find something I liked to do? //Geriol
#Match#pause-2,5
 How’s that not interesting or a good favourite memory? //Dave
#Client#pause-2,5
 I didn’t want to make it seem like I was copying you by saying a similar thing. //Geriol
#Match#pause-2,5
 But it’s your memory, right? So… It would still be a nice memory to you no matter if it sounds similar to mine or not. Right? //Dave
#Client#pause-2,5
 Okay, true… Uhm, but I was at a museum where we got to interact with a computer and got to see what it could do. //Geriol
#Client#pause-2,5
And I just started to think about other possibilities with it. And I kinda wanted to see if I could make it possible? //Geriol
#Match#pause-2,5
 That’s cool! It’s a nice memory to have as inspiration. //Dave


                   	// If overExicted is true
~changeMood(clientMood, 5)
~changeMood(matchMood, 5)

 - !OverExcited:
 //Neutral->Neutral
#Client#pause-2,5
 So… Do you feel inspired to share?// Geriol
#Match#pause-2,5
 Oh, yeah. Mine must be… When I first made a robot that could move. //Dave
#Client#pause-2,5
 I can imagine! That must’ve been difficult. // Geriol
#Match#pause-2,5
 Not difficult to make it move, but hard to make it move correctly. When it moved like I wanted it to, I felt really happy. //Dave
#Match#pause-2,5
My dream of making a robot that could help others got a little closer. So making a robot, my robot, move… //Dave
#Match#pause-2,5
Made me realise my dream is closer than others have said. That my effort isn’t just me being a “nerd”. //Dave
 #Client#pause-2,5
 People called me a nerd too, but I don’t think it’s a bad thing! They say that cause they don’t understand what we do or what we like. //Geriol
 #Client#pause-2,5
That means we’re just ready to… work harder and smarter! Right? // Geriol
#Match#pause-2,5
 You’re right… Could see it like that. Thank you. //Dave
 #Client#pause-2,5
 Of course! We nerds gotta stick together, right? // Geriol
#Match#pause-2,5
 Hehe, right. //Dave
 

~OverExcited = false
~changeMood(clientMood, 3)
~changeMood(matchMood, 3)

}
->->

// Knot for yes choice 2.
=== EndMemoryYes2 === 
#Client#pause-2,5
{
- OverExcited: 
 //Yes->Yes
#Client#pause-2,5
 Hmm, my favourite memory… It’s hard to choose between. It’s the first time I saw the surface… And the first time I interacted with a computer. //Geriol
#Match#pause-2,5
 You could try and explain both? They both sound nice and interesting memories. //Dave
#Client#pause-2,5
 Alright. Well… Seeing the surface, I found it really beautiful. I really liked seeing the stars. And it was the first time I saw fire, too! We don’t have fire down under water. //Geriol
#Match#pause-2,5
 True, it’s really wet under water, haha. Can’t really stoke a fire down there. //Dave
 #Client#pause-2,5
  Haha, yeah. Way too wet. The second one with computer, I interacted with computer when I went to museum with class. //Geriol
#Client#pause-2,5
Got to interact with one and it’s-... It had so many possibilities. And I wanted to make those possibilities real, kind of? //Geriol
#Match#pause-2,5
 Similar to me then with robot. Both of those are really good favourite memories. //Dave
 #Client#pause-2,5
 Hehe, thanks. //Geriol

    	~changeMood(matchMood, 20)
    	~changeMood(clientMood, 20)

        
- !OverExcited:
//Neutral->Yes
#Client#pause-2,5
 So I told you mine, what about you? Came up with a favourite memory? //Geriol
#Match#pause-2,5
 Yes, yours inspired me to think. Mine would be when I saw my first ever robot. //Dave
#Client#pause-2,5
 How come? //Geriol
#Match#pause-2,5
 Seeing it made me realize what I wanted to do. A piece of metal and wires that could move on its own was really cool. //Dave
#Match#pause-2,5
And I… wanted to make something like that. Might be a little weird to anyone else, but… That dream has stuck despite it all. //Dave
#Client#pause-2,5
 I don’t think it’s weird! It’s really, really cool! Building your own robot has to be a lot of work. And it’s never wrong to feel inspired! //Geriol
#Client#pause-2,5
It’s good to have a favourite memory that inspired your dream. Mine sounds lame in comparison… //Geriol
#Match#pause-2,5
 No, it’s not lame to want to go somewhere new and wondrous. I’d be the same if I saw something similar. It’s a good favourite memory. //Dave
#Client#pause-2,5
 Oh, okay. Thank you. //Geriol

    	~changeMood(matchMood, 10)
    	~changeMood(clientMood, 10)

~OverExcited = false
}

-> END