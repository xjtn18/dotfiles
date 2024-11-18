-- Define a global function to execute a command based on the file type
function _G.run_file()
  -- Get the current buffer's file name and file type
  local filename = vim.fn.expand("%:p")
  local filetype = vim.bo.filetype
  local command = ""

  -- Define commands for different file types
  if filetype == "python" then
    command = "python " .. filename
  elseif filetype == "javascript" then
    command = "node " .. filename
  elseif filetype == "typescript" then
    command = "ts-node-esm " .. filename
  else
    print("No run command defined for file type: " .. filetype)
    return
  end

  -- Run the command in a new terminal buffer
  vim.cmd(":lcd " .. vim.fn.expand("%:p:h"))
  vim.cmd(":! " .. command)
end

-- Bind F6 to the run_file function
vim.api.nvim_set_keymap('n', '<F6>', ':lua _G.run_file()<CR>', { noremap = true, silent = true })
