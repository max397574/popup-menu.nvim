local popup_menu = {}
local log = require("popup_menu.log")
popup_menu.menus = {}

local create_cmd = vim.api.nvim_create_user_command

local function open_menu(menu_name)
    vim.pretty_print(popup_menu.menus[menu_name])
end

local function create_commands()
    create_cmd("OpenMenu", function(arg)
        open_menu(arg.args)
    end, {
        nargs = 1,
        complete = function()
            return vim.tbl_keys(popup_menu.menus)
        end,
    })
end

function popup_menu.setup()
    create_commands()
end

--- Creates a new popup menu
---@param name string
---@param menu_config table
function popup_menu.new_menu(name, menu_config)
    vim.validate({
        name = { name, "string" },
        menu_config = { menu_config, "table" },
    })
    if popup_menu.menus[name] then
        log.warn("A menu with this name already exists. It's overwritten now.")
    end
    popup_menu.menus[name] = menu_config
end

return popup_menu
