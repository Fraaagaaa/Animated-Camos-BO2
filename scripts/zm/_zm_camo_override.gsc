#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\zombies\_zm_utility;
#include maps\mp\zombies\_zm_weapons;

init()
{
    getplayers()[0] IPrintLn("Animated Camos Loaded!");
	replaceFunc(getfunction("maps/mp/zombies/_zm_weapons", "get_pack_a_punch_weapon_options"), ::get_pack_a_punch_weapon_options);
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

    self iprintln("w: " + weapon + " | index: " + camo_index);
    self.pack_a_punch_weapon_options[weapon] = self calcweaponoptions( camo_index, lens_index, reticle_index, reticle_color_index );
    return self.pack_a_punch_weapon_options[weapon];
}

get_camo_based_on_weapon(weapon)
{
    if(IsSubStr(weapon, "an94"))
        return 39;
    else if(IsSubStr(weapon, "m14"))
        return 40;
    else if(IsSubStr(weapon, "m1911"))
        return 41;



    if ( "zm_prison" == level.script )
        return 40;
    else if ( "zm_tomb" == level.script )
        return 45;
    return 39;
}
