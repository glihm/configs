---------------------------------------------------
-- Licensed under the GNU General Public License v2
--  * (c) 2009, Adrian C. <anrxc@sysphere.org>
--  * (c) 2009, Rémy C. <shikamaru@mandriva.org>
--  * (c) Wicked, Lucas de Vries
---------------------------------------------------

-- {{{ Grab environment
local pairs = pairs
local string = {
    sub = string.sub,
    gsub = string.gsub
}
-- }}}


-- Helpers: provides helper functions for vicious widgets
module("vicious.helpers")


-- {{{ Variable definitions
local scroller = {}
-- }}}

-- {{{ Helper functions
-- {{{ Format a string with args
function format(format, args)
    for var, val in pairs(args) do
        format = string.gsub(format, "$" .. var, val)
    end

    return format
end
-- }}}

-- {{{ Escape a string
function escape(text)
    local xml_entities = {
        ["\""] = "&quot;",
        ["&"]  = "&amp;",
        ["'"]  = "&apos;",
        ["<"]  = "&lt;",
        [">"]  = "&gt;"
    }

    return text and text:gsub("[\"&'<>]", xml_entities)
end
-- }}}

-- {{{ Truncate a string
function truncate(text, maxlen)
    local txtlen = text:len()

    if txtlen > maxlen then
        text = string.sub(text, 1, maxlen - 3) .. "..."
    end

    return text
end
-- }}}

-- {{{ Scroll through a string
function scroll(text, maxlen, widget)
    if not scroller[widget] then
        scroller[widget] = { i = 1, d = true }
    end

    local txtlen = text:len()
    local state  = scroller[widget]

    if txtlen > maxlen then
        if state.d then
            text = string.sub(text, state.i, state.i + maxlen) .. "..."
            state.i = state.i + 3

            if maxlen + state.i >= txtlen then
                state.d = false
            end
        else
            text = "..." .. string.sub(text, state.i, state.i + maxlen)
            state.i = state.i - 3

            if state.i <= 1 then
                state.d = true
            end
        end
    end

    return text
end
-- }}}
-- }}}
