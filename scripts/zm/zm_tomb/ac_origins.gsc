#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes_zm\_hud_util;
#include maps\mp\gametypes_zm\_weapons;
#include maps\mp\zm_tomb_main_quest;
#include maps\mp\zm_tomb_utility;
#include maps\mp\zombies\_zm_craftables;
#include maps\mp\zombies\_zm_utility;
#include maps\mp\zombies\_zm_weapons;
init()
{
	replaceFunc(getfunction("maps/mp/zm_tomb_main_quest", "watch_for_player_pickup_staff"), ::watch_for_player_pickup_staff);
}

watch_for_player_pickup_staff()
{
    staff_picked_up = 0;
    pickup_message = self staff_get_pickup_message();
    self.trigger set_unitrigger_hint_string( pickup_message );
    self show();
    self.trigger trigger_on();

    while ( !staff_picked_up )
    {
        self.trigger waittill( "trigger", player );
        self notify( "retrieved", player );

        if ( player can_pickup_staff() )
        {
            weapon_drop = player getcurrentweapon();
            a_weapons = player getweaponslistprimaries();
            n_max_other_weapons = get_player_weapon_limit( player ) - 1;

            if ( a_weapons.size > n_max_other_weapons || issubstr( weapon_drop, "staff" ) )
                player takeweapon( weapon_drop );

            player thread watch_staff_ammo_reload();
            self ghost();
            self setinvisibletoall();

            player weapon_give(self.weapname);
            // player giveweapon( self.weapname, undefined, undefined); //, 0, self get_pack_a_punch_weapon_options( self.weapname ) );
            player switchtoweapon( self.weapname );
            clip_size = weaponclipsize( self.weapname );
            player setweaponammoclip( self.weapname, clip_size );
            self.owner = player;
            level notify( "stop_staff_sound" );
            self notify( "staff_equip" );
            staff_picked_up = 1;
            self.charger.is_inserted = 0;
            self setclientfield( "staff_charger", 0 );
            self.charger.full = 1;
            maps\mp\zm_tomb_craftables::set_player_staff( self.weapname, player );
        }
    }
}