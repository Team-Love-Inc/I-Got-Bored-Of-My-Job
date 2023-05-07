VAR clientMood = 50
VAR matchMood = 50

LIST ExampleState = ONE, TWO, THREE, FOUR

-> start


=== function setMood(ref mood, value) ===
~ temp newValue = mood + value 
{
 - newValue < 0:
    ~mood = 0
 - newValue > 100:
    ~mood = 100
 - else:
    ~mood = newValue
}


=== function AbilityPressed(ability) ===
{ability:
 - 0:
    {ExampleState:
     - ONE:
        ~setMood(clientMood, 10)
        ~setMood(matchMood, -10)
     - TWO:
        ~setMood(clientMood, -20)
     - THREE:
        ~setMood(matchMood, -20)
     - FOUR:
        ~setMood(clientMood, -10)
        ~setMood(matchMood, 20)
    }
 - 1:
    {ExampleState:
     - ONE:
        ~setMood(clientMood, 30)
        ~setMood(matchMood, 50)
     - TWO:
        ~setMood(clientMood, -30)
        ~setMood(matchMood, 10)
     - THREE:
        ~setMood(matchMood, -30)
     - FOUR:
        ~setMood(clientMood, -10)
    }
}

=== start ===
The date is ready

* [Start] -> Date

=== Date ===
~ExampleState = ONE
#Narrator#pause-2,5
The couple sits down in front of a table.
#Client#pause-2,5
Oh you look good tonight
{ 
 - matchMood >= 0.5:
    ~ExampleState = THREE
    #Match#pause-2,5
    aw that is cute of you
    {
     - clientMood < 0.5:
        ~ExampleState = FOUR
        #Client#pause-2,5
        aren't you going to compliment me?
        -> ClientAngry ->
        
     - else:
        #Client#pause-2,5
        :oo so you are saying im cute
    }
- else:
    ~ExampleState = TWO
    #Match#pause-2,5
    so im usually ugly?
    -> MatchAngry1 ->
    ~ExampleState = ONE
}
~ExampleState = TWO
#Narrator#pause-2,5
The client {
    - clientMood >= 0.5:
        <> looks comfortable
    - else: 
        <> looks uncomfortable
} 
<> and the match {
    - matchMood >= 0.5:
        <> looks comfortable
    - else:
        <> looks uncomfortable
} <>.
~ExampleState = THREE
-> END

=== MatchAngry1 ===
#Narrator#pause-2,5
The match looks annoyed.
{ clientMood < 0.5:
    ~ExampleState = THREE
    #Client#pause-2,5
    ey, why you so rude?
    -> BothLeaveInAnger
-else:
    #Client#pause-2,5
    No im just saying you look cute.
    { 
    -matchMood <= 0.2:
        ~ExampleState = ONE
        #Match#pause-2,5
        leave me alone
        ~ExampleState = THREE
        -> MatchLeavesInAnger
    - matchMood <= 0.5:
        #Match#pause-2,5
        ok thanks
        ->->
    -else:
        #Match#pause-2,5
        aw thank you
        ~ExampleState = FOUR
        ->->
    }
}

=== ClientAngry ===
~ExampleState = FOUR
#Narrator#pause-2,5
The client looks annoyed.
{ 
- matchMood < 0.5:
    ~ExampleState = ONE
    #Match#pause-2,5
    wtf that is not how you speak to people
    -> BothLeaveInAnger
-else:
     ~ExampleState = TWO
    #Match#pause-2,5
    yea you're pretty cute.
    { 
    -clientMood <= 0.2:    
        #Client#pause-2,5
        stop lying
        -> ClientLeavesInAnger
    - clientMood <= 0.5:
        ~ExampleState = ONE
        #Client#pause-2,5
        ok thanks
        ~ExampleState = FOUR
        ->->
    -else:
        ~ExampleState = THREE
        #Clienth#pause-2,5
        aw thank you
        ->->
    }
}
->->

=== BothLeaveInAnger ===
#Narrator#pause-2,5
They both stand up and leave.
->END

=== MatchLeavesInAnger===
#Narrator#pause-2,5
Match stands up and leaves.
->END

=== ClientLeavesInAnger===
#Narrator#pause-2,5
Client stands up and leaves.
->END

