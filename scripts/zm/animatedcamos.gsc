#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes_zm\_hud_util;
#include maps\mp\gametypes_zm\_weapons;
#include maps\mp\zm_tomb_main_quest;
#include maps\mp\zm_tomb_utility;
#include maps\mp\zombies\_zm_craftables;
#include maps\mp\zombies\_zm_utility;
#include maps\mp\zombies\_zm_weapons;

#include maps\mp\zombies\_zm_laststand;
#include maps\mp\zombies\_zm;
#include maps\mp\gametypes_zm\_weaponobjects;
#include maps\mp\gametypes_zm\_gameobjects;

init()
{
    level.animated_camos = true;
    level.custom_camos = true;
	replaceFunc(getfunction("maps/mp/zombies/_zm_weapons", "get_pack_a_punch_weapon_options"), ::get_pack_a_punch_weapon_options);
	replaceFunc(getfunction("maps/mp/zombies/_zm_weapons", "weapon_give"), ::weapon_give);
	replaceFunc(getfunction("maps/mp/zombies/_zm_utility", "give_start_weapon"), ::give_start_weapon);
	replaceFunc(getfunction("maps/mp/zombies/_zm_laststand", "laststand_give_pistol"), ::laststand_give_pistol);
	replaceFunc(getfunction("maps/mp/zombies/_zm_laststand", "suicide_trigger_think"), ::suicide_trigger_think);


	replaceFunc(getfunction("maps/mp/zombies/_zm_tombstone", "restore_weapon_for_tombstone"), ::restore_weapon_for_tombstone);
	replaceFunc(getfunction("maps/mp/zombies/_zm_perks", "upgrade_knuckle_crack_begin"), ::upgrade_knuckle_crack_begin);
	replaceFunc(getfunction("maps/mp/zombies/_zm_perks", "perk_give_bottle_begin"), ::perk_give_bottle_begin);
	replaceFunc(getfunction("maps/mp/zombies/_zm_chugabud", "restore_weapon_for_chugabud"), ::restore_weapon_for_chugabud);
	replaceFunc(getfunction("maps/mp/zombies/_zm", "last_stand_pistol_swap"), ::last_stand_pistol_swap);
	replaceFunc(getfunction("maps/mp/gametypes_zm/_weaponobjects", "pickup"), ::pickup);
	replaceFunc(getfunction("maps/mp/gametypes_zm/_gameobjects", "useholdthink"), ::useholdthink);

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
    else if(IsSubStr(weapon, "slow"))
        return 46;
    else if(IsSubStr(weapon, "uzi"))
        return 47;
    else if(IsSubStr(weapon, "scar"))
        return 48;
    else if(IsSubStr(weapon, "870"))
        return 49;
    else if(IsSubStr(weapon, "ak") && IsSubStr(level.script, "tomb"))
        return 50;
    else if(IsSubStr(weapon, "stg"))
        return 51;
    else if(IsSubStr(weapon, "ballista"))
        return 52;
    else if(IsSubStr(weapon, "beretta"))
        return 53;
    else if(IsSubStr(weapon, "ray"))
        return 54;
    else if(IsSubStr(weapon, "five"))
        return 55;
    else if(IsSubStr(weapon, "olympia"))
        return 56;
    else if(IsSubStr(weapon, "lsat"))
        return 57;
    else if(IsSubStr(weapon, "mp5"))
        return 58;
    else if(IsSubStr(weapon, "16"))
        return 59;
    else if(IsSubStr(weapon, "pdw"))
        return 60;
    else if(IsSubStr(weapon, "dsr"))
        return 61;
    else if(IsSubStr(weapon, "barret"))
        return 62;
    else if(IsSubStr(weapon, "scrop"))
        return 63;
    else if(IsSubStr(weapon, "m32"))
        return 64;
    else if(IsSubStr(weapon, "ak"))
        return 65;
    else if(IsSubStr(weapon, "ball"))
        return 66;
    else if(IsSubStr(weapon, "chicom"))
        return 67;
    else if(IsSubStr(weapon, "fal"))
        return 68;
    else if(IsSubStr(weapon, "gal"))
        return 69;
    else if(IsSubStr(weapon, "hamr"))
        return 70;
    else if(IsSubStr(weapon, "hk"))
        return 71;
    else if(IsSubStr(weapon, "judge"))
        return 72;
    else if(IsSubStr(weapon, "ka"))
        return 73;
    else if(IsSubStr(weapon, "ksg"))
        return 74;
    else if(IsSubStr(weapon, "mg"))
        return 75;
    else if(IsSubStr(weapon, "py"))
        return 76;
    else if(IsSubStr(weapon, "mini"))
        return 77;
    else if(IsSubStr(weapon, "rpd"))
        return 78;
    else if(IsSubStr(weapon, "rnma"))
        return 79;
    else if(IsSubStr(weapon, "saiga"))
        return 80;
    else if(IsSubStr(weapon, "sar"))
        return 81;
    else if(IsSubStr(weapon, "svu"))
        return 82;
    else if(IsSubStr(weapon, "1216"))
        return 83;
    else if(IsSubStr(weapon, "thomp"))
        return 84;
    else if(IsSubStr(weapon, "type"))
        return 85;
    else if(IsSubStr(weapon, "rpg"))
        return 86;
    else if(IsSubStr(weapon, "xm8"))
        return 87;
    else if(IsSubStr(weapon, "x95l"))
        return 88;

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

take_old_weapon_and_give_new( current_weapon, weapon )
{
    // Esta no cambió nada
    a_weapons = self getweaponslistprimaries();

    if ( isdefined( a_weapons ) && a_weapons.size >= get_player_weapon_limit( self ) )
        self takeweapon( current_weapon );

    self giveweapon( weapon, 0, self get_pack_a_punch_weapon_options( weapon ) );
    self switchtoweapon( weapon );
}

laststand_give_pistol()
{
    assert( isdefined( self.laststandpistol ) );
    assert( self.laststandpistol != "none" );

    if ( isdefined( level.zombie_last_stand ) )
        [[ level.zombie_last_stand ]]();
    else
    {
        self weapon_give(self.laststandpistol);
        self givemaxammo(self.laststandpistol);
        self switchtoweapon(self.laststandpistol);
    }
}

suicide_trigger_think()
{
    self endon( "disconnect" );
    self endon( "zombified" );
    self endon( "stop_revive_trigger" );
    self endon( "player_revived" );
    self endon( "bled_out" );
    self endon( "fake_death" );
    level endon( "end_game" );
    level endon( "stop_suicide_trigger" );
    self thread [[getfunction("maps/mp/zombies/_zm_weapons", "clean_up_suicide_hud_on_end_game")]]();
    self thread [[getfunction("maps/mp/zombies/_zm_weapons", "clean_up_suicide_hud_on_bled_out")]]();

    while ( self usebuttonpressed() )
        wait 1;

    if ( !isdefined( self.suicideprompt ) )
        return;

    while ( true )
    {
        wait 0.1;

        if ( !isdefined( self.suicideprompt ) )
            continue;

        self.suicideprompt settext( &"ZOMBIE_BUTTON_TO_SUICIDE" );

        if ( !self [[getfunction("maps/mp/zombies/_zm_weapons", "is_suiciding")]]() )
            continue;

        self.pre_suicide_weapon = self getcurrentweapon();

        self weapon_give(level.suicide_weapon);
        self switchtoweapon( level.suicide_weapon );
        duration = self docowardswayanims();
        suicide_success = [[getfunction("maps/mp/zombies/_zm_weapons", "suicide_do_suicide")]](duration);
        self.laststand = undefined;
        self takeweapon( level.suicide_weapon );

        if ( suicide_success )
        {
            self notify( "player_suicide" );
            wait_network_frame();
            self maps\mp\zombies\_zm_stats::increment_client_stat( "suicides" );
            self [[getfunction("maps/mp/zombies/_zm_weapons", "bleed_out")]]();
            return;
        }
        
        self switchtoweapon( self.pre_suicide_weapon );
        self.pre_suicide_weapon = undefined;
    }
}

revive_trigger_think()
{
    self endon( "disconnect" );
    self endon( "zombified" );
    self endon( "stop_revive_trigger" );
    level endon( "end_game" );
    self endon( "death" );

    while ( true )
    {
        wait 0.1;
        self.revivetrigger sethintstring( "" );
        players = get_players();

        for ( i = 0; i < players.size; i++ )
        {
            d = 0;
            d = self depthinwater();

            if ( players[i] can_revive( self ) || d > 20 )
            {
                self.revivetrigger setrevivehintstring( &"ZOMBIE_BUTTON_TO_REVIVE_PLAYER", self.team );
                break;
            }
        }

        for ( i = 0; i < players.size; i++ )
        {
            reviver = players[i];

            if ( self == reviver || !reviver is_reviving( self ) )
                continue;

            gun = reviver getcurrentweapon();
            assert( isdefined( gun ) );

            if ( gun == level.revive_tool )
                continue;

            reviver weapon_give( level.revive_tool );
            reviver switchtoweapon( level.revive_tool );
            reviver setweaponammostock( level.revive_tool, 1 );
            revive_success = reviver revive_do_revive( self, gun );
            reviver revive_give_back_weapons( gun );

            if ( isplayer( self ) )
                self allowjump( 1 );

            self.laststand = undefined;

            if ( revive_success )
            {
                if ( isplayer( self ) )
                    maps\mp\zombies\_zm_chugabud::player_revived_cleanup_chugabud_corpse();

                self thread revive_success( reviver );
                self cleanup_suicide_hud();
                return;
            }
        }
    }
}

restore_weapon_for_tombstone( player, weapon_name )
{
    if ( !isdefined( weapon_name ) || !isdefined( self.tombstone_melee_weapons ) || !isdefined( self.tombstone_melee_weapons[weapon_name] ) )
        return;

    if ( isdefined( self.tombstone_melee_weapons[weapon_name] ) && self.tombstone_melee_weapons[weapon_name] )
    {
        player weapon_give( weapon_name );
        player change_melee_weapon( weapon_name, "none" );
        self.tombstone_melee_weapons[weapon_name] = 0;
    }
}

upgrade_knuckle_crack_begin()
{
    self increment_is_drinking();
    self disable_player_move_states( 1 );
    primaries = self getweaponslistprimaries();
    gun = self getcurrentweapon();
    weapon = level.machine_assets["packapunch"].weapon;

    if ( gun != "none" && !is_placeable_mine( gun ) && !is_equipment( gun ) )
    {
        self notify( "zmb_lost_knife" );
        self takeweapon( gun );
    }
    else
        return;

    self weapon_give( weapon );
    self switchtoweapon( weapon );
    return gun;
}

perk_give_bottle_begin( perk )
{
    self increment_is_drinking();
    self disable_player_move_states( 1 );
    gun = self getcurrentweapon();
    weapon = "";

    switch ( perk )
    {
        case " _upgrade":
        case "specialty_armorvest":
            weapon = level.machine_assets["juggernog"].weapon;
            break;
        case "specialty_quickrevive":
        case "specialty_quickrevive_upgrade":
            weapon = level.machine_assets["revive"].weapon;
            break;
        case "specialty_fastreload":
        case "specialty_fastreload_upgrade":
            weapon = level.machine_assets["speedcola"].weapon;
            break;
        case "specialty_rof":
        case "specialty_rof_upgrade":
            weapon = level.machine_assets["doubletap"].weapon;
            break;
        case "specialty_longersprint":
        case "specialty_longersprint_upgrade":
            weapon = level.machine_assets["marathon"].weapon;
            break;
        case "specialty_flakjacket":
        case "specialty_flakjacket_upgrade":
            weapon = level.machine_assets["divetonuke"].weapon;
            break;
        case "specialty_deadshot":
        case "specialty_deadshot_upgrade":
            weapon = level.machine_assets["deadshot"].weapon;
            break;
        case "specialty_additionalprimaryweapon":
        case "specialty_additionalprimaryweapon_upgrade":
            weapon = level.machine_assets["additionalprimaryweapon"].weapon;
            break;
        case "specialty_scavenger":
        case "specialty_scavenger_upgrade":
            weapon = level.machine_assets["tombstone"].weapon;
            break;
        case "specialty_finalstand":
        case "specialty_finalstand_upgrade":
            weapon = level.machine_assets["whoswho"].weapon;
            break;
    }

    if ( isdefined( level._custom_perks[perk] ) && isdefined( level._custom_perks[perk].perk_bottle ) )
        weapon = level._custom_perks[perk].perk_bottle;

    self weapon_give( weapon );
    self switchtoweapon( weapon );
    return gun;
}

restore_weapon_for_chugabud( player, weapon_name )
{
    if ( !isdefined( weapon_name ) || !isdefined( self.chugabud_melee_weapons ) || !isdefined( self.chugabud_melee_weapons[weapon_name] ) )
        return;

    if ( isdefined( self.chugabud_melee_weapons[weapon_name] ) && self.chugabud_melee_weapons[weapon_name] )
    {
        player weapon_give( weapon_name );
        player set_player_melee_weapon( weapon_name );
        self.chugabud_melee_weapons[weapon_name] = 0;
    }
}

last_stand_pistol_swap()
{
    if ( self has_powerup_weapon() )
        self.lastactiveweapon = "none";

    if ( !self hasweapon( self.laststandpistol ) )
        self weapon_give( self.laststandpistol );

    ammoclip = weaponclipsize( self.laststandpistol );
    doubleclip = ammoclip * 2;

    if ( isdefined( self._special_solo_pistol_swap ) && self._special_solo_pistol_swap || self.laststandpistol == level.default_solo_laststandpistol && !self.hadpistol )
    {
        self._special_solo_pistol_swap = 0;
        self.hadpistol = 0;
        self setweaponammostock( self.laststandpistol, doubleclip );
    }
    else if ( flag( "solo_game" ) && self.laststandpistol == level.default_solo_laststandpistol )
        self setweaponammostock( self.laststandpistol, doubleclip );
    else if ( self.laststandpistol == level.default_laststandpistol )
        self setweaponammostock( self.laststandpistol, doubleclip );
    else if ( self.laststandpistol == "ray_gun_zm" || self.laststandpistol == "ray_gun_upgraded_zm" )
    {
        if ( self.stored_weapon_info[self.laststandpistol].total_amt >= ammoclip )
        {
            self setweaponammoclip( self.laststandpistol, ammoclip );
            self.stored_weapon_info[self.laststandpistol].given_amt = ammoclip;
        }
        else
        {
            self setweaponammoclip( self.laststandpistol, self.stored_weapon_info[self.laststandpistol].total_amt );
            self.stored_weapon_info[self.laststandpistol].given_amt = self.stored_weapon_info[self.laststandpistol].total_amt;
        }

        self setweaponammostock( self.laststandpistol, 0 );
    }
    else if ( self.stored_weapon_info[self.laststandpistol].stock_amt >= doubleclip )
    {
        self setweaponammostock( self.laststandpistol, doubleclip );
        self.stored_weapon_info[self.laststandpistol].given_amt = doubleclip + self.stored_weapon_info[self.laststandpistol].clip_amt + self.stored_weapon_info[self.laststandpistol].left_clip_amt;
    }
    else
    {
        self setweaponammostock( self.laststandpistol, self.stored_weapon_info[self.laststandpistol].stock_amt );
        self.stored_weapon_info[self.laststandpistol].given_amt = self.stored_weapon_info[self.laststandpistol].total_amt;
    }

    self switchtoweapon( self.laststandpistol );
}

pickup( player )
{
    if ( self.name != "hatchet_mp" && isdefined( self.owner ) && self.owner != player )
        return;

    self.playdialog = 0;
    self destroyent();
    player weapon_give( self.name );
    clip_ammo = player getweaponammoclip( self.name );
    clip_max_ammo = weaponclipsize( self.name );

    if ( clip_ammo < clip_max_ammo )
        clip_ammo++;

    player setweaponammoclip( self.name, clip_ammo );
}

useholdthink( player )
{
    player notify( "use_hold" );

    if ( !( isdefined( self.dontlinkplayertotrigger ) && self.dontlinkplayertotrigger ) )
    {
        player playerlinkto( self.trigger );
        player playerlinkedoffsetenable();
    }

    player clientclaimtrigger( self.trigger );
    player.claimtrigger = self.trigger;
    useweapon = self.useweapon;
    lastweapon = player getcurrentweapon();

    if ( isdefined( useweapon ) )
    {
        assert( isdefined( lastweapon ) );

        if ( lastweapon == useweapon )
        {
            assert( isdefined( player.lastnonuseweapon ) );
            lastweapon = player.lastnonuseweapon;
        }

        assert( lastweapon != useweapon );
        player.lastnonuseweapon = lastweapon;
        player giveweapon( useweapon );
        player setweaponammostock( useweapon, 0 );
        player setweaponammoclip( useweapon, 0 );
        player switchtoweapon( useweapon );
    }
    else
        player _disableweapon();

    self clearprogress();
    self.inuse = 1;
    self.userate = 0;
    objective_setplayerusing( self.objectiveid, player );
    player thread personalusebar( self );
    result = useholdthinkloop( player, lastweapon );

    if ( isdefined( player ) )
    {
        objective_clearplayerusing( self.objectiveid, player );
        self clearprogress();

        if ( isdefined( player.attachedusemodel ) )
        {
            player detach( player.attachedusemodel, "tag_inhand" );
            player.attachedusemodel = undefined;
        }

        player notify( "done_using" );
    }

    if ( isdefined( useweapon ) && isdefined( player ) )
        player thread takeuseweapon( useweapon );

    if ( isdefined( result ) && result )
        return true;

    if ( isdefined( player ) )
    {
        player.claimtrigger = undefined;

        if ( isdefined( useweapon ) )
        {
            ammo = player getweaponammoclip( lastweapon );

            if ( lastweapon != "none" && !( isweaponequipment( lastweapon ) && player getweaponammoclip( lastweapon ) == 0 ) )
                player switchtoweapon( lastweapon );
            else
                player takeweapon( useweapon );
        }
        else if ( isalive( player ) )
            player _enableweapon();

        if ( !( isdefined( self.dontlinkplayertotrigger ) && self.dontlinkplayertotrigger ) )
            player unlink();

        if ( !isalive( player ) )
            player.killedinuse = 1;
    }

    self.inuse = 0;

    if ( self.trigger.classname == "trigger_radius_use" )
        player clientreleasetrigger( self.trigger );
    else
        self.trigger releaseclaimedtrigger();

    return false;
}