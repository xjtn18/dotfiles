-- Configuring the naming behavior of tabs
vim.cmd('set tabline=%!v:lua.GetTabLine()')

function GetTabLine()
   local tabs = BuildTabs()
   local line = ''
   for i, tab in ipairs(tabs) do
      line = line .. ((i == vim.fn.tabpagenr()) and '%#TabLineSel#' or '%#TabLine#')
      line = line .. '%' .. i .. 'T'
      line = line .. ' ' .. tab.uniq_name .. ' '
   end
   line = line .. '%#TabLineFill#%T'
   return line
end

function BuildTabs()
   local tabs = {}
   for i = 1, vim.fn.tabpagenr('$') do
      local tabnum = i
      local buflist = vim.fn.tabpagebuflist(tabnum)
      local file_path = ''
      local tab_name = vim.fn.bufname(buflist[1])
      if tab_name:find('NERD_tree') and #buflist > 1 then
         tab_name = vim.fn.bufname(buflist[2])
      end
      local is_custom_name = 0
      if tab_name == '' then
         tab_name = '[No Name]'
         is_custom_name = 1
      elseif tab_name:find('fzf') then
         tab_name = 'FZF'
         is_custom_name = 1
      else
         file_path = vim.fn.fnamemodify(tab_name, ':p')
         tab_name = vim.fn.fnamemodify(tab_name, ':p:t')
      end
      local tab = {
         name = tab_name,
         uniq_name = tab_name,
         file_path = file_path,
         is_custom_name = is_custom_name
      }
      table.insert(tabs, tab)
   end
   CalculateTabUniqueNames(tabs)
   return tabs
end

function CalculateTabUniqueNames(tabs)
   for _, tab in ipairs(tabs) do
      if tab.is_custom_name == 1 then goto continue end
      local tab_common_path = ''
      for _, other_tab in ipairs(tabs) do
         if tab.name ~= other_tab.name or tab.file_path == other_tab.file_path
            or other_tab.is_custom_name == 1 then
            goto continue
         end
         local common_path = GetCommonPath(tab.file_path, other_tab.file_path)
         if tab_common_path == '' or #common_path < #tab_common_path then
            tab_common_path = common_path
         end
         ::continue::
      end
      if tab_common_path == '' then goto continue end
      local common_path_has_immediate_child = false
      for _, other_tab in ipairs(tabs) do
         if tab.name == other_tab.name and other_tab.is_custom_name == 0
            and tab_common_path == vim.fn.fnamemodify(other_tab.file_path, ':h') then
            common_path_has_immediate_child = true
            break
         end
      end
      if common_path_has_immediate_child then
         tab_common_path = vim.fn.fnamemodify(tab_common_path, ':h')
      end
      tab.uniq_name = vim.fn.fnamemodify(tab.file_path, ':h:t')
      ::continue::
   end
end

function GetCommonPath(path1, path2)
   local dirs1 = vim.split(path1, '/', true)
   local dirs2 = vim.split(path2, '/', true)
   local i_different = 0
   for i, dir in ipairs(dirs1) do
      if dirs1[i] ~= dirs2[i] then
         i_different = i
         break
      end
   end
   return table.concat(dirs1, '/', 1, i_different - 1)
end

