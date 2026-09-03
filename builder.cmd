@echo off
set MOD_NAME=zm_animatedcamos
set GAME_FOLDER=C:\Program Files (x86)\Steam\steamapps\common\Call of Duty Black Ops II
set OAT_BASE=C:\OAT
set MOD_BASE=%cd%

::Below is an example of assets needed to load in order to build the mod. 
::Each line is seperated by a "^".
"%OAT_BASE%\linker.exe" ^
-v ^
--load "%GAME_FOLDER%\zone\all\zm_transit.ff" ^
--load "%GAME_FOLDER%\zone\all\zm_prison.ff" ^
--load "%GAME_FOLDER%\zone\all\zm_prison_patch.ff" ^
--load "%GAME_FOLDER%\zone\all\so_zclassic_zm_prison.ff" ^
--load "%GAME_FOLDER%\zone\all\zm_buried.ff" ^
--load "%GAME_FOLDER%\zone\all\zm_tomb.ff" ^
--load "%GAME_FOLDER%\zone\all\zm_highrise.ff" ^
--load "%GAME_FOLDER%\zone\all\so_zclassic_zm_transit.ff" ^
--load "%GAME_FOLDER%\zone\all\so_zsurvival_zm_transit.ff" ^
--load "%GAME_FOLDER%\zone\all\common_zm.ff" ^
--load "%GAME_FOLDER%\zone\all\ui_mp.ff" ^
--load "%GAME_FOLDER%\zone\all\ui_zm.ff" ^
--load "%GAME_FOLDER%\zone\all\zm_nuked.ff" ^
--load "%GAME_FOLDER%\zone\all\patch_zm.ff" ^
--load "%GAME_FOLDER%\zone\all\dlc4_load_zm.ff" ^
--load "%GAME_FOLDER%\zone\all\code_post_gfx_zm.ff" ^
--load "%GAME_FOLDER%\zone\all\code_post_gfx_mp.ff" ^
--load "%GAME_FOLDER%\zone\all\code_pre_gfx_mp.ff" ^
--load "%GAME_FOLDER%\zone\all\code_pre_gfx_zm.ff" ^
--load "%GAME_FOLDER%\zone\all\common_mp.ff" ^
--load "%GAME_FOLDER%\zone\all\common_patch_mp.ff" ^
--load "%GAME_FOLDER%\zone\all\dlc0_load_mp.ff" ^
--load "%GAME_FOLDER%\zone\all\dlc1_load_mp.ff" ^
--load "%GAME_FOLDER%\zone\all\dlc1_load_zm.ff" ^
--load "%GAME_FOLDER%\zone\all\dlc2_load_mp.ff" ^
--load "%GAME_FOLDER%\zone\all\dlc2_load_zm.ff" ^
--load "%GAME_FOLDER%\zone\all\dlc3_load_mp.ff" ^
--load "%GAME_FOLDER%\zone\all\dlc3_load_zm.ff" ^
--load "%GAME_FOLDER%\zone\all\dlc4_load_mp.ff" ^
--load "%GAME_FOLDER%\zone\all\dlczm0_load_zm.ff" ^
--load "%GAME_FOLDER%\zone\all\patch_mp.ff" ^
--load "%GAME_FOLDER%\zone\all\zm_transit_patch.ff" ^
--load "%GAME_FOLDER%\zone\all\zm_prison_patch.ff" ^
--load "%GAME_FOLDER%\zone\all\zm_buried_patch.ff" ^
--load "%GAME_FOLDER%\zone\all\zm_tomb_patch.ff" ^
--load "%GAME_FOLDER%\zone\all\zm_nuked_patch.ff" ^
--load "%GAME_FOLDER%\zone\all\zm_highrise_patch.ff" ^
--base-folder "%OAT_BASE%" ^
--add-asset-search-path "%MOD_BASE%" ^
--source-search-path "%MOD_BASE%\zone_source" ^
--output-folder "%MOD_BASE%\zone" mod

set err=%ERRORLEVEL%

if %err% EQU 0 (
    if not exist "%LOCALAPPDATA%\Plutonium\storage\t6\mods\%MOD_NAME%" mkdir "%LOCALAPPDATA%\Plutonium\storage\t6\mods\%MOD_NAME%"

    XCOPY "%MOD_BASE%\zone\mod.ff" "%LOCALAPPDATA%\Plutonium\storage\t6\mods\%MOD_NAME%\mod.ff" /Y
    XCOPY "%MOD_BASE%\mod.json" "%LOCALAPPDATA%\Plutonium\storage\t6\mods\%MOD_NAME%\mod.json" /Y

    echo DONE!
) ELSE (
    COLOR C
    echo FAIL!
    pause
)

