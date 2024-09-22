-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- To see dotfile and gitignored files, you can use the following setup:
require("neo-tree").setup({
    filesystem = {
      filtered_items = {
        visible = true, -- Keep dotfiles visible
        hide_dotfiles = false, -- Show dotfiles (like .env)
        hide_gitignored = false, -- Optionally show gitignored files
        hide_by_name = { -- Hide specific directories by name
          ".git",
          "node_modules"
        }
      }
    }
  })
  
  -- To use powershell instead of cmd, you can use the following setup:
  vim.opt.shell = "powershell"
  vim.opt.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command"
  vim.opt.shellquote = ""
  vim.opt.shellxquote = ""
  
-- TO apply autosave after a second of leaving insert mode or when text is changed, you can use the following setup:
local autosave_timer = nil

function AutoSave()
  if autosave_timer then
    vim.fn.timer_stop(autosave_timer) -- Stop any existing timer
  end
  autosave_timer = vim.fn.timer_start(1000, function() -- Delay in ms (1000ms = 1 second)
    if vim.bo.modified then
      vim.cmd("silent write") -- Save the file silently
    end
  end)
end

-- Trigger autosave after leaving insert mode or when text is changed
vim.api.nvim_create_autocmd({"InsertLeave", "TextChanged"}, {
  callback = AutoSave
})
  