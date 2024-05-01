-- If this env var is present when running neovim, it will not add any of the following autocmd's.
if vim.env.NO_TRACK_SESSION then
  return
end

-- Autocommand that saves the session upon exiting Neovim
vim.api.nvim_create_autocmd("VimLeave", {
  pattern = "*",
  callback = function()
    -- Specify the path where you want to save the session
    local session_file_path = vim.fn.stdpath('data') .. '/session.vim'
    vim.cmd('mksession! ' .. session_file_path)
  end
})

-- Save the last cwd in the session
vim.api.nvim_create_autocmd("VimLeave", {
  pattern = "*",
  callback = function()
    local session_dir_path = vim.fn.stdpath('data') .. '/lastdir'
    local current_dir = vim.fn.getcwd()
    local file = io.open(session_dir_path, "w")
    if file then
      file:write(current_dir)
      file:close()
    end
  end
})

vim.api.nvim_create_autocmd("VimEnter", {
  pattern = "*",
  callback = function()
    local session_file_path = vim.fn.stdpath('data') .. '/session.vim'
    if vim.fn.argc() == 0 and vim.fn.filereadable(session_file_path) == 1 then
      vim.cmd('source ' .. session_file_path)

      -- Delay execution to allow session to fully load
      vim.defer_fn(function()
        local original_buf = vim.api.nvim_get_current_buf()
        -- Iterate over all buffers and apply BufRead autocommands except for netrw
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
          local buftype = vim.api.nvim_buf_get_option(buf, 'buftype')
          local filetype = vim.api.nvim_buf_get_option(buf, 'filetype')
          if buftype ~= 'nofile' and filetype ~= 'netrw' then
            vim.api.nvim_buf_call(buf, function()
              vim.cmd('silent! doautocmd BufRead')
            end)
          end
        end

        -- Run BufRead autocommands for the original buffer, checking its filetype
        local original_filetype = vim.api.nvim_buf_get_option(original_buf, 'filetype')
        if original_filetype ~= 'netrw' then
          vim.api.nvim_buf_call(original_buf, function()
            vim.cmd('silent! doautocmd BufRead')
          end)
        end
      end, 0) -- Delay time in milliseconds, adjust if necessary
    end
  end
})

vim.api.nvim_create_autocmd("VimEnter", {
  pattern = "*",
  callback = function()
    local session_dir_path = vim.fn.stdpath('data') .. '/lastdir'
    if vim.fn.filereadable(session_dir_path) == 1 then
      local file, err = io.open(session_dir_path, "r")
      if not file then
        vim.notify("Could not open the session directory file: " .. err, vim.log.levels.ERROR)
        return
      end
      local last_dir = file:read("*all")
      file:close() -- Close the file safely
      if last_dir and vim.fn.isdirectory(last_dir) == 1 then
        vim.fn.chdir(last_dir)
      else
        vim.notify("Last directory recorded is not valid or does not exist.", vim.log.levels.INFO)
      end
      vim.fn.delete(session_dir_path) -- Optional: remove the file after reading
    end
  end
})
