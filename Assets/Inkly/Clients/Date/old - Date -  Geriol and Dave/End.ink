LIST END = (endFamily), (endPlaces), (endMemory)

=== pickEnd ===
{LIST_COUNT(END) == 0: 
    #Client#pause-5
    Maybe... This was a mistake. Sorry. //Geriol    
    #Match#pause-5
     Yeah, maybe. Thank you for your time.  //Dave
    #Client#pause-5
     Thank you to you too. //Geriol
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

// #Narrator#pause-5
// Ending food and admiring scenery with small fruit platter eat.
#Client#pause-5
 I have some fruits for dessert, hope it ok. //Geriol
#Match#pause-5
 Yes, thanks. It fine.

-> pickEnd

// Ending knot for intro, call at the end to check mood and start End story.
=== EndEnd ===
~ temp cm = checkMood(clientMood, 50)
~ temp mm = checkMood(matchMood, 50)
{
  - cm && mm:                                           // If client and match mood is good.
   ~DateSuccess = true
   -> END
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

=== EndFamily ===
#EnableFeedBack-5                                                     // Use this tag to tell unity to record player input. Can be a timer also.    
#Client#pause-5
 Tell me about your family a little, I-if you want to and don't mind... //Geriol

#DisableFeedBack
~getFeedBack()
{FeedBack:
   - NO:
     #Client#pause-5
      Never mind, that might not be important. //Geriol
     ~changeMood(clientMood, -5)                               // Decrease client mood after we tell it that it should not talk about the weather.
     ~changeMood(matchMood, 5)                                 // Increase match mood, it doesn't like to talk about weather..
     -> pickEnd                                             // Here, we told the client no right away. Story could now lead to another intro
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
#Match#pause-5
Yeah, most of my family is here. My mom, dad, and one brother live in town, while my other brother lives in another city. //Dave
#Match#pause-5
As for my friends, there are a few I still hang out with occasionally that live closeby.  //Dave
#Client#pause-5
A few? //Geriol
#Match#pause-5
Friends from my school days. We meet maybe once a month or so if we feel like it. //Dave
#Match#pause-5
They are similar to me who enjoy being alone at home, so we aren't that driven to do things. //Dave
#Client#pause-5
What stuff do you guys usually do then? //Geriol

#EnableFeedBack-5
#Match#pause-5
Eeh… Watch movies I guess? We don't really need to do much with each other. Just sitting on the sofa quietly is good enough. //Dave
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
      ->EndFamilyNeutral2->  
   - YES:
      ->EndFamilyYes2->
}
->->
= No1
//Neutral->No
#Client#pause-5
Sounds nice. I just sit inside a lot. //Geriol
#Match#pause-5
With your friends? //Dave
#Client#pause-5
Oh, well... Mostly by myself. I don't have that many friends around. But that's fine! //Geriol
#Match#pause-5
Whatever floats your boat I guess.//Dave

~changeMood(clientMood, -5)
~changeMood(matchMood, -5)

->->

// Knot for yes choice 1.
=== EndFamilyYes1 ===
//Yes
#Match#pause-5
 Of course not! Well they are pretty normal, I guess. I got a mom and dad and two brothers. //Dave
#Match#pause-5
Mom and dad live in the northern part of town. One brother lives around here and my other lives the next town over. We're all meeting up this weekend again. //Dave
#Client#pause-5
You meet each other a lot? //Geriol
#Match#pause-5
Every two weeks. My mom was always a lady for holding a family close so we see and talk to each other a lot. //Dave
#Client#pause-5
 That's so nice! Most people I've met are pretty distant with their families. //Geriol

#EnableFeedBack-5,5
#Match#pause-5,5
That's usually the norm, right? For me, my family is the closest bunch of people to me. How about you? What about your family? //Dave
~OverExcited = true
~changeMood(clientMood, 8)
~changeMood(matchMood, 8)

#DisableFeedBack
~getFeedBack()
{FeedBack:
   - NO:                                        
      ~OverExcited = false
      -> No1->                                             // Here, we told the client no in the second round. Here it also could go to a "no" option
                                                                // instead of going back to a new intro.
   - NEUTRAL:
      ->EndFamilyNeutral2->  
   - YES:
      ->EndFamilyYes2->
}
->->
= No1
//Yes->No
#Client#pause-5
Well we… You know we are pretty close also… //Geriol
#Match#pause-5
Don't want to talk about it? //Dave
#Client#pause-5
Maybe not today. Feels like one of those days where I just miss them a little extra. It's been a while since I saw them. //Geriol
#Match#pause-5
Eeh don't worry about it.  //Dave

~changeMood(clientMood, -10)
~changeMood(matchMood, -10)

->->

///// Start of choice 2

// Knot for neutral choice 2.
// Uses the OverExcited variable. This enables selective memory from previous events.
=== EndFamilyNeutral2 ===
#Client#pause-5
{
- OverExcited:
//Yes->Neutral
#Client#pause-5
Well I got five siblings and a mom and dad all living back home. //Geriol
#Match#pause-5
is it far? //Dave
#Client#pause-5
Really far. It's one of those river communities, if you know about it? //Geriol
#Match#pause-5
Some of it. They're pretty isolated from other places, no? //Dave
#Client#pause-5
A little so. We are all pretty tight with each other as we aren't that many so you could say I got a big extension of family.  //Geriol
#Match#pause-5
Good people? //Dave
#Client#pause-5
Sometimes they're a little too much. It's the kind of overbearing that is on the edge from ‘lovely' and ‘get away from me'. //Geriol
#Match#pause-5
Sounds healthy though. //Dave
#Client#pause-5
Love them all either way! //Geriol

                       // If overExicted is true
~changeMood(clientMood, 5)
~changeMood(matchMood, 5)

 - !OverExcited:
 //Neutral->Neutral
#Client#pause-5
 That sounds relaxing. //Geriol
#Match#pause-5
 It's very relaxing. Maybe too much since we've barely stayed awake during the whole movie. //Dave
#Client#pause-5
You can fall asleep to a movie? //Geriol
#Match#pause-5
You can't? //Dave
#Client#pause-5
I find that difficult. //Geriol
#Match#pause-5
Well, share some of that energy with the rest of us! We've tried re-watching a movie about five times but we always fall asleep. //Dave
#Client#pause-5
Sounds like you guys need some coffee. //Geriol
#Match#pause-5
 Tried that too… You should join us sometime and keep us awake. //Dave
#Client#pause-5
I-I don't know about that…  //Geriol
#Match#pause-5
You don't have to if you don't want to. But you are welcome to. Can't hurt. //Dave
 #Client#pause-5
I-I'll think about it.  //Geriol
#Match#pause-5
Sweet. //Dave
~OverExcited = false
~changeMood(clientMood, 5)
~changeMood(matchMood, 5)

}
->->

// Knot for yes choice 2.
=== EndFamilyYes2 === 
#Client#pause-5
{
- OverExcited: 
//Yes->Yes
#Client#pause-5
I guess I'm pretty much the same there, a mom and dad and five siblings. My mom works as a handyman and my dad as a fisherman. //Geriol
#Client#pause-5
With my siblings… I'm not sure what they are doing right now. They switch it up pretty often. //Geriol
#Match#pause-5
Sounds like a fun bunch. //Dave
#Client#pause-5
Yeah, though we also got a little bigger situation with the whole family thing. //Geriol
#Match#pause-5
How so? //Dave
#Client#pause-5
Well, I'm from one of the river communities, if you know about them? //Geriol
#Match#pause-5
Just a little. It's pretty isolated isn't it? //Dave
 #Client#pause-5
Not as much as people would think. But yeah, we mostly stay within them. We're also not that many, like a small village so everyone knows everyone. //Geriol
 #Client#pause-5
It's like having 50 sets of parents. And we celebrate everything together… //Geriol
#Match#pause-5
 But now? //Dave
 #Client#pause-5
 It's just me. I moved here to study, so it's been a while since I've been home. //Geriol
#Match#pause-5
 Is it far away? //Dave
#Client#pause-5
Very far and pretty expensive to get there. So I haven't been able to visit home these past two years. //Geriol
#Match#pause-5
That's pretty rough. I'm sure you'll be able to visit soon.  //Dave
 #Client#pause-5
Me too. But I'm okay so far. We still call and send letters with pictures in them. //Geriol

    	~changeMood(matchMood, 10)
    	~changeMood(clientMood, 10) 
        
- !OverExcited:
//Neutral->Yes
#Client#pause-5
Sounds like my kind of friends. //Geriol
#Match#pause-5
What do you do with your friends then? //Dave
#Client#pause-5
Oh… Well I don't have that many here in the city. Like… a half friend? //Geriol
#Match#pause-5
Half? //Dave
#Client#pause-5
You know, like say hello and how are you and such. //Geriol
#Match#pause-5
That's more an acquaintance. //Dave
 #Client#pause-5
Always called them half friends. Or, my mom usually calls them so. //Geriol
 #Client#pause-5
With those I got back home we usually just laze around or help people out with stuff. //Geriol
#Match#pause-5
Sounds better than just slowly dying into the sofa. //Dave
 #Client#pause-5
Wouldn't mind doin that just watching something. //Geriol
#Match#pause-5
Want to join us someday? //Dave
#Client#pause-5
Well I… I don't want to impose, really… It would be nice though. I have some movies in mind I would want to see with people. //Geriol
#Match#pause-5
Then it's probably fine! We've been out of luck finding new movies to watch so they would probably hail you for it. //Dave
#Client#pause-5
Well… Thanks for the offer. //Geriol

    	~changeMood(matchMood, 15)
    	~changeMood(clientMood, 13)
~OverExcited = false

}
->->
=== EndPlaces ===
#EnableFeedBack-5                                                     // Use this tag to tell unity to record player input. Can be a timer also.    
#Client#pause-5
What kind of places do you like to go to? //Geriol


#DisableFeedBack
~getFeedBack()
{FeedBack:
   - NO:
     #Client#pause-5
      Never mind, that might not be important. //Geriol
     ~changeMood(clientMood, -5)                               // Decrease client mood after we tell it that it should not talk about the weather.
     ~changeMood(matchMood, 5)                                 // Increase match mood, it doesn't like to talk about weather..
     -> pickEnd                                              // Here, we told the client no right away. Story could now lead to another intro
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
#Match#pause-5
Hmm… That's hard to say, really. //Dave
#Client#pause-5
Yeah, I don't really have much better to say of that either. I don't go around that much. //Geriol
#Match#pause-5
Well, I guess I sometimes go out just by myself. //Dave
#Client#pause-5
Out as in what? //Geriol
 #Match#pause-5
Just moving around places. Not to a bar or anything. Just going between shops and such. Though, I guess I've gone to places I wouldn't really expect myself going to. //Dave
#Client#pause-5
 Like what? //Geriol
 
#EnableFeedBack-5
#Match#pause-5
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
      ->EndPlacesNeutral2->  
   - YES:
      ->EndPlacesYes2->
}
->->
= No1
//Neutral->No
#Client#pause-5
Not the most exciting places. //Geriol
#Match#pause-5
Well maybe not in terms of action and suspense. But I don't know. I find something relaxing about just being in there. Hard to put my finger on it. //Dave
#Client#pause-5
Well I haven't been to many museums in my life, so it's hard to add anything to it. //Geriol
#Match#pause-5
Maybe that's not for you, then. //Dave

~changeMood(clientMood, -5)
~changeMood(matchMood, -10)

->->

// Knot for yes choice 1.
=== EndPlacesYes1 ===
//Yes
//Yes
#Match#pause-5
Hmm… That's hard to say, really. //Dave
#Client#pause-5
How come? //Geriol
#Match#pause-5
I usually only move between work and home, not many places in between. //Dave
#Client#pause-5
That's on work days, no? Aren't there any places you like to go to when you have the time? //Geriol
#EnableFeedBack-5,5
#Match#pause-5,5
Time, time, time… It just seems like I don't have time for much else but that. But I guess places I like to go and do stuff at are… Like… I don't know. A cake shop? //Dave
~OverExcited = true
~changeMood(clientMood, 10)
~changeMood(matchMood, 8)
#DisableFeedBack
~getFeedBack()
{FeedBack:
   - NO:                                        
      ~OverExcited = false
      -> No1->                                             // Here, we told the client no in the second round. Here it also could go to a "no" option
                                                                // instead of going back to a new intro.
   - NEUTRAL:
      ->EndPlacesNeutral2->  
   - YES:
      ->EndPlacesYes2->
}
->->
= No1
//Yes->No
//Yes->No
#Client#pause-5
 It's okay if you can't think of something. I'm no better. I just move between home and school and barely go to places also. //Geriol
#Match#pause-5
 Oh, alright. Thank you. //Dave
#Client#pause-5
 No problem. //Geriol

~changeMood(clientMood, -5)
~changeMood(matchMood, -5)

->->

///// Start of choice 2

// Knot for neutral choice 2.
// Uses the OverExcited variable. This enables selective memory from previous events.
=== EndPlacesNeutral2 ===
#Client#pause-5
{
- OverExcited:
//Yes->Neutral
#Client#pause-5
 What kind of cake shop? //Geriol
#Match#pause-5
 Eeh… I kind of drift between different types. But I've been to one more than other recently. //Dave
#Client#pause-5
 Which one? //Geriol
#Match#pause-5
 Do you know “Refine Coffeé Taste”? //Dave
#Client#pause-5
 Not really. //Geriol
 #Match#pause-5
 As the name suggests they have a strong focus on the coffée side and cakes and such that goes well with their brands. //Dave
#Match#pause-5
And I'm a pretty avid coffée drinker so It's nice to get something from there. //Dave
#Client#pause-5
 Does it really taste that distinct? //Geriol
 #Match#pause-5
 Well I'm not a coffée taster or anything, but it's definitely better than my homemade coffee. If only the prices weren't as high as they are. //Dave
#Client#pause-5
 Everything is going up, I guess. //Geriol
#Match#pause-5
 Yeah, they are. But anyway, the cakes they sell usually work best with their brand. I've tried taking some of it home and it just wasn't the same. //Dave
#Client#pause-5
 Hmm… I'm not really a coffée person, but it does sound intriguing to check out at least. //Geriol
#Match#pause-5
 You don't have to force yourself just because of me. //Dave
#Client#pause-5
  I-I'm not! You are just a good and honest commercial… guy for them. //Geriol
#Match#pause-5
 Haha. Well thanks I guess. //Dave

                   	// If overExicted is true
~changeMood(clientMood, 4)
~changeMood(matchMood, 4)


 - !OverExcited:
 //Neutral->Neutral
#Client#pause-5
Well that sounds a little special. I haven't met a lot of people who like to go to those places. //Geriol
#Match#pause-5
Probably because a lot of them had to go to those places while in school. The time where learning stuff was uncool and reading was a snore. //Dave
#Match#pause-5
I hope at least I'm not like that anymore. Though I just usually wander around inside and read bite sizes of information. //Dave
#Client#pause-5
Then why go there? Doesn't it cost a lot of money going to those places? //Geriol
#Match#pause-5
Hehe. I go to those communal ones that are for free. //Dave
#Client#pause-5
Smart. //Geriol
#Match#pause-5
Very, if I may say so myself. But what about you? //Dave
#Client#pause-5
Me? Hmm… I guess maybe going to secondhand stores? //Geriol
#Match#pause-5
Secondhand? //Dave
#Client#pause-5
Yeah. I usually don't buy stuff there, but I like to just see what people got rid of and such. //Geriol
#Match#pause-5
A kind of window shopping? //Dave
#Client#pause-5
I guess so. //Geriol
 #Match#pause-5
You know what? We both like to do things on a budget. //Dave
#Client#pause-5
Hehe, Sounds like it. //Geriol
 #Match#pause-5
 Might as well if it's nice. Like, just hanging in the park doing nothing in particular. //Dave
#Client#pause-5
It's been nice. //Geriol
#Match#pause-5
Indeed. //Dave
 
~OverExcited = false
~changeMood(clientMood, 5)
~changeMood(matchMood, 5)


}
->->

// Knot for yes choice 2.
=== EndPlacesYes2 === 
#Client#pause-5
{
- OverExcited: 
//Yes->Yes
#Client#pause-5
Really? //Geriol
#Match#pause-5
I don't know. I guess I don't really remember places I've been to that I can't feel joy from that isn't my own place. //Dave
#Client#pause-5
 Well, you'd never had any places you went to and did stuff at when you were younger? //Geriol
#Match#pause-5
 You mean like my school years? //Dave
#Client#pause-5
Yeah. Feels like a person did a lot more of different stuff then before becoming an adult and just… live in routine. Maybe you went somewhere that really made an impact on you?//Geriol
 #Match#pause-5
 Well, me and my friends usually just stayed inside and watched movies or played games… But we did something once that was really fun and fantastic once: Mountain camping. //Dave
#Client#pause-5
 Woah, really? //Geriol
#Match#pause-5
  Yeah. One of my two friends said “Hey, lets just go to a mountain and sleep there”. //Dave
#Match#pause-5
And after a few weeks of planning and getting the gear we headed off with a bus. //Dave
#Match#pause-5
It took us five hours by bus and this felt like the most difficult part of it all. The weather wasn't the best either. //Dave
#Client#pause-5
Rain? //Geriol
#Match#pause-5
 Some, but not enough to make us stop. When we arrived we were pumped to go climbing, finally! But only like an hour in… //Dave
#Match#pause-5
My knees were hurting, the rain made the road all muddy, and we packed way too much so we all were pretty exhausted and annoyed when we arrived at the top. //Dave
#Client#pause-5
Did it feel worth it?  //Geriol
#Match#pause-5
 Yeah… The sunset was amazing. So far from the world… It had so many colours. I've never seen something like that before or since. //Dave
#Client#pause-5
 It sounds like a very painful experience though. //Geriol
#Match#pause-5
 But one with a big reward. So yeah, I guess mountains would be a place I like to go to more often. But until then it's cake shops for me. Sorry, I took up the whole conversation there. //Dave
#Client#pause-5
  No, it's fine! It's a very cool thing to hear. //Geriol


    	~changeMood(matchMood, 20)
    	~changeMood(clientMood, 18)

        
- !OverExcited:
//Neutral->Yes
#Client#pause-5
What kind of history museum? //Geriol
#Match#pause-5
It doesn't really matter which one. I've been to several places focusing on different things. //Dave
#Client#pause-5
Have you been to the modern history museum? I've heard it's pretty engrossing. //Geriol
#Match#pause-5
Not a fan of modern museums that much really. It's all so close to now and that stuff just happened, so it feels like it will change in just a year or people would be biased towards it. //Dave
#Client#pause-5
Thinking about the moon and the conflict? //Geriol
#Match#pause-5
Mostly. But I'm not really a fan of discussing takes on that. It was heard enough to bicker about it growing up and no one has changed their mind about it. //Dave
#Client#pause-5
I'm not into that subject either, which is for the best.  //Geriol
 #Match#pause-5
That's a relief...  But no, usually it's just something about being around really, really old stuff displayed that makes me intrigued about museums. //Dave
#Match#pause-5
Everything gathered in a big place where a lot of people go to learn about them. //Dave
#Client#pause-5
Good enough reasoning for liking something. For me, I guess I like to be around rivers and such mostly because it reminds me of home a lot. //Geriol
 #Match#pause-5
Well that's good enough as any. You don't need to pour out pages after pages of reasoning for things sometimes. //Dave
#Client#pause-5
 I guess. Just wished I had something more interesting like yours. //Geriol
 #Match#pause-5
You probably have but don't really think about it. I didn't before you started asking questions. //Dave
#Client#pause-5
I see. Good then! Hehe. //Geriol


    	~changeMood(matchMood, 15)
    	~changeMood(clientMood, 15)

~OverExcited = false
}
->->
=== EndMemory ===
#EnableFeedBack-5                                                     // Use this tag to tell unity to record player input. Can be a timer also.    
#Client#pause-5
Do you have a favourite memory?//Geriol

#DisableFeedBack
~getFeedBack()
{FeedBack:
   - NO:
     #Client#pause-5
      Never mind, that might not be important. //Geriol
     ~changeMood(clientMood, -5)                               // Decrease client mood after we tell it that it should not talk about the weather.
     ~changeMood(matchMood, 5)                                 // Increase match mood, it doesn't like to talk about weather..
     -> pickEnd                                             // Here, we told the client no right away. Story could now lead to another intro
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
#Match#pause-5
Favourite memory? //Dave
#Client#pause-5
If that sounds weird to ask then it's okay. I was just wondering… //Geriol
#Match#pause-5
No, it's okay. Uhm… What's your favourite memory first, then? //Dave
#Client#pause-5
Oh, mine is… probably when I went up to the surface for the first time. I lived under water mostly when I was a young kid and didn't come up until much later. //Geriol
#Client#pause-5
Seeing the stars clearly… Seeing the people… Seeing what they could do up here. It made me want to join them, in a way? //Geriol
 #Match#pause-5
Is that why you moved here? //Dave
#Client#pause-5
Could be one reason. But also so I could study computers. //Geriol
#Client#pause-5
It's more beautiful up here than down there. It got its moments, but seeing the surface for the first time made me really, really happy. //Geriol
#Client#pause-5
I'd never seen a fire before. Almost burned myself on it. It was a cool sensation. //Geriol

#EnableFeedBack-5
#Match#pause-5
Haha, I can imagine. //Dave
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
      ->EndMemoryNeutral2->  
   - YES:
      ->EndMemoryYes2->
}
->->
= No1
//Neutral->No
#Client#pause-5
Surface for you must just be pretty normal and boring… //Geriol
#Match#pause-5
It's not bad to have that as a favourite memory! It was something new for you. I'd be the same if I could be underwater like you. //Dave
#Client#pause-5
 Heh, thanks! //Geriol

~changeMood(clientMood, -5)
~changeMood(matchMood, -5)

->->

// Knot for yes choice 1.
=== EndMemoryYes1 ===
//Yes
#Match#pause-5
A favourite memory? //Dave
#Client#pause-5
Yeah. Or something that stuck with you that's… positive? //Geriol
#Match#pause-5
Hmm, difficult question… I'd say… When I saw my first robot. //Dave
#Client#pause-5
In what way and where? //Geriol
#Match#pause-5
Don't remember the place, funny enough, only the robot. It gave me a lot of inspiration. It was so cool. 
#Match#pause-5
It just moved by itself and at the time I could just not figure out how! So I tried to understand it, and here I am.  //Dave
#Match#pause-5
I wanted to make something like that and make people go woah to my stuff. Might not be the most awe or exciting memory though, guess I got a pretty boring life for the most part. //Dave
#Client#pause-5
It sounds great to me. There's nothing wrong with being inspired. And robots are super super cool, as established. //Geriol
#Match#pause-5
Heh, thank you. I.. want to make my own proper robot one day. Something that could help people. Or atleast make someone go ”wow”... //Dave
#Client#pause-5
I'm sure you'll be able to make it one day. //Geriol

#EnableFeedBack-5
#Match#pause-5
 What about you? //Dave
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
      ->EndMemoryNeutral2->  
   - YES:
      ->EndMemoryYes2->
}
->->
= No1
//Yes->No
#Client#pause-5
Ah, no, I don't think mine is as… interesting as yours. I wouldn't want to bore you. //Geriol
#Match#pause-5
Quit being so modest! I'm sure it's not as bad as you think. //Dave
#Client#pause-5
Maybe… Maybe another day. //Geriol
#Match#pause-5
Hmm… Fine. //Dave

~changeMood(clientMood, -7)
~changeMood(matchMood, -10)

->->

///// Start of choice 2

// Knot for neutral choice 2.
// Uses the OverExcited variable. This enables selective memory from previous events.
=== EndMemoryNeutral2 ===
#Client#pause-5
{
- OverExcited:
//Yes->Neutral
Well… Mine isn't as grand or interesting as yours. //Geriol
#Match#pause-5
Come on, indulge me. I shared mine. //Dave
#Client#pause-5
Okay… Mine would be the first time I got to sit with a computer, I guess? Kinda the same as you? That it inspired me to find something I liked to do? //Geriol
#Match#pause-5
How's that not interesting or a good favourite memory? //Dave
#Client#pause-5
I didn't want to make it seem like I was copying you with something similar. //Geriol
#Match#pause-5
But it's your memory, right? So… can't be copyright on that. //Dave
#Client#pause-5
True I guess… Uhm, but I was at a museum where we got to sit with a computer and I got to imagine what it could do. //Geriol
#Client#pause-5
So I just started and kept thinking about it all. And I kinda wanted to see if I could make it possible? //Geriol
#Match#pause-5
That's cool! It's those kinds of memories that define us a little, I think. //Dave


                   	// If overExicted is true
~changeMood(clientMood, 8)
~changeMood(matchMood, 8)


 - !OverExcited:
 //Neutral->Neutral
#Client#pause-5
So… Feel any of that inspiration to share something now? //Geriol
#Match#pause-5
Oh, yeah. Mine must be… When I first made a robot that could move. //Dave
#Client#pause-5
I can imagine the satisfaction!  // Geriol
#Match#pause-5
Well, It's a small thing but with a big meaning. It wasn't difficult to make it actually move, just more making it move delicately and correctly. 
#Match#pause-5
When it moved like I wanted it to, at least for a short while… Wow. //Dave
#Match#pause-5
My dream of making a robot that could help or wow others got a little closer. So making a robot, my robot, move… //Dave
#Match#pause-5
It made me realize my dream is closer than others have said. That my effort isn't just me being a “nerd”. //Dave
 #Client#pause-5
People called me a nerd too, but I don't think it's a bad thing! They say that because they don't understand what we do or what we like. //Geriol
 #Client#pause-5
It just means we're just ready to… work harder and smarter! Right? // Geriol
#Match#pause-5
You're right… We could see it like that. //Dave
 #Client#pause-5
 We nerds gotta stick together, right? // Geriol
#Match#pause-5
 Hehe, right. //Dave
 

~OverExcited = false
~changeMood(clientMood, 10)
~changeMood(matchMood, 10)


}
->->

// Knot for yes choice 2.
=== EndMemoryYes2 === 
#Client#pause-5
{
- OverExcited: 
 //Yes->Yes
#Client#pause-5
Hmm, my favourite memory… It's hard to choose one. Probably the first time I saw the surface… And the first time I sat with a computer. //Geriol
#Match#pause-5
Tell both? I wanna hear how they are the favorites. //Dave
#Client#pause-5
Well… Seeing the surface, I found it really beautiful. I really liked seeing the stars. And it was the first time I saw and burned myself on fire too! Fire underwater isn't really an option, so. //Geriol
#Match#pause-5
I always wondered if there was any alternative for that underwater…  //Dave
#Client#pause-5
Not really, we don't have any man-made heat sources other than magic down there. //Geriol
#Client#pause-5
But the second one with the computer, I mostly encountered computers when I went to museums with my class. //Geriol
#Client#pause-5
We got to use some and I just... It had so many possibilities that my mind kind of melted! And I wanted to make those possibilities real, you know? //Geriol
#Match#pause-5
Not too different from me and robots. Both of those are really good favourite memories. //Dave
 #Client#pause-5
Hehe, thanks. //Geriol

    	~changeMood(matchMood, 20)
    	~changeMood(clientMood, 20)

        
- !OverExcited:
//Neutral->Yes
#Client#pause-5
So I told you about mine, what about you?//Geriol
#Match#pause-5
Hmm… Mine would probably be when I saw my first ever robot. //Dave
#Client#pause-5
How come? //Geriol
#Match#pause-5
Seeing it made me realize what I wanted to do. A piece of metal and wires that could move on its own was really cool. //Dave
#Match#pause-5
And I wanted to make something like that. Might be a little weird to anyone else, but that dream has stuck with me since despite it. //Dave
#Client#pause-5
I don't think it's weird! It's really, really cool! Building your own robot has to be a lot of work. And it's never wrong to feel inspired! //Geriol
#Client#pause-5
It's good to have a favourite memory that inspired your dream. Mine sounds lame in comparison now… //Geriol
#Match#pause-5
 No, it's not lame to want to go somewhere new and wondrous. I'd be the same if I saw something similar. It's a good favourite memory. //Dave
#Client#pause-5
Thanks. //Geriol

    	~changeMood(matchMood, 10)
    	~changeMood(clientMood, 10)

~OverExcited = false
}

-> END