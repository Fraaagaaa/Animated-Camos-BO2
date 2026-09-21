#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes_zm\_hud_util;
#include maps\mp\gametypes_zm\_weapons;
#include maps\mp\zombies\_zm_weapons;

init()
{
	replaceFunc(getfunction("maps/mp/zombies/_zm_weap_slipgun", "pickupslipgun"), ::pickupslipgun);
}

pickupslipgun( item )
{
    item.owner = self;
    self weapon_give( item.name );
    if ( isdefined( item.clipammo ) && isdefined( item.stockammo ) )
    {
        self setweaponammoclip( item.name, item.clipammo );
        self setweaponammostock( item.name, item.stockammo );
        item.clipammo = undefined;
        item.stockammo = undefined;
    }
}