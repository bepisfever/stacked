function Stacked.round(number, digit_position) 
    digit_position = digit_position or 0
    if not number then return end
    local precision = 10 ^ -digit_position
    number = number + (precision / 2)
    return math.floor(number / precision) * precision
end

function Stacked.isxmult(str)
    if str and type(str) == "string" then
        local hasX = string.lower(string.sub(str,1,1)) == "x"
        if hasX then
            local forming_mult = ""
            for i = 1,#str do
                local chr = string.sub(str,i,i)
                forming_mult = forming_mult..string.lower(chr)
            end
            forming_mult = string.gsub(forming_mult,"_","")
            forming_mult = string.gsub(forming_mult," ","")
            if string.find(forming_mult, "mult") then
                return true
            end
        end
    end
    return false
end

function Stacked.ismult(str)
    if str and type(str) == "string" then
        if string.find(string.lower(str), "mult") and not Stacked.isxmult(str) then
            return true
        end
    end
    return false
end

function Stacked.isxchips(str)
    if str and type(str) == "string" then
        local hasX = string.lower(string.sub(str,1,1)) == "x"
        if hasX then
            local forming_mult = ""
            for i = 1,#str do
                local chr = string.sub(str,i,i)
                forming_mult = forming_mult..string.lower(chr)
            end
            forming_mult = string.gsub(forming_mult,"_","")
            forming_mult = string.gsub(forming_mult," ","")
            if string.find(forming_mult, "chip") then
                return true
            end
        end
    end
    return false
end

function Stacked.ischips(str)
    if str and type(str) == "string" then
        if string.find(string.lower(str), "chip") and not Stacked.isxchips(str) then
            return true
        end
    end
    return false
end

function Stacked.is_food_joker(joker) --thanks dilly
    if joker.ability.isFood then
        return joker.ability.isFood
    end
    local food_jokers = {
        ['j_gros_michel'] = true,
        ['j_cavendish'] = true,
        ['j_turtle_bean'] = true,
        ['j_ice_cream'] = true,
        ['j_popcorn'] = true,
        ['j_ramen'] = true,
        ['j_seltzer'] = true,
        ['j_diet_cola'] = true,
        ['j_egg'] = true,
    }

    return food_jokers[joker.config.center.key]
end

function table.clone(t) --Clones a table.
    local ret = {}
    for i,v in pairs(t) do
        ret[i] = (type(v) == "table" and table.clone(v)) or v
    end
    return ret
end

function SMODS.stacked_localize_box(lines, args) 
    local final_line = {}
    for _, part in ipairs(lines) do
        local assembled_string = ''
        for _, subpart in ipairs(part.strings) do
            assembled_string = assembled_string..(type(subpart) == 'string' and subpart or format_ui_value(args.vars[tonumber(subpart[1])]) or 'ERROR')
        end
        local desc_scale = (SMODS.Fonts[part.control.f] or G.FONTS[tonumber(part.control.f)] or G.LANG.font).DESCSCALE
        if G.F_MOBILE_UI then desc_scale = desc_scale*1.5 end
        if part.control.E then
            local _float, _silent, _pop_in, _bump, _spacing = nil, true, nil, nil, nil
            if part.control.E == '1' then
                _float = true; _silent = true; _pop_in = 0
            elseif part.control.E == '2' then
                _bump = true; _spacing = 1
            end
            final_line[#final_line+1] = {n=G.UIT.C, config={minh = 0, align = "m", colour = part.control.B and args.vars.colours[tonumber(part.control.B)] or part.control.X and loc_colour(part.control.X) or nil, r = 0.05, padding = 0, res = 0.15}, nodes={}}
            final_line[#final_line].nodes[1] = {n=G.UIT.O, config={ minh = 0, padding = 0,
            object = DynaText({string = {assembled_string}, colours = {part.control.V and args.vars.colours[tonumber(part.control.V)] or loc_colour(part.control.C or nil)},
                float = _float,
                silent = _silent,
                pop_in = _pop_in,
                bump = _bump,
                spacing = _spacing,
                shadow = args.shadow,
                font = SMODS.Fonts[part.control.f] or (tonumber(part.control.f) and G.FONTS[tonumber(part.control.f)]),
                scale = 0.32*(part.control.s and tonumber(part.control.s) or args.scale  or 1)*desc_scale*(args.fixed_scale or 1)})
            }}
        elseif part.control.X or part.control.B then
            final_line[#final_line+1] = {n=G.UIT.C, config={minh = 0, align = "m", colour = part.control.B and args.vars.colours[tonumber(part.control.B)] or loc_colour(part.control.X), r = 0.05, padding = 0, res = 0.15}, nodes={
                {n=G.UIT.T, config={
                minh = 0,
                padding = 0,
                text = assembled_string,
                shadow = args.shadow,
                colour = part.control.V and args.vars.colours[tonumber(part.control.V)] or loc_colour(part.control.C or nil),
                font = SMODS.Fonts[part.control.f] or (tonumber(part.control.f) and G.FONTS[tonumber(part.control.f)]),
                scale = 0.32*(part.control.s and tonumber(part.control.s) or args.scale  or 1)*desc_scale*(args.fixed_scale or 1)}},
            }}
        else
            final_line[#final_line+1] = {n=G.UIT.T, config={
                box_minh = 0,
                detailed_tooltip = part.control.T and (G.P_CENTERS[part.control.T] or G.P_TAGS[part.control.T]) or nil,
                text = assembled_string,
                shadow = args.shadow,
                colour = part.control.V and args.vars.colours[tonumber(part.control.V)] or not part.control.C and args.text_colour or loc_colour(part.control.C or nil, args.default_col),
                font = SMODS.Fonts[part.control.f] or (tonumber(part.control.f) and G.FONTS[tonumber(part.control.f)]),
                scale = 0.32*(part.control.s and tonumber(part.control.s) or args.scale  or 1)*desc_scale*(args.fixed_scale or 1)},
            }
        end
    end
    return final_line
end

SMODS.stylize_text = function(text, args)
    if not text then return end
    if type(text) ~= "table" then text = {text} end
    local args = args or {}
    local loc_dir1 = args.loc_dir1 or "misc"
    local loc_dir2 = args.loc_dir2 or "v_text_parsed"
    local key = args.key or "SMODS_stylize_text"
    local function deep_find(t, index)
        if type(index) ~= "table" then index = {index} end
        for _,idv_index in ipairs(index) do
            if t[idv_index] then return true end
            for i,v in pairs(t) do
                if i == idv_index then return true end
                if type(v) == "table" then
                    return deep_find(v, idv_index)
                end
            end
        end
        return false
    end
    if deep_find(text, "control") then 
        if not args.no_loc_save then G.localization[loc_dir1][loc_dir2] = text end 
        return text 
    end

    local a = {"text", "name", "unlock"}
    if not args.no_loc_save then
        local loc = G.localization[loc_dir1][loc_dir2]
        loc[key] = {}
        if deep_find(text, a) then
            for _,v in ipairs(a) do
                text[v] = text[v] or {}
                text[v.."_parsed"] = text[v.."_parsed"] or {}
            end
            if text.text then
                for _,v in ipairs(text.text) do
                    if type(v) == "table" then
                        text.text_parsed[#text.text_parsed+1] = {}
                        for _, vv in ipairs(v) do
                            text.text_parsed[#text.text_parsed][#text.text_parsed[#text.text_parsed]+1] = loc_parse_string(vv)
                        end
                    else
                        text.text_parsed[#text.text_parsed+1] = loc_parse_string(v)
                    end
                end
            end
            if text.name then
                for _,v in ipairs((type(text.name) == "string" and {text.name}) or text.name) do
                    text.name_parsed[#text.name_parsed+1] = loc_parse_string(v)
                end
            end
            if text.unlock then
                for _,v in ipairs(text.unlock) do
                    text.unlock_parsed[#text.unlock_parsed+1] = loc_parse_string(v)
                end
            end
            loc[key] = text
        else
            for i,v in ipairs(text) do
                loc[key][i] = loc_parse_string(v)
            end
        end
        return loc[key]
    else
        local loc = {}
        if deep_find(text, a) then
            for _,v in ipairs(a) do
                text[v] = text[v] or {}
                text[v.."_parsed"] = text[v.."_parsed"] or {}
            end
            if text.text then
                for _,v in ipairs(text.text) do
                    if type(v) == "table" then
                        text.text_parsed[#text.text_parsed+1] = {}
                        for _, vv in ipairs(v) do
                            text.text_parsed[#text.text_parsed][#text.text_parsed[#text.text_parsed]+1] = loc_parse_string(vv)
                        end
                    else
                        text.text_parsed[#text.text_parsed+1] = loc_parse_string(v)
                    end
                end
            end
            if text.name then
                for _,v in ipairs((type(text.name) == "string" and {text.name}) or text.name) do
                    text.name_parsed[#text.name_parsed+1] = loc_parse_string(v)
                end
            end
            if text.unlock then
                for _,v in ipairs(text.unlock) do
                    text.unlock_parsed[#text.unlock_parsed+1] = loc_parse_string(v)
                end
            end
            loc = text
        else
            for i,v in ipairs(text) do
                loc[i] = loc_parse_string(v)
            end
        end
        
        return loc
    end
end

function SMODS.localize(args, misc_cat)
    if args and not (type(args) == 'table') then
        if misc_cat and G.localization.misc[misc_cat] then return G.localization.misc[misc_cat][args] or 'ERROR' end
        return G.localization.misc.dictionary[args] or 'ERROR'
    end
    args = args or {}
    args.nodes = args.nodes or {}

    local loc_target = args.loc_target or nil
    if args.stylize then loc_target = SMODS.stylize_text(loc_target) end
    local ret_string = nil
    if args.type == 'other' then
        if not loc_target then loc_target = G.localization.descriptions.Other[args.key] end
    elseif args.type == 'descriptions' or args.type == 'unlocks' then 
        if not loc_target then loc_target = G.localization.descriptions[args.set][args.key] end
    elseif args.type == 'tutorial' then 
        if not loc_target then loc_target = G.localization.tutorial_parsed[args.key] end
    elseif args.type == 'quips' then 
        if not loc_target then loc_target = G.localization.quips_parsed[args.key] end
    elseif args.type == 'raw_descriptions' then 
        if not loc_target then loc_target = G.localization.descriptions[args.set][args.key] end
        local multi_line = {}
        if loc_target then 
            for _, lines in ipairs(args.type == 'unlocks' and loc_target.unlock_parsed or args.type == 'name' and loc_target.name_parsed or args.type == 'text' and loc_target or loc_target.text_parsed) do
                local final_line = ''
                for _, part in ipairs(lines) do
                    local assembled_string = ''
                    for _, subpart in ipairs(part.strings) do
                        assembled_string = assembled_string..(type(subpart) == 'string' and subpart or format_ui_value(args.vars[tonumber(subpart[1])]) or 'ERROR')
                    end
                    final_line = final_line..assembled_string
                end
                multi_line[#multi_line+1] = final_line
            end
        end
        return multi_line
    elseif args.type == 'text' then
        if not loc_target then loc_target = G.localization.misc.v_text_parsed[args.key] end
    elseif args.type == 'variable' then 
        if not loc_target then loc_target = G.localization.misc.v_dictionary_parsed[args.key] end
        if not loc_target then return 'ERROR' end 
        if loc_target.multi_line then
            local assembled_strings = {}
            for k, v in ipairs(loc_target) do
                local assembled_string = ''
                for _, subpart in ipairs(v[1].strings) do
                    assembled_string = assembled_string..(type(subpart) == 'string' and subpart or format_ui_value(args.vars[tonumber(subpart[1])]))
                end
                assembled_strings[k] = assembled_string
            end
            return assembled_strings or {'ERROR'}
        else
            local assembled_string = ''
            for _, subpart in ipairs(loc_target[1].strings) do
                assembled_string = assembled_string..(type(subpart) == 'string' and subpart or format_ui_value(args.vars[tonumber(subpart[1])]))
            end
            ret_string = assembled_string or 'ERROR'
        end
    elseif args.type == 'name_text' then
        if pcall(function()
            local name_text = (loc_target and loc_target.name) or G.localization.descriptions[(args.set or args.node.config.center.set)][args.key or args.node.config.center.key].name
            if type(name_text) == "table" then
                ret_string = ""
                for i, line in ipairs(name_text) do
                    ret_string = ret_string.. (i ~= 1 and " " or "")..line
                end
            else
                ret_string = name_text
            end
        end) then
        else ret_string = "ERROR" end
    elseif args.type == 'name' then
        loc_target = loc_target or {}
        if pcall(function()
            local name = loc_target or G.localization.descriptions[(args.set or args.node.config.center.set)][args.key or args.node.config.center.key]
            loc_target.name_parsed = name.name_parsed or {loc_parse_string(name.name)}
        end) then
        else loc_target.name_parsed = {} end
    end

    if ret_string and type(ret_string) == 'string' then ret_string = string.gsub(ret_string, "{.-}", "") end
    if ret_string then return ret_string end

    if loc_target then 
        args.AUT = args.AUT or {}
        args.AUT.box_colours = {}
        if (args.type == 'descriptions' or args.type == 'other') and type(loc_target.text) == 'table' and type(loc_target.text[1]) == 'table' then
            args.AUT.multi_box = {}
            for i, box in ipairs(loc_target.text_parsed) do
                for j, line in ipairs(box) do
                    local final_line = SMODS.localize_box(line, args)
                    if i == 1 or next(args.AUT.info) then
                        args.nodes[#args.nodes+1] = final_line -- Sends main box to AUT.main
                        if not next(args.AUT.info) then args.nodes.main_box_flag = true end
                    elseif not next(args.AUT.info) then 
                        args.AUT.multi_box[i-1] = args.AUT.multi_box[i-1] or {}
                        args.AUT.multi_box[i-1][#args.AUT.multi_box[i-1]+1] = final_line
                    end
                    if not next(args.AUT.info) then args.AUT.box_colours[i] = args.vars.box_colours and args.vars.box_colours[i] or G.C.UI.BACKGROUND_WHITE end
                end
            end
            return
        end
        for _, lines in ipairs(args.type == 'unlocks' and loc_target.unlock_parsed or args.type == 'name' and loc_target.name_parsed or (args.type == 'text' or args.type == 'tutorial' or args.type == 'quips') and loc_target or loc_target.text_parsed) do
            local final_line = {}
            local final_name_assembled_string = ''
            if args.type == 'name' and loc_target.name_parsed then
                for _, part in ipairs(lines) do
                    local assembled_string_part = ''
                    for _, subpart in ipairs(part.strings) do
                        assembled_string_part = assembled_string_part..(type(subpart) == 'string' and subpart or format_ui_value(format_ui_value(args.vars[tonumber(subpart[1])])) or 'ERROR')
                    end
                    final_name_assembled_string = final_name_assembled_string..assembled_string_part
                end
            end
            for _, part in ipairs(lines) do
                local assembled_string = ''
                for _, subpart in ipairs(part.strings) do
                    assembled_string = assembled_string..(type(subpart) == 'string' and subpart or format_ui_value(args.vars[tonumber(subpart[1])]) or 'ERROR')
                end
                local desc_scale = (SMODS.Fonts[part.control.f] or G.FONTS[tonumber(part.control.f)] or G.LANG.font).DESCSCALE
                if G.F_MOBILE_UI then desc_scale = desc_scale*1.5 end
                if args.type == 'name' then
                    final_line[#final_line+1] = {n=G.UIT.C, config={align = "m", colour = part.control.B and args.vars.colours[tonumber(part.control.B)] or part.control.X and loc_colour(part.control.X) or nil, r = 0.05, padding = 0.03, res = 0.15}, nodes={}}
                    final_line[#final_line].nodes[1] = {n=G.UIT.O, config={
                        object = DynaText({string = {assembled_string},
                            colours = {(part.control.V and args.vars.colours[tonumber(part.control.V)]) or (part.control.C and loc_colour(part.control.C)) or args.text_colour or G.C.UI.TEXT_LIGHT},
                            bump = not args.no_bump,
                            silent = not args.no_silent,
                            pop_in = (not args.no_pop_in and (args.pop_in or 0)) or nil,
                            pop_in_rate = (not args.no_pop_in and (args.pop_in_rate or 4)) or nil,
                            maxw = args.maxw or 5,
                            shadow = not args.no_shadow,
                            y_offset = args.y_offset or -0.6,
                            spacing = (not args.no_spacing and (args.spacing or 1) * math.max(0, 0.32*(17 - #(final_name_assembled_string or assembled_string)))) or nil,
                            font = SMODS.Fonts[part.control.f] or G.FONTS[tonumber(part.control.f)] or (SMODS.Fonts[args.font] or G.FONTS[args.font]),
                            scale = (0.55 - 0.004*#(final_name_assembled_string or assembled_string))*(part.control.s and tonumber(part.control.s) or args.scale or 1)*(args.fixed_scale or 1)
                        })
                    }}
                elseif part.control.E then
                    local _float, _silent, _pop_in, _bump, _spacing = nil, true, nil, nil, nil
                    if part.control.E == '1' then
                        _float = true; _silent = true; _pop_in = 0
                    elseif part.control.E == '2' then
                        _bump = true; _spacing = 1
                    end
                    final_line[#final_line+1] = {n=G.UIT.C, config={align = "m", colour = part.control.B and args.vars.colours[tonumber(part.control.B)] or part.control.X and loc_colour(part.control.X) or nil, r = 0.05, padding = 0.03, res = 0.15}, nodes={}}
                    final_line[#final_line].nodes[1] = {n=G.UIT.O, config={
                        object = DynaText({string = {assembled_string}, colours = {part.control.V and args.vars.colours[tonumber(part.control.V)] or loc_colour(part.control.C or nil)},
                            float = _float,
                            silent = _silent,
                            pop_in = _pop_in,
                            bump = _bump,
                            spacing = (args.spacing or 1) * _spacing,
                            font = SMODS.Fonts[part.control.f] or G.FONTS[tonumber(part.control.f)] or (SMODS.Fonts[args.font] or G.FONTS[args.font]),
                            scale = 0.32*(part.control.s and tonumber(part.control.s) or args.scale or 1)*desc_scale*(args.fixed_scale or 1)
                        })
                    }}
                elseif part.control.X or part.control.B then
                    final_line[#final_line+1] = {n=G.UIT.C, config={align = "m", colour = part.control.B and args.vars.colours[tonumber(part.control.B)] or loc_colour(part.control.X), r = 0.05, padding = 0.03, res = 0.15}, nodes={
                        {n=G.UIT.T, config={
                            text = assembled_string,
                            font = SMODS.Fonts[part.control.f] or G.FONTS[tonumber(part.control.f)] or (SMODS.Fonts[args.font] or G.FONTS[args.font]),
                            colour = part.control.V and args.vars.colours[tonumber(part.control.V)] or loc_colour(part.control.C or nil),
                            scale = 0.32*(part.control.s and tonumber(part.control.s) or args.scale or 1)*desc_scale*(args.fixed_scale or 1)
                        }},
                    }}
                else
                    final_line[#final_line+1] = {n=G.UIT.T, config={
                        detailed_tooltip = part.control.T and (G.P_CENTERS[part.control.T] or G.P_TAGS[part.control.T]) or nil,
                        text = assembled_string,
                        font = SMODS.Fonts[part.control.f] or G.FONTS[tonumber(part.control.f)] or (SMODS.Fonts[args.font] or G.FONTS[args.font]),
                        shadow = not args.no_shadow or args.shadow,
                        colour = part.control.V and args.vars.colours[tonumber(part.control.V)] or not part.control.C and args.text_colour or loc_colour(part.control.C or nil, args.default_col),
                        scale = 0.32*(part.control.s and tonumber(part.control.s) or args.scale or 1)*desc_scale*(args.fixed_scale or 1)
                    }}
                end
            end
            if args.type == 'text' then return final_line end
            if not args.nodes and args.type == 'name' then args.nodes = {} end
            args.nodes[#args.nodes+1] = final_line
        end
        if args.type == 'name' then
            local final_name = {}
        
            for _, line in ipairs(args.nodes or {}) do
                final_name[#final_name+1] = {n=G.UIT.R, config={align = "m"}, nodes=line}
            end
        
            return final_name
        end
    end

    return args.nodes
end