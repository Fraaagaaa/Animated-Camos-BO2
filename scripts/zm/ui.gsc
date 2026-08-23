#include maps\mp\_utility;
#include common_scripts\utility;

init()
{
    level thread refreshRound();
}

refreshRound()
{
    level endon( "end_game" );
    
    while(true)
    {
        SetDvar( "ui_zm_round", level.round_number );
        level waittill("end_of_round");
    }
}