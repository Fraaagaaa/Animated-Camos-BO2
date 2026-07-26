#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\zombies\_zm_utility;
#include maps\mp\zombies\_zm_weapons;
#include maps\mp\gametypes_zm\_weapons;

init()
{
	replaceFunc(getfunction("maps/mp/zombies/_zm_weapons", "get_pack_a_punch_weapon_options"), ::get_pack_a_punch_weapon_options);
	replaceFunc(getfunction("maps/mp/zombies/_zm_weapons", "weapon_give"), ::weapon_give);
	replaceFunc(getfunction("maps/mp/zombies/_zm_utility", "give_start_weapon"), ::give_start_weapon);
}

get_pack_a_punch_weapon_options( weapon )
{
    if ( !isdefined( self.pack_a_punch_weapon_options ) )
        self.pack_a_punch_weapon_options = [];

    smiley_face_reticle_index = 1;
    base = get_base_name( weapon );

    camo_index = get_camo_based_on_weapon(weapon);

    lens_index = randomintrange( 0, 6 );
    reticle_index = randomintrange( 0, 16 );
    reticle_color_index = randomintrange( 0, 6 );
    plain_reticle_index = 16;
    r = randomint( 10 );
    use_plain = r < 3;

    if ( "saritch_upgraded_zm" == base )
        reticle_index = smiley_face_reticle_index;
    else if ( use_plain )
        reticle_index = plain_reticle_index;

    scary_eyes_reticle_index = 8;
    purple_reticle_color_index = 3;

    if ( reticle_index == scary_eyes_reticle_index )
        reticle_color_index = purple_reticle_color_index;

    letter_a_reticle_index = 2;
    pink_reticle_color_index = 6;

    if ( reticle_index == letter_a_reticle_index )
        reticle_color_index = pink_reticle_color_index;

    letter_e_reticle_index = 7;
    green_reticle_color_index = 1;

    if ( reticle_index == letter_e_reticle_index )
        reticle_color_index = green_reticle_color_index;

    self.pack_a_punch_weapon_options[weapon] = self calcweaponoptions( camo_index, lens_index, reticle_index, reticle_color_index );
    return self.pack_a_punch_weapon_options[weapon];
}

get_camo_based_on_weapon(weapon)
{
    // Add here the new weapons
    if(IsSubStr(weapon, "an94"))
        return 39;
    else if(IsSubStr(weapon, "m14"))
        return 40;
    else if(IsSubStr(weapon, "m1911"))
        return 41;
    else if(IsSubStr(weapon, "staff"))
        return 42;
    else if(IsSubStr(weapon, "mp40"))
        return 43;
    else if(IsSubStr(weapon, "raygun"))
        return 44;
    else if(IsSubStr(weapon, "mc96"))
        return 45;



    if ( "zm_prison" == level.script )
        return 40;
    else if ( "zm_tomb" == level.script )
        return 45;
    return 39;
}

weapon_give( weapon, is_upgrade, magic_box, nosound )
{
    primaryweapons = self getweaponslistprimaries();
    current_weapon = self getcurrentweapon();
    current_weapon = self maps\mp\zombies\_zm_weapons::switch_from_alt_weapon( current_weapon );
    assert( self player_can_use_content( weapon ) );

    if ( !isdefined( is_upgrade ) )
        is_upgrade = 0;

    weapon_limit = get_player_weapon_limit( self );

    if ( is_equipment( weapon ) )
        self maps\mp\zombies\_zm_equipment::equipment_give( weapon );

    if ( weapon == "riotshield_zm" )
    {
        if ( isdefined( self.player_shield_reset_health ) )
            self [[ self.player_shield_reset_health ]]();
    }

    if ( self hasweapon( weapon ) )
    {
        if ( issubstr( weapon, "knife_ballistic_" ) )
            self notify( "zmb_lost_knife" );

        self givestartammo( weapon );

        if ( !is_offhand_weapon( weapon ) )
            self switchtoweapon( weapon );

        return;
    }

    if ( is_melee_weapon( weapon ) )
        current_weapon = maps\mp\zombies\_zm_melee_weapon::change_melee_weapon( weapon, current_weapon );
    else if ( is_lethal_grenade( weapon ) )
    {
        old_lethal = self get_player_lethal_grenade();

        if ( isdefined( old_lethal ) && old_lethal != "" )
        {
            self takeweapon( old_lethal );
            unacquire_weapon_toggle( old_lethal );
        }

        self set_player_lethal_grenade( weapon );
    }
    else if ( is_tactical_grenade( weapon ) )
    {
        old_tactical = self get_player_tactical_grenade();

        if ( isdefined( old_tactical ) && old_tactical != "" )
        {
            self takeweapon( old_tactical );
            unacquire_weapon_toggle( old_tactical );
        }

        self set_player_tactical_grenade( weapon );
    }
    else if ( is_placeable_mine( weapon ) )
    {
        old_mine = self get_player_placeable_mine();

        if ( isdefined( old_mine ) )
        {
            self takeweapon( old_mine );
            unacquire_weapon_toggle( old_mine );
        }

        self set_player_placeable_mine( weapon );
    }

    if ( !is_offhand_weapon( weapon ) )
        self maps\mp\zombies\_zm_weapons::take_fallback_weapon();

    if ( primaryweapons.size >= weapon_limit )
    {
        if ( is_placeable_mine( current_weapon ) || is_equipment( current_weapon ) )
            current_weapon = undefined;

        if ( isdefined( current_weapon ) )
        {
            if ( !is_offhand_weapon( weapon ) )
            {
                if ( current_weapon == "tesla_gun_zm" )
                    level.player_drops_tesla_gun = 1;

                if ( issubstr( current_weapon, "knife_ballistic_" ) )
                    self notify( "zmb_lost_knife" );

                self takeweapon( current_weapon );
                unacquire_weapon_toggle( current_weapon );
            }
        }
    }

    if ( isdefined( level.zombiemode_offhand_weapon_give_override ) )
    {
        if ( self [[ level.zombiemode_offhand_weapon_give_override ]]( weapon ) )
            return;
    }

    if ( weapon == "cymbal_monkey_zm" )
    {
        self maps\mp\zombies\_zm_weap_cymbal_monkey::player_give_cymbal_monkey();
        self play_weapon_vo( weapon, magic_box );
        return;
    }
    else if ( issubstr( weapon, "knife_ballistic_" ) )
        weapon = self maps\mp\zombies\_zm_melee_weapon::give_ballistic_knife( weapon, issubstr( weapon, "upgraded" ) );
    else if ( weapon == "claymore_zm" )
    {
        self thread maps\mp\zombies\_zm_weap_claymore::claymore_setup();
        self play_weapon_vo( weapon, magic_box );
        return;
    }

    if ( isdefined( level.zombie_weapons_callbacks ) && isdefined( level.zombie_weapons_callbacks[weapon] ) )
    {
        self thread [[ level.zombie_weapons_callbacks[weapon] ]]();
        play_weapon_vo( weapon, magic_box );
        return;
    }

    if ( !( isdefined( nosound ) && nosound ) )
        self play_sound_on_ent( "purchase" );

    if ( weapon == "ray_gun_zm" )
        playsoundatposition( "mus_raygun_stinger", ( 0, 0, 0 ) );

    self giveweapon( weapon, 0, self get_pack_a_punch_weapon_options( weapon ) );

    acquire_weapon_toggle( weapon, self );
    self givestartammo( weapon );

    if ( !is_offhand_weapon( weapon ) )
    {
        if ( !is_melee_weapon( weapon ) )
            self switchtoweapon( weapon );
        else
            self switchtoweapon( current_weapon );
    }

    self play_weapon_vo( weapon, magic_box );
}

give_start_weapon( switch_to_weapon )
{
    self giveweapon( level.start_weapon, 0, self get_pack_a_punch_weapon_options( level.start_weapon ) );
    self givestartammo( level.start_weapon );

    if ( isdefined( switch_to_weapon ) && switch_to_weapon )
        self switchtoweapon( level.start_weapon );
}