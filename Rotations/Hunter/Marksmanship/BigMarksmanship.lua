local rotationName = "Bigsie"
local br = _G["br"]
loadSupport("PetCuteOne")
---------------
--- Toggles ---
---------------
local function createToggles()
    -- Rotation Button
    RotationModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Automatic Rotation", tip = "Swaps between Single and Multiple based on number of targets in range.", highlight = 1, icon = br.player.spell.aimedShot },
        [2] = { mode = "Mult", value = 2 , overlay = "Multiple Target Rotation", tip = "Multiple target rotation used.", highlight = 0, icon = br.player.spell.multishot },
        [3] = { mode = "Sing", value = 3 , overlay = "Single Target Rotation", tip = "Single target rotation used.", highlight = 0, icon = br.player.spell.arcaneShot }
    };
    CreateButton("Rotation",1,0)
    -- -- Interrupt Button
    -- InterruptModes = {
    --     [1] = { mode = "On", value = 1 , overlay = "Interrupts Enabled", tip = "Includes Basic Interrupts.", highlight = 1, icon = br.player.spell.counterShot },
    --     [2] = { mode = "Off", value = 2 , overlay = "Interrupts Disabled", tip = "No Interrupts will be used.", highlight = 0, icon = br.player.spell.counterShot }
    -- };
    -- CreateButton("Interrupt",2,0)
    -- MD Button
    MisdirectionModes = {
        [1] = { mode = "On", value = 1 , overlay = "Misdirection Enabled", tip = "Misdirection Enabled", highlight = 1, icon = br.player.spell.misdirection },
        [2] = { mode = "Off", value = 2 , overlay = "Misdirection Disabled", tip = "Misdirection Disabled", highlight = 0, icon = br.player.spell.misdirection }
    };
    CreateButton("Misdirection",0,1)
    -- Volley Button
    VolleyModes = {
        [1] = { mode = "On", value = 1 , overlay = "Volley Enabled", tip = "Volley Enabled", highlight = 1, icon = br.player.spell.volley },
        [2] = { mode = "Off", value = 2 , overlay = "Volley Disabled", tip = "Volley Disabled", highlight = 0, icon = br.player.spell.volley }
    };
    CreateButton("Volley",1,1)
    -- CC Button
    CCModes = {
        [1] = { mode = "On", value = 1 , overlay = "CC Enabled", tip = "CC Enabled", highlight = 1, icon = br.player.spell.freezingTrap },
        [2] = { mode = "Off", value = 2 , overlay = "CC Disabled", tip = "CC Disabled", highlight = 0, icon = br.player.spell.freezingTrap }
    };
    CreateButton("CC",2,1)
end

---------------
--- OPTIONS ---
---------------
local function createOptions()
    local optionTable

    local function rotationOptions()
        local section
        section = br.ui:createSection(br.ui.window.profile, "General")
            br.ui:createSpinner(section, "Dummy DPS Testing",  5,  5,  60,  5,  "|cffFFFFFFSet to desired time for test in minuts. Min: 5 / Max: 60 / Interval: 5")
            br.ui:createCheckbox(section, "Do not engage OOC", "OOC=Out of combat")
            br.ui:createCheckbox(section, "Prepull logic", "Works as opener")
            br.ui:createText(section, "Toggle options")
            br.ui:createDropdownWithout(section, "Rotation Mode", br.dropOptions.Toggle,  6)
            -- br.ui:createDropdownWithout(section, "Interrupt Mode", br.dropOptions.Toggle,  6)
            br.ui:createDropdownWithout(section, "Misdirection Mode", br.dropOptions.Toggle,  6)
            br.ui:createDropdownWithout(section, "Volley Mode", br.dropOptions.Toggle,  6)
        br.ui:checkSectionState(section)
        section = br.ui:createSection(br.ui.window.profile, "Ability options")
            br.ui:createDropdownWithout(section,"Misdirection", {"|cff00FF00Tank","|cffFFFF00Focus","|cffFF0000Pet"},
                                        1, "|cffFFFFFFWho to use Misdirection on")
            br.ui:createSpinner(section,"Volley Units", 3, 1, 5, 1, "|cffFFFFFFSet minimal number of units to cast Volley on")
            br.ui:createCheckbox(section,"Hunter's Mark")
        br.ui:checkSectionState(section)
        section = br.ui:createSection(br.ui.window.profile, "Cooldowns")
            br.ui:createCheckbox(section,"Trinkets with Trueshot logic", "|cffFFFFFFUse other cooldowns with trueshot")
            br.ui:createDropdownWithout(section,"Covenant Ability", {"Always", "Cooldown", "Never"}, 1, "|cffFFFFFFSet when to use ability.")
            br.ui:createDropdownWithout(section,"Double Tap", {"Always", "Cooldown", "Never"}, 1, "|cffFFFFFFSet when to use ability.")
            br.ui:createDropdownWithout(section,"Trueshot", {"Always", "Cooldown", "Never"}, 1, "|cffFFFFFFSet when to use ability.")
            br.ui:createCheckbox(section,select(1,GetItemInfo(br.player.items.potionOfSpectralAgility), "Use potion in raids with other cooldowns"))
            br.ui:createCheckbox(section,select(1,GetItemInfo(br.player.items.spectralFlaskOfPower)), "Use flask")
            br.ui:createCheckbox(section,"Racial")
        br.ui:checkSectionState(section)
        section = br.ui:createSection(br.ui.window.profile, "Defensive")
            br.player.module.BasicHealing(section)
            br.ui:createSpinner(section, "Aspect Of The Turtle",  60,  0,  100,  5,  "|cffFFBB00Health Percentage to use at.");
            br.ui:createSpinner(section, "Exhilaration",  60,  0,  100,  5,  "|cffFFBB00Health Percentage to use at.");
            br.ui:createDropdown(section, "Tranquilizing Shot", {"|cff00FF00Any","|cffFFFF00Target"}, 2,"|cffFFFFFFHow to use Tranquilizing Shot." )
        br.ui:checkSectionState(section)
        -- section = br.ui:createSection(br.ui.window.profile, "Interrupts")
        --     if br.player ~= nil and br.player.spell ~= nil and br.player.spell.interrupts ~= nil then
        --         for _, v in pairs(br.player.spell.interrupts) do
        --             local spellName = GetSpellInfo(v)
        --             if v ~= 61304 and spellName ~= nil then
        --                 br.ui:createCheckbox(section, spellName, "Interrupt with " .. spellName .. " (ID: " .. v .. ")")
        --             end
        --         end
        --     end
        --     br.ui:createSpinnerWithout(section, "Interrupt At",  0,  0,  95,  5,  "|cffFFFFFFCast Percent to Cast At")
        -- br.ui:checkSectionState(section)
        section = br.ui:createSection(br.ui.window.profile, "CCs")
        br.ui:createText(section, "Dungeon boss mechanics")
        br.ui:createCheckbox(section,"Castle Nathria (Huntsman - Shade of Bargast)", "Cast Freezing Trap on Shade of Bargast")
        br.ui:createCheckbox(section,"Mists of Tirna Scithe (Mistcaller - Illusionary Vulpin)", "Cast Freezing Trap on Illusionary Vulpin")
        br.ui:createCheckbox(section,"Plaguefall (Globgrog - Slimy Smorgasbord)", "Cast Freezing Trap on Slimy Smorgasbord")
        br.ui:createCheckbox(section,"The Necrotic Wake (Blightbone  - Carrion Worms)", "Cast Binding Shot on Carrion Worms")
        br.ui:createText(section, "Dungeon trash mechanics")
        br.ui:createCheckbox(section,"Halls of Atonement (Vicious Gargon, Loyal Beasts)", "Cast Binding Shot on Vicious Gargon with Loyal Beasts")
        br.ui:createCheckbox(section,"Plaguefall (Defender of Many Eyes, Bulwark of Maldraxxus)", "Cast Freezing Trap on Defender of Many Eyes with Bulwark of Maldraxxus")
        br.ui:createCheckbox(section,"Plaguefall (Rotting Slimeclaw)", "Cast Binding Shot on Rotting Slimeclaw with 20% hp")
        br.ui:createCheckbox(section,"Theater of Pain (Disgusting Refuse)", "Cast Binding Shot on Disgusting Refuse to avoid jumping around")
        br.ui:checkSectionState(section)
    end
    optionTable = {{
        [1] = "Rotation Options",
        [2] = rotationOptions,
    }}
    return optionTable
end

--------------
--- Locals ---
--------------
local buff
local cast
local cd
local charges
local covenant
local debuff
local enemies
local equiped
local maps = br.lists.maps
local module
local power
local runeforge
local spell
local talent
local items
local ui
local unit
local units
local use
local var
local actionList = {}
local _ = nil


-----------------------
--- Local Functions ---
-----------------------

local function isFreezingTrapActive()
    for _,v in pairs(enemies.get(40, "player", true)) do if debuff.freezingTrap.exists(v, "player") then return true end end
    return false
end

local function isBlacklistedTrinket(slot)
    local trinketBlacklist = {
        bottledFlayedWingToxin = 178742
    }
    for _,v in pairs(trinketBlacklist) do
        if v == GetInventoryItemID("player", slot) then return true end
    end
    return false
end

-- Use only one argument for now
local function ccMobFinder(id, minHP, maxHP, spellID)
    local theUnit
    if spellID == br.player.spell.freezingTrap then if isFreezingTrapActive() then return end end
    for _,v in pairs(enemies.yards40) do
        if unit.id(v) == id then
            theUnit = v
            if not isLongTimeCCed(v) then
                if minHP ~= nil then if minHP <= unit.hp(theUnit) then return theUnit end end
                if maxHp ~= nil then if maxHP >= unit.hp(theUnit) then return theUnit end end
                if spellID ~= nil then if (getDebuffDuration(theUnit,spellID,"player")) > 0 then return theUnit end end
            end
            return theUnit
        end
    end
end

--------------------
--- Action Lists ---
--------------------
-- Action List - pc
actionList.pc = function()
    if ui.pullTimer() <= 10 and not buff.feignDeath.exists() and not unit.inCombat() then
        -- actions.precombat=flask
        if ui.checked("Spectral Flask of Power") then
            if use.spectralFlaskOfPower() then ui.debug("Using Spectral Flask of Power") end
        end
        --TODO!
        --actions.precombat+=/augmentation
        --actions.precombat+=/food

        if unit.valid("target") and unit.distance("target") < 40 and ui.checked("Prepull logic") then
            -- actions.precombat+=/tar_trap,if=runeforge.soulforge_embers
            if cast.able.tarTrap() and runeforge.soulforgeEmbers.equiped then
                return cast.tarTrap(units.dyn40,"ground")
            end
            --actions.precombat+=/double_tap,precast_time=10,if=active_enemies>1|!covenant.kyrian&!talent.volley
            if ui.alwaysCdNever("Double Tap") and cast.able.doubleTap() and ui.pullTimer() <= 10 and (#enemies.yards8t > 1 or not covenant.kyrian.active and not talent.volley) then
                return cast.doubleTap()
            end
            --actions.precombat+=/aimed_shot,if=active_enemies<3&(!covenant.kyrian&!talent.volley|active_enemies<2)
            if cast.able.aimedShot() and ui.pullTimer() <= 2 and not unit.moving("player") and #enemies.yards8t < 3 and (#enemies.yards8t < 2 or (not covenant.kyrian.active and not talent.volley)) then
                return cast.aimedShot("target")
            end
            --actions.precombat+=/steady_shot,if=active_enemies>2|(covenant.kyrian|talent.volley)&active_enemies=2
            if cast.able.steadyShot() and (#enemies.yards8t > 2 or ((covenant.kyrian.active or talent.volley) and #enemies.yards8t == 2)) then
                return cast.steadyShot("target")
            end
        end
    end
    if not ui.checked("Do not engage OOC") then unit.startAttack("target") end
end -- End Action List - pc

-- Action List - aa
actionList.aa = function()
    --actions=auto_shot
    unit.startAttack("target")

    if ui.checked("Trinkets with Trueshot logic") then
        --actions+=/use_item,name=dreadfire_vessel,if=trinket.1.has_cooldown...
        if equiped.dreadfireVessel()
            and cd.trinket1.exists() or cd.trinket2.exists()
            or cd.trinket1.remain() + cd.trinket2.remain() > 0
            or cd.trinket1.duration() + cd.trinket2.duration() <= cd.dreadfireVessel.remain() * 2
        then
            if use.able.dreadfireVessel() then return use.dreadfireVessel() end
        end

        --actions+=/use_items,slots=trinket1,if=buff.trueshot.up...
        if buff.trueshot.exists()
            and (cd.trinket1.duration() >= cd.trinket2.duration() or cd.trinket2.exists())
            or not buff.trueshot.exists()
            and cd.trueshot.remain() > 20
            and cd.trinket2.duration() >= cd.trinket1.duration()
            and cd.trinket2.remain() - 5 < cd.trueshot.remain()
            and not items.trinket2 == items.dreadfireVessel
            or (cd.trinket1.duration() -5 < cd.trueshot.remain()
            and (cd.trinket1.duration() >= cd.trinket2.duration() or cd.trinket2.exists()))
            or unit.ttd() < cd.trueshot.remain()
        then
            if use.able.trinket1() and not isBlacklistedTrinket(13) then return use.trinket1()end
        end

        --actions+=/use_items,slots=trinket2,if=buff.trueshot.up...
        if buff.trueshot.exists()
            and (cd.trinket2.duration() >= cd.trinket1.duration() or cd.trinket1.exists())
            or not buff.trueshot.exists()
            and cd.trueshot.remain() > 20
            and cd.trinket1.duration() >= cd.trinket2.duration()
            and cd.trinket1.remain() - 5 < cd.trueshot.remain()
            and not items.trinket1 == items.dreadfireVessel
            or (cd.trinket2.duration() -5 < cd.trueshot.remain()
            and (cd.trinket2.duration() >= cd.trinket1.duration() or cd.trinket1.exists()))
            or unit.ttd() < cd.trueshot.remain()
        then
            if use.able.trinket2() and not isBlacklistedTrinket(14) then return use.trinket2()end
        end
    end
end

-- Action List - cds
actionList.cds = function()
    -- racial
    if ui.checked("Racial") then
        if buff.trueshot.exists() and not unit.race() == "LightforgedDraenei"
            or (unit.race() == "Troll" and unit.ttd() < 13)
            or ((unit.race() == "Orc" or unit.race() == "MagharOrc") and unit.ttd() < 16)
            or (unit.race() == "DarkIronDwarf" and unit.ttd() < 9)
        then
            return cast.racial()
        end

        if not buff.trueshot.exists() then
            --/lights_judgment,if=buff.trueshot.down
            if unit.race() == "LightforgedDraenei" then
                return cast.racial("target","ground")
            end
            --/bag_of_tricks,if=buff.trueshot.down
            if unit.race() == "Vulpera" then
                return cast.racial()
            end
        end
    end
    -- potion,if=buff.trueshot.up&buff.bloodlust.up|buff.trueshot.up&target.health.pct<20|target.time_to_die<26
    if ui.checked("Potion of Spectral Agility") and use.able.potionOfSpectralAgility() and unit.instance("raid") then
        if buff.trueshot.exists() and buff.bloodLust.exists() or buff.trueshot.exists and unit.hp() < 20 or unit.ttd(units.dyn40) < 26 then
            return use.potionOfSpectralAgility()
        end
    end
end -- End Action List - cds

-- Action List - st
actionList.st = function()
    -- steady_shot,if=talent.steady_focus&(prev_gcd.1.steady_shot&buff.steady_focus.remains<5|buff.steady_focus.down)
    if cast.able.steadyShot() and talent.steadyFocus and ( cd.steadyShot.prevgcd() and buff.steadyFocus.remain() < 5 or not buff.steadyFocus.exists()) then
        return cast.steadyShot()
    end
    -- kill_shot
    if cast.able.killShot(var.lowestHPUnit) and unit.hp(var.lowestHPUnit) < 20 then
        return cast.killShot(var.lowestHPUnit)
    end
    --------------------------------------------------------------------------------- TODO AFTER THIS ---------------------------------------------------------------------------------
    --------------------------------------------------------------------------------- TODO AFTER THIS ---------------------------------------------------------------------------------
    --------------------------------------------------------------------------------- TODO AFTER THIS ---------------------------------------------------------------------------------
    --------------------------------------------------------------------------------- TODO AFTER THIS ---------------------------------------------------------------------------------
    --------------------------------------------------------------------------------- TODO AFTER THIS ---------------------------------------------------------------------------------
    -- Double Tap
    -- double_tap,if=covenant.kyrian&cooldown.resonating_arrow.remains<gcd|!covenant.kyrian&!covenant.night_fae|covenant.night_fae&(cooldown.wild_spirits.remains<gcd|cooldown.trueshot.remains>55)|target.time_to_die<15
    if ui.alwaysCdNever("Double Tap") and cast.able.doubleTap() and talent.doubleTap and (not cast.last.steadyShot() or buff.steadyFocus.exists() or not talent.steadyFocus)
        and ((((covenant.kyrian.active and (cd.resonatingArrow.remains() < unit.gcd(true) or not ui.alwaysCdNever("Covenant Ability"))) or not covenant.kyrian.active)
        and (not covenant.nightFae.active or (covenant.nightFae.active and ((cd.wildSpirits.remains() < unit.gcd(true) or not ui.alwaysCdNever("Covenant Ability")) or cd.trueshot.remains() > 55))))
        or (unit.isBoss("target") or unit.ttd("target") < 15))
    then
        if cast.doubleTap() then ui.debug("Casting Double Tap") return true end
    end
    -- Flare
    -- flare,if=tar_trap.up&runeforge.soulforge_embers
    if cast.able.flare() and debuff.tarTrap.exists(units.dyn40) and runeforge.soulforgeEmbers.equiped then
        if cast.flare(units.dyn40) then ui.debug("Casting Flare [Soulforge Embers]") return true end
    end
    -- Tar Trap
    -- tar_trap,if=runeforge.soulforge_embers&tar_trap.remains<gcd&cooldown.flare.remains<gcd
    if cast.able.tarTrap() and runeforge.soulforgeEmbers.equiped
        and debuff.tarTrap.remains(units.dyn40) < unit.gcd(true) and cd.flare.remains() < unit.gcd(true)
    then
        if cast.tarTrap(units.dyn40,"ground") then ui.debug("Casting Tar Trap [Soulforge Embers]") return true end
    end
    -- Explosive Shot
    -- explosive_shot
    if ui.alwaysCdNever("Explosive Shot") and cast.able.explosiveShot() and talent.explosiveShot and unit.ttd(units.dyn40) > 3 then
        if cast.explosiveShot() then ui.debug("Casting Explosive Shot") return true end
    end
    -- Wild Spirits
    -- wild_spirits
    if ui.alwaysCdNever("Covenant Ability") and cast.able.wildSpirits() then
        if cast.wildSpirits() then ui.debug("Casting Wild Spirits [Night Fae]") return true end
    end
    -- Flayed Shot
    -- flayed_shot
    if ui.alwaysCdNever("Covenant Ability") and cast.able.flayedShot() then
        if cast.flayedShot() then ui.debug("Casting Flayed Shot [Venthhyr]") return true end
    end
    -- Death Chakram
    -- death_chakram,if=focus+cast_regen<focus.max
    if ui.alwaysCdNever("Covenant Ability") and cast.able.deathChakram() and power.focus.amount() + cast.regen.deathChakram() < power.focus.max() then
        if cast.deathChakram() then ui.debug("Casting Death Chakram [Necrolord]") return true end
    end
    -- A Murder of Crows
    -- a_murder_of_crows
    if ui.alwaysCdNever("A Murder of Crows") and cast.able.aMurderOfCrows() and talent.aMurderOfCrows then
        if cast.aMurderOfCrows() then ui.debug("Casting A Murder of Crows") return true end
    end
    -- Resonating Arrow
    -- resonating_arrow
    if ui.alwaysCdNever("Covenant Ability") and cast.able.resonatingArrow() then
        if cast.resonatingArrow() then ui.debug("Casting Resonating Arrow [Kyrian]") return true end
    end
    -- Volley
    -- volley,if=buff.precise_shots.down|!talent.chimaera_shot|active_enemies<2
    if cast.able.volley() and ui.mode.volley == 1 and ui.checked("Volley Units") and (not buff.preciseShots.exists() or not talent.chimaeraShot or #enemies.yards8t < 2) and (#enemies.yards8t >= ui.value("Volley Units")) then
        if cast.volley("best",nil,ui.value("Volley Units"),8) then ui.debug("Casting Volley") return true end
    end
    -- Trueshot
    -- trueshot,if=buff.precise_shots.down|buff.resonating_arrow.up|buff.wild_spirits.up|buff.volley.up&active_enemies>1
    if ui.alwaysCdNever("Trueshot") and cast.able.trueshot() and (not buff.preciseShots.exists() or debuff.resonatingArrow.exists(units.dyn40)
        or debuff.wildMark.exists(units.dyn40) or buff.volley.exists() and #enemies.yards8t > 1)
    then
        if cast.trueshot("player") then ui.debug("Casting Trueshot [Trick Shots]") return true end
    end
    -- Aimed Shot
    -- aimed_shot,target_if=min:dot.serpent_sting.remains+action.serpent_sting.in_flight_to_target*99,if=buff.precise_shots.down|(buff.trueshot.up|full_recharge_time<gcd+cast_time)&(!talent.chimaera_shot|active_enemies<2)|buff.trick_shots.remains>execute_time&active_enemies>1
    if cast.able.aimedShot() and not unit.moving("player") and (not buff.preciseShots.exists()
        or ((buff.trueshot.exists() or charges.aimedShot.timeTillFull() < unit.gcd(true) + cast.time.aimedShot())
        and (not talent.chimaeraShot or #enemies.yards8t < 2)) or buff.trickShots.remain() > cast.time.aimedShot() and #enemies.yards8t > 1)
    then
        if cast.aimedShot() then ui.debug("Casting Aimed Shot") return true end
    end
    -- Rapid Fire
    -- rapid_fire,if=focus+cast_regen<focus.max&(buff.trueshot.down|!runeforge.eagletalons_true_focus)&(buff.double_tap.down|talent.streamline)
    if ui.alwaysCdNever("Rapid Fire") and cast.able.rapidFire() and (power.focus.amount() + power.focus.regen() < power.focus.max()
        and (not buff.trueshot.exists() or not runeforge.eagletalonsTrueFocus.equiped)
        and (not buff.doubleTap.exists() or talent.streamline))
		and unit.ttd(units.dyn40) > cast.time.rapidFire()
    then
        if cast.rapidFire() then ui.debug("Casting Rapid Fire") return true end
    end
    -- Chimaera Shot
    -- chimaera_shot,if=buff.precise_shots.up|focus>cost+action.aimed_shot.cost
    if cast.able.chimaeraShot() and (buff.preciseShots.exists()
        or power.focus.amount() > cast.cost.chimaeraShot() + cast.cost.aimedShot())
    then
        if cast.chimaeraShot() then ui.debug("Casting Chimaera Shot") return true end
    end
    -- Arcane Shot
    -- arcane_shot,if=buff.precise_shots.up|focus>cost+action.aimed_shot.cost
    if cast.able.arcaneShot() and (buff.preciseShots.exists()
        or power.focus.amount() > cast.cost.arcaneShot() + cast.cost.aimedShot())
    then
        if cast.arcaneShot() then ui.debug("Casting Arcane Shot") return true end
    end
    -- Serpent Sting
    -- serpent_sting,target_if=min:remains,if=refreshable&target.time_to_die>duration
    if cast.able.serpentSting(var.lowestSerpentSting) and debuff.serpentSting.refresh(var.lowestSerpentSting)
        and unit.ttd(var.lowestSerpentSting) > debuff.serpentSting.duration(var.lowestSerpentSting)
    then
        if cast.serpentSting(var.lowestSerpentSting) then ui.debug("Casting Serpent Sting") return true end
    end
    -- Barrage
    -- barrage,if=active_enemies>1
    if ui.alwaysCdNever("Barrage") and cast.able.barrage() and talent.barrage
        and ((ui.mode.rotation == 1 and #enemies.yards8t > 1) or (ui.mode.rotation == 2 and #enemies.yards8t > 0))
    then
        if cast.barrage() then ui.debug("Casting Barrage") return true end
    end
    -- Rapid Fire
    -- rapid_fire,if=focus+cast_regen<focus.max&(buff.double_tap.down|talent.streamline)
    if ui.alwaysCdNever("Rapid Fire") and cast.able.rapidFire()
        and (power.focus.amount() + power.focus.regen() < power.focus.max()
        and (not buff.doubleTap.exists() or talent.streamline))
		and unit.ttd(units.dyn40) > cast.time.rapidFire()
    then
        if cast.rapidFire() then ui.debug("Casting Rapid Fire") return true end
    end
    -- Steady Shot
    -- steady_shot
    if cast.able.steadyShot() and unit.ttd(units.dyn40) > cast.time.steadyShot() and power.focus.amount() <= cast.cost.arcaneShot() + cast.cost.aimedShot() then
        if cast.steadyShot() then ui.debug("Casting Steady Shot") return true end
    end
end -- End Action List - st

-- Action List - aoe
actionList.aoe = function()
    -- Steady Shot
    -- steady_shot,if=talent.steady_focus&in_flight&buff.steady_focus.remains<5
    if cast.able.steadyShot() and talent.steadyFocus and cast.inFlight.steadyShot() and buff.steadyFocus.remains() < 5 then
        if cast.steadyShot() then ui.debug("Casting Steady Shot [Trick Shots Steady Focus]") return true end
    end
    -- Double Tap
    -- double_tap,if=covenant.kyrian&cooldown.resonating_arrow.remains<gcd|!covenant.kyrian&!covenant.night_fae|covenant.night_fae&(cooldown.wild_spirits.remains<gcd|cooldown.trueshot.remains>55)|target.time_to_die<10
    if ui.alwaysCdNever("Double Tap") and cast.able.doubleTap() and talent.doubleTap
        and ((((covenant.kyrian.active and (cd.resonatingArrow.remains() < unit.gcd(true) or not ui.alwaysCdNever("Covenant Ability"))) or not covenant.kyrian.active)
        and (not covenant.nightFae.active or (covenant.nightFae.active and ((cd.wildSpirits.remain() < unit.gcd(true) or not ui.alwaysCdNever("Covenant Ability")) or cd.trueshot.remains() > 55))))
        or (unit.isBoss("target") and unit.ttd("target") < 10))
    then
        if cast.doubleTap() then ui.debug("Casting Double Tap [Trick Shots]") return true end
    end
    -- Tar Trap
    -- tar_trap,if=runeforge.soulforge_embers&tar_trap.remains<gcd&cooldown.flare.remains<gcd
    if cast.able.tarTrap() and runeforge.soulforgeEmbers.equiped and debuff.tarTrap.remains(units.dyn40) < unit.gcd(true) and cd.flare.remains() < unit.gcd(true) then
        if cast.tarTrap(units.dyn40,"ground") then ui.debug("Casting Tar Trap [Trick Shots Soulforge Embers]") return true end
    end
    -- Flare
    -- flare,if=tar_trap.up&runeforge.soulforge_embers
    if cast.able.flare() and debuff.tarTrap.exists(units.dyn40) and runeforge.soulforgeEmbers.equiped then
        if cast.flare(units.dyn40) then ui.debug("Casting Flare [Trick Shots Soulforge Embers]") return true end
    end
    -- Explosive Shot
    -- explosive_shot
    if ui.alwaysCdNever("Explosive Shot") and cast.able.explosiveShot() and talent.explosiveShot and unit.ttd(units.dyn40) > 3 then
        if cast.explosiveShot() then ui.debug("Casting Explosive Shot [Trick Shots]") return true end
    end
    -- Wild Spirits
    -- wild_spirits
    if ui.alwaysCdNever("Covenant Ability") and cast.able.wildSpirits() then
        if cast.wildSpirits() then ui.debug("Casting Wild Spirits [Trick Shots Night Fae]") return true end
    end
    -- Resonating Arrow
    -- resonating_arrow
    if ui.alwaysCdNever("Covenant Ability") and cast.able.resonatingArrow() then
        if cast.resonatingArrow() then ui.debug("Casting Resonating Arrow [Trick Shots Kyrian]") return true end
    end
    -- Volley
    -- volley
    if cast.able.volley() and ui.mode.volley == 1 and ui.checked("Volley Units") and #enemies.yards8t >= ui.value("Volley Units") then
        if cast.volley("best",nil,ui.value("Volley Units"),8) then ui.debug("Casting Volley [Trick Shots]") return true end
    end
    -- Trueshot
    -- trueshot
    if ui.alwaysCdNever("Trueshot") and cast.able.trueshot() then
        if cast.trueshot("player") then ui.debug("Casting Trueshot [Trick Shots]") return true end
    end
    -- Rapid Fire
    -- rapid_fire,if=buff.trick_shots.remains>=execute_time&runeforge.surging_shots&buff.double_tap.down
    if ui.alwaysCdNever("Rapid Fire") and cast.able.rapidFire() and buff.trickShots.remains() > cast.time.rapidFire()
        and runeforge.surgingShots.equiped and not buff.doubleTap.exists() and unit.ttd(units.dyn40) > cast.time.rapidFire()
    then
        if cast.rapidFire() then ui.debug("Casting Rapid Fire [Trick Shots Surging Shots]") return true end
    end
    -- Aimed Shot
    -- aimed_shot,target_if=min:dot.serpent_sting.remains+action.serpent_sting.in_flight_to_target*99,if=buff.trick_shots.remains>=execute_time&(buff.precise_shots.down|full_recharge_time<cast_time+gcd|buff.trueshot.up)
    if cast.able.aimedShot(var.lowestAimedSerpentSting) and not unit.moving("player") and unit.ttd(units.dyn40) > cast.time.aimedShot() and buff.trickShots.remains() >= cast.time.aimedShot()
        and (not buff.preciseShots.exists() or charges.aimedShot.timeTillFull() < cast.time.aimedShot() + unit.gcd(true) or buff.trueshot.exists())
    then
        if cast.aimedShot(var.lowestAimedSerpentSting) then ui.debug("Casting Aimed Shot [Trick Shots]") return true end
    end
    -- Death Chakram
    -- death_chakram,if=focus+cast_regen<focus.max
    if ui.alwaysCdNever("Covenant Ability") and cast.able.deathChakram() and power.focus.amount() + cast.regen.deathChakram() < power.focus.max() then
        if cast.deathChakram() then ui.debug("Casting Death Chakram [Trick Shots Necrolord]") return true end
    end
    -- Rapid Fire
    -- rapid_fire,if=buff.trick_shots.remains>=execute_time
    if cast.able.rapidFire() and buff.trickShots.remains() >= cast.time.rapidFire() and unit.ttd(units.dyn40) > cast.time.rapidFire() then
        if cast.rapidFire() then ui.debug("Casting Rapid Fire [Trick Shots]") return true end
    end
    -- Multishot
    -- multishot,if=buff.trick_shots.down|buff.precise_shots.up&focus>cost+action.aimed_shot.cost&(!talent.chimaera_shot|active_enemies>3)
    if cast.able.multishot() and (not buff.trickShots.exists() or buff.preciseShots.exists()
        and power.focus.amount() > cast.cost.multishot() + cast.cost.aimedShot() and (not talent.chimaeraShot or #enemies.yards8t > 3))
        and #enemies.yards8t > 0
    then
        if cast.multishot() then ui.debug("Casting Multishot [Trick Shots]") return true end
    end
    -- Chimaera Shot
    -- chimaera_shot,if=buff.precise_shots.up&focus>cost+action.aimed_shot.cost&active_enemies<4
    if cast.able.chimaeraShot() and buff.preciseShots.exists() and power.focus.amount() > cast.cost.chimaeraShot() + cast.cost.aimedShot() and #enemies.yards8t < 4 then
        if cast.chimaeraShot() then ui.debug("Casting Chimaera Shot [Trick Shots]") return true end
    end
    -- Kill Shot
    -- kill_shot,if=buff.dead_eye.down
    if cast.able.killShot(var.lowestHPUnit) and unit.hp(var.lowestHPUnit) < 20 and not buff.deadEye.exists() then
        if cast.killShot(var.lowestHPUnit) then ui.debug("Casting Kill Shot [Trick Shots Dead Eye]") return true end
    end
    -- Flayed Shot
    -- flayed_shot
    if ui.alwaysCdNever("Covenant Ability") and cast.able.flayedShot() then
        if cast.flayedShot() then ui.debug("Casting Flayed Shot [Trick Shots Venthhyr]") return true end
    end
    -- Serpent Sting
    -- serpent_sting,target_if=min:dot.serpent_sting.remains,if=refreshable
    if cast.able.serpentSting(var.lowestSerpentSting) and talent.serpentSting and debuff.serpentSting.refresh(var.lowestSerpentSting) then
        if cast.serpentSting(var.lowestSerpentSting) then ui.debug("Casting Serpent Sting [Trick Shots]") return true end
    end
    -- Multishot
    -- multishot,if=focus>cost+action.aimed_shot.cost
    if cast.able.multishot() and power.focus.amount() > cast.cost.multishot() + cast.cost.aimedShot() and #enemies.yards8t > 0 then
        if cast.multishot() then ui.debug("Casting Multishot [Trick Shots]") return true end
    end
    -- Steady Shot
    -- steady_shot
    if cast.able.steadyShot() and unit.ttd(units.dyn40) > cast.time.steadyShot() and power.focus.amount() <= cast.cost.arcaneShot() + cast.cost.aimedShot() then
        if cast.steadyShot() then ui.debug("Casting Steady Shot [Trick Shots]") return true end
    end
end -- End Action List - aoe

-- Action List - Extras
actionList.extra = function()
    -- Feign Death
    if buff.feignDeath.exists() then
        StopAttack()
        ClearTarget()
    end
    -- Hunter's Mark
    if ui.checked("Hunter's Mark") and cast.able.huntersMark() and not debuff.huntersMark.exists(units.dyn40) then
        if cast.huntersMark() then ui.debug("Cast Hunter's Mark") return true end
    end
    --  FlayedWignToxin
    if use.able.bottledFlayedWingToxin() and not buff.flayedWingToxin.exists("player") then
        use.bottledFlayedWingToxin()
    end
    --Dummy Test
    if ui.checked("Dummy DPS Testing") then
        if unit.exists("target") then
            if getCombatTime() >= (tonumber(ui.value("Dummy DPS Testing"))*60) and unit.isDummy() then
                StopAttack()
                ClearTarget()
                PetStopAttack()
                PetFollow()
                Print(tonumber(ui.value("Dummy DPS Testing")) .." Minute Dummy Test Concluded - Profile Stopped")
                var.profileStop = true
            end
        end
    end -- End Dummy Test
    -- Misdirection
    if ui.mode.misdirection == 1 then
        local misdirectUnit = nil
        if unit.valid("target") and unit.distance("target") < 40 and not unit.isCasting("player") then
            -- Misdirect to Tank
            if ui.value("Misdirection") == 1 then
                local tankInRange, tankUnit = isTankInRange()
                if tankInRange then misdirectUnit = tankUnit end
                -- Additional pre-emptive logic for MD
                if ui.checked("Misdirection pre-emptive logic") then
                    --TODO
                end
            end
            -- Misdirect to Focus
            if ui.value("Misdirection") == 2 and unit.friend("focus","player") then
                misdirectUnit = "focus"
            end
            -- Misdirect to Pet
            if ui.value("Misdirection") == 3 then
                misdirectUnit = "pet"
            end
            -- Failsafe to Pet, if unable to misdirect to Tank or Focus
            if misdirectUnit == nil then misdirectUnit = "pet" end
            if misdirectUnit and cast.able.misdirection() and unit.exists(misdirectUnit) and unit.distance(misdirectUnit) < 40 and not unit.deadOrGhost(misdirectUnit) then
                if cast.misdirection(misdirectUnit) then ui.debug("Casting Misdirection on "..unit.name(misdirectUnit)) return true end
            end
        end
    end
end -- End Action List - Extras

-- Action List - CCs
actionList.CCs = function()
    if ui.mode.cC == 1 then
        if getCurrentZoneId() == maps.Revendreth.Zones.CastleNathria then
            if ui.checked ("Castle Nathria (Huntsman - Shade of Bargast)") then
                if not isFreezingTrapActive() then
                    return cast.freezingTrap(ccMobFinder(171557),"groundCC")
                end
            end
        end
        if getCurrentZoneId() == maps.Maldraxxus.Zones.Plaguefall then
            if ui.checked("Plaguefall (Globgrog - Slimy Smorgasbord)") then
                if not isFreezingTrapActive() then
                    return cast.freezingTrap(ccMobFinder(171887),"groundCC")
                end
            end
            if ui.checked("Plaguefall (Defender of Many Eyes, Bulwark of Maldraxxus)") then
                if not isFreezingTrapActive() then
                    return cast.freezingTrap(ccMobFinder(163862,_,_,336449),"groundCC")
                end
            end
            if ui.checked("Plaguefall (Rotting Slimeclaw)") then
                return cast.bindingShot(ccMobFinder(163892,25),"groundCC")
            end
        end
        if getCurrentZoneId() == maps.Ardenweald.Zones.MistsOfTirnaScithe then
            if ui.checked("Mists of Tirna Scithe (Mistcaller - Illusionary Vulpin)") then
                if not isFreezingTrapActive() then
                    return cast.freezingTrap(ccMobFinder(165251),"groundCC")
                end
            end
        end
        if getCurrentZoneId() == maps.Bastion.Zones.TheNecroticWake then
            if ui.checked("The Necrotic Wake (Blightbone  - Carrion Worms)") then
                return cast.bindingShot(ccMobFinder(164702),"groundCC")
            end
        end
        if getCurrentZoneId() == maps.Maldraxxus.Zones.TheaterOfPain then
            if ui.checked("Theater of Pain (Disgusting Refuse)") then
                return cast.bindingShot(ccMobFinder(163089),"groundCC")
            end
        end
        if getCurrentZoneId() == maps.Revendreth.Zones.HallsOfAtonement then
            if ui.checked("Halls of Atonement (Vicious Gargon, Loyal Beasts)") then
                return cast.bindingShot(ccMobFinder(164563,_,_,326450),"groundCC")
            end
        end
    end
end -- End Action List - CCs

-- Action List - Interrupts
actionList.Interrupts = function()
    -- if ui.useInterrupt() then
    --     for i=1, #enemies.yards40f do
    --         local thisUnit = enemies.yards40f[i]
    --         for k,v in pairs(br.lists.interruptWhitelist) do
    --             if thisUnit.isUnitCasting(k) then
    --                 local distance = unit.distance(thisUnit)
    --                 if canInterrupt(thisUnit,ui.value("Interrupt At")) then
    --                     if distance < 50 then
    --                         -- Counter Shot
    --                         if ui.checked("Counter Shot") then
    --                             if cast.counterShot(thisUnit) then ui.debug("Casting Counter Shot") return true end
    --                         end
    --                         -- Freezing Trap
    --                         if ui.checked("Freezing Trap") then
    --                             if cast.freezingTrap(thisUnit,ground) then ui.debug("Casting Freezing Trap") return true end
    --                         end
    --                     end
    --                 end
    --             end
    --         end
    --     end
    -- end -- End useInterrupts check
end -- End Action List - Interrupts

----------------
--- ROTATION ---
----------------
local function runRotation()
    ---------------
    --- Defines ---
    ---------------
    buff                                          = br.player.buff
    cast                                          = br.player.cast
    cd                                            = br.player.cd
    charges                                       = br.player.charges
    covenant                                      = br.player.covenant
    debuff                                        = br.player.debuff
    enemies                                       = br.player.enemies
    equiped                                       = br.player.equiped
    power                                         = br.player.power
    runeforge                                     = br.player.runeforge
    spell                                         = br.player.spell
    talent                                        = br.player.talent
    items                                         = br.player.items
    ui                                            = br.player.ui
    unit                                          = br.player.unit
    units                                         = br.player.units
    use                                           = br.player.use
    var                                           = br.player.variables

    -- Get required enemies table
    units.get(40)
    enemies.get(8,"target")
    enemies.get(40)
    enemies.get(40,"player",false,true)

    -- Variables
    if var.profileStop == nil then var.profileStop = false end
    var.haltProfile = (unit.inCombat() and var.profileStop) or (unit.mounted() or unit.flying()) or pause() or buff.feignDeath.exists() or ui.mode.rotation==4

    -- Aimed Shots Serpent Sting spread
    var.lowestSerpentSting = debuff.serpentSting.lowest(40,"remain") or "target"
    var.serpentInFlight = cast.inFlight.serpentSting() and 1 or 0
    var.lowestAimedSerpentSting = "target"
    var.lowestAimedRemain = 99
    var.lowestHPUnit = "target"
    var.lowestHP = 100
    for i = 1, #enemies.yards8t do
        local thisUnit = enemies.yards8t[i]
        local thisHP = unit.hp(thisUnit)
        local serpentStingRemain = debuff.serpentSting.remain(thisUnit) + var.serpentInFlight * 99
        if ui.mode.rotation < 3 and serpentStingRemain < var.lowestAimedRemain then
            var.lowestAimedRemain = serpentStingRemain
            var.lowestAimedSerpentSting = thisUnit
        end
        if thisHP < var.lowestHP then
            var.lowestHP = thisHP
            var.lowestHPUnit = thisUnit
        end
    end

    ---------------------
    --- Begin Profile ---
    ---------------------
    -- Profile Stop | Pause
    if not unit.inCombat() and not unit.exists("target") and var.profileStop then
        var.profileStop = false
    elseif var.haltProfile and (not unit.isCasting() or pause(true)) then
        StopAttack()
        return true
    else
        if actionList.extra() then return true end
        if actionList.pc() then return true end
        -- IN COMBAT
        if unit.inCombat() and var.profileStop == false and unit.valid(units.dyn40) and unit.distance(units.dyn40) < 40
            and not cast.current.barrage() and not cast.current.rapidFire() and not cast.current.aimedShot() and not cast.current.steadyShot()
        then
            if actionList.CCs() then return true end
            if actionList.Interrupts() then return true end
            if actionList.aa() then return true end
            if actionList.cds() then return true end
            if ui.useST(8,nil,"target") then
                return actionList.st()
            end
            if ui.useAOE(8,3,"target") then
                return actionList.aoe()
            end
        end --End In Combat
    end --End Rotation Logic
end -- End runRotation
local id = 254
if br.rotations[id] == nil then br.rotations[id] = {} end
tinsert(br.rotations[id],{
    name = rotationName,
    toggles = createToggles,
    options = createOptions,
    run = runRotation,
})