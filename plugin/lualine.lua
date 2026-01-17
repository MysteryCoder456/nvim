local function xcodebuild_device()
    if vim.g.xcodebuild_platform == "macOS" then
        return " macOS"
    end

    local deviceIcon = ""
    if vim.g.xcodebuild_platform:match("watch") then
        deviceIcon = "􀟤"
    elseif vim.g.xcodebuild_platform:match("tv") then
        deviceIcon = "􀡴 "
    elseif vim.g.xcodebuild_platform:match("vision") then
        deviceIcon = "􁎖 "
    end

    if vim.g.xcodebuild_os then
        return deviceIcon .. " " .. vim.g.xcodebuild_device_name .. " (" .. vim.g.xcodebuild_os .. ")"
    end

    return deviceIcon .. " " .. vim.g.xcodebuild_device_name
end

require("lualine").setup {
    sections = {
        lualine_x = { xcodebuild_device, 'filetype' },
    }
}
