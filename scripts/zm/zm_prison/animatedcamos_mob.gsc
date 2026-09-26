#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes_zm\_hud_util;
#include maps\mp\gametypes_zm\_weapons;
#include maps\mp\zombies\_zm_weapons;
#include maps\mp\zombies\_zm_utility;
#include maps\mp\zm_alcatraz_utility;

init()
{
	replaceFunc(getfunction("maps/mp/zm_prison_sq_bg", "take_old_weapon_and_give_reward"), ::take_old_weapon_and_give_reward);
}

take_old_weapon_and_give_reward( current_weapon, reward_weapon, weapon_limit_override )
{
    if ( !isdefined( weapon_limit_override ) )
        weapon_limit_override = 0;

    if ( weapon_limit_override == 1 )
        self takeweapon( current_weapon );
    else
    {
        primaries = self getweaponslistprimaries();

        if ( isdefined( primaries ) && primaries.size >= 2 )
            self takeweapon( current_weapon );
    }

    self weapon_give( reward_weapon );
    self switchtoweapon( reward_weapon );
    flag_set( "warden_blundergat_obtained" );
    self playsoundtoplayer( "vox_brutus_easter_egg_872_0", self );
}

wait_for_player_to_take( player, str_valid_weapon )
{
    self endon( "acid_timeout" );
    player endon( "disconnect" );

    while ( true )
    {
        self waittill( "trigger", trigger_player );

        if ( isdefined( level.custom_craftable_validation ) )
        {
            valid = self [[ level.custom_craftable_validation ]]( player );

            if ( !valid )
                continue;
        }

        if ( trigger_player == player )
        {
            current_weapon = player getcurrentweapon();

            if ( is_player_valid( player ) && !( player.is_drinking > 0 ) && !is_placeable_mine( current_weapon ) && !is_equipment( current_weapon ) && level.revive_tool != current_weapon && "none" != current_weapon && !player hacker_active() )
            {
                self notify( "acid_taken" );
                player notify( "acid_taken" );
                weapon_limit = 2;
                primaries = player getweaponslistprimaries();

                if ( isdefined( primaries ) && primaries.size >= weapon_limit )
                    player takeweapon( current_weapon );

                str_new_weapon = undefined;

                if ( str_valid_weapon == "blundergat_zm" )
                    str_new_weapon = "blundersplat_zm";
                else
                    str_new_weapon = "blundersplat_upgraded_zm";

                if ( player hasweapon( "blundersplat_zm" ) )
                    player givemaxammo( "blundersplat_zm" );
                else if ( player hasweapon( "blundersplat_upgraded_zm" ) )
                    player givemaxammo( "blundersplat_upgraded_zm" );
                else
                {
                    player weapon_give( str_new_weapon );
                    player switchtoweapon( str_new_weapon );
                }

                player thread do_player_general_vox( "general", "player_recieves_blundersplat" );
                player notify( "player_obtained_acidgat" );
                player thread player_lost_blundersplat_watcher();
                return;
            }
        }
    }
}