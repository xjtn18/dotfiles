-- @NOTE :: This doesnt work when searching for terms that include an open paren. There are probably some other special symbols that mess with the matching logic...


-- Function to start the custom search
vim.keymap.set('n', '/', function()
  local current_win = vim.api.nvim_get_current_win()
  local current_buf = vim.api.nvim_get_current_buf()
  local ns_id = vim.api.nvim_create_namespace('no_jump_search')

  -- Create a floating window for input
  local input_buf = vim.api.nvim_create_buf(false, true) -- Create a scratch buffer
  local width = math.floor(vim.o.columns * 0.8)
  local height = 1
  local row = vim.o.lines - 3
  local col = math.floor((vim.o.columns - width) / 2)
  local opts = {
    style = 'minimal',
    relative = 'editor',
    width = width,
    height = height,
    row = row,
    col = col,
    border = 'single',
  }
  local input_win = vim.api.nvim_open_win(input_buf, true, opts)

  -- Set buffer options
  vim.api.nvim_buf_set_option(input_buf, 'buftype', 'prompt')
  vim.api.nvim_buf_set_option(input_buf, 'bufhidden', 'wipe')
  vim.api.nvim_buf_set_option(input_buf, 'buflisted', false)
  vim.api.nvim_buf_set_option(input_buf, 'swapfile', false)
  vim.fn.prompt_setprompt(input_buf, '/')

  -- Start in insert mode
  vim.cmd('startinsert')

  -- Function to close the search window and clear highlights
  local function close_search()
    -- Close the floating window
    if vim.api.nvim_win_is_valid(input_win) then
      vim.api.nvim_win_close(input_win, true)
    end
    -- Clear highlights
    vim.api.nvim_buf_clear_namespace(current_buf, ns_id, 0, -1)
    -- Detach the buffer to stop the on_lines callback
    if vim.api.nvim_buf_is_valid(input_buf) then
      vim.api.nvim_buf_detach(input_buf)
    end
  end

  -- Function to count matches
  local function count_matches(pattern)
    local num_matches = 0
    if pattern ~= '' then
      -- Escape the pattern for Lua patterns
      local escaped_pattern = vim.pesc(pattern)
      -- Search and count matches
      local start_line = 0
      local end_line = vim.api.nvim_buf_line_count(current_buf) - 1
      for line_num = start_line, end_line do
        local line = vim.api.nvim_buf_get_lines(current_buf, line_num, line_num + 1, false)[1]
        local start_col = 1
        while true do
          local s, e = line:find(escaped_pattern, start_col)
          if s == nil then break end
          num_matches = num_matches + 1
          start_col = e + 1
          if start_col > #line then break end
        end
      end
    end
    return num_matches
  end

  -- Function to update highlights
  local function update_highlights()
    -- Get the current pattern from the input buffer
    local lines = vim.api.nvim_buf_get_lines(input_buf, 0, -1, false)
    local pattern = lines[1]:sub(2) -- remove the leading '/'

    -- Clear previous matches
    vim.api.nvim_buf_clear_namespace(current_buf, ns_id, 0, -1)
    if pattern ~= '' then
      -- Escape the pattern for Lua patterns
      local escaped_pattern = vim.pesc(pattern)
      -- Search and highlight matches
      local start_line = 0
      local end_line = vim.api.nvim_buf_line_count(current_buf) - 1
      for line_num = start_line, end_line do
        local line = vim.api.nvim_buf_get_lines(current_buf, line_num, line_num + 1, false)[1]
        local start_col = 1
        while true do
          local s, e = line:find(escaped_pattern, start_col)
          if s == nil then break end
          -- Add highlight to the match
          vim.api.nvim_buf_add_highlight(current_buf, ns_id, 'Search', line_num, s - 1, e)
          start_col = e + 1
          if start_col > #line then break end
        end
      end
    end
  end

  -- Attach to the input buffer to detect changes
  vim.api.nvim_buf_attach(input_buf, false, {
    on_lines = function()
      update_highlights()
    end,
    on_detach = function()
      -- Clear highlights when the input buffer is detached (closed)
      vim.api.nvim_buf_clear_namespace(current_buf, ns_id, 0, -1)
    end,
  })

  -- Set up keymaps for the input buffer using Lua functions directly
  vim.api.nvim_buf_set_keymap(input_buf, 'i', '<Esc>', '', {
    noremap = true,
    callback = function()
      close_search()
    end,
  })
  vim.api.nvim_buf_set_keymap(input_buf, 'n', '<Esc>', '', {
    noremap = true,
    callback = function()
      close_search()
    end,
  })

  vim.fn.prompt_setcallback(input_buf, function(text)
    -- Callback function when Enter is pressed
    -- Close the floating window
    close_search()
    -- Set the search register
    vim.fn.setreg('/', text)
    -- Enable 'hlsearch' to keep matches highlighted
    vim.o.hlsearch = true

    -- Count the matches
    local num_matches = count_matches(text:sub(2)) -- remove the leading '/'

    -- Display the number of matches
    vim.schedule(function()
      vim.cmd(string.format('echo "%d matches found"', num_matches))
    end)
  end)

  -- Initial highlight update
  update_highlights()
end)
