#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes_zm\_hud_util;
#include maps\mp\gametypes_zm\_weapons;
#include maps\mp\zombies\_zm_weapons;
#include maps\mp\zm_buried;

#include scripts\zm\_zm_camo_override;

init()
{
	replaceFunc(getfunction("maps/mp/zm_buried", "player_give_lsat"), ::player_give_lsat);
}

player_give_lsat()
{
    level notify( "lsat_purchased" );

    if ( !( isdefined( level.catwalk_collapsed ) && level.catwalk_collapsed ) )
    {
        self maps\mp\zombies\_zm_stats::increment_client_stat( "buried_lsat_purchased", 0 );
        self maps\mp\zombies\_zm_stats::increment_player_stat( "buried_lsat_purchased" );
        level.lsat_purchased = 1;
    }

    self thread achievement_watcher_lsat_upgrade();

    self giveweapon("lsat_zm", 0, self get_pack_a_punch_weapon_options("lsat_zm"));
    maps\mp\zombies\_zm_weapons::acquire_weapon_toggle( "lsat_zm", self );
    self givestartammo( "lsat_zm" );
    self switchtoweapon( "lsat_zm" );
}

achievement_watcher_lsat_upgrade()
{
    level endon( "end_game" );
    self endon( "disconnect" );

    do
        self waittill( "pap_taken" );
    while (!self maps\mp\zombies\_zm_weapons::has_weapon_or_attachments( "lsat_upgraded_zm" ) );

    self notify( "player_upgraded_lsat_from_wall" );
}