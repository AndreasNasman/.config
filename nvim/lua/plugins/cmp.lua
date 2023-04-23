---@param sources cmp.SourceConfig[]
local function create_lookups_from_sources(sources)
  local group_index_to_sources = {}
  local group_indexes = {}

  for _, source in ipairs(sources) do
    local group_index = source.group_index
    local existing_sources = group_index_to_sources[group_index]

    if existing_sources then
      table.insert(existing_sources, source)
    else
      if not group_index then
        error("All sources must have a defined `group_index`.")
      end
      group_index_to_sources[group_index] = { source }
      table.insert(group_indexes, group_index)
    end
  end

  table.sort(group_indexes)

  local index_to_sources = {}
  local source_name_to_index = {}

  for index, group_index in ipairs(group_indexes) do
    local sources_by_group_index = group_index_to_sources[group_index]
    table.insert(index_to_sources, sources_by_group_index)

    for _, source in ipairs(sources_by_group_index) do
      source_name_to_index[source.name] = index
    end
  end

  return {
    source_name_to_index = source_name_to_index,
    index_to_sources = index_to_sources,
  }
end

return {
  "hrsh7th/nvim-cmp",
  ---@param opts cmp.ConfigSchema
  opts = function(_, opts)
    opts.completion = {
      completeopt = "menu,menuone,noselect",
    }

    -- https://www.lazyvim.org/configuration/recipes#supertab
    local has_words_before = function()
      unpack = unpack or table.unpack
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end

    local luasnip = require("luasnip")
    local cmp = require("cmp")

    opts.mapping = vim.tbl_extend("force", opts.mapping, {
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
        -- they way you will only jump inside the snippet region
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
    })

    local lookups = create_lookups_from_sources(opts.sources)
    local source_name_to_index = lookups.source_name_to_index
    local index_to_sources = lookups.index_to_sources
    local first_index = 1
    local last_index = vim.tbl_count(index_to_sources)
    local index = first_index
    local should_open_current_source = true

    ---Adjust index when completion window is opened automatically.
    ---@param arg { window: cmp.CustomEntriesView }
    cmp.event:on("menu_opened", function(arg)
      local first_entry = arg.window.get_first_entry(arg.window)
      if first_entry.context.option.reason == cmp.ContextReason.Auto then
        index = source_name_to_index[first_entry.source.name]
      end
    end)

    ---Preserve the current source when the completion window is closed
    ---manually.
    ---@param arg { window: cmp.CustomEntriesView }
    cmp.event:on("menu_closed", function(arg)
      local first_entry = arg.window.get_first_entry(arg.window)
      if first_entry then
        should_open_current_source = true
      end
    end)

    ---Preserve the current source when a completion is accepted.
    cmp.event:on("confirm_done", function()
      should_open_current_source = true
    end)

    opts.mapping = vim.tbl_extend("force", opts.mapping, {
      ["<C-Space>"] = cmp.mapping(function()
        if should_open_current_source then
          -- No index adjustment is needed when the current source should be
          -- (re)opened.
          should_open_current_source = false
        else
          -- Find the index of the next source to open.
          -- Adjusting the index before opening the next source allows cycling
          -- through empty sources, e.g. Copilot that is still loading.
          if index == last_index then
            index = first_index
          else
            index = index + 1
          end
        end

        cmp.complete({
          config = {
            sources = index_to_sources[index],
          },
        })
      end, { "i", "s" }),
      ["<CR>"] = cmp.mapping.confirm({ select = false }),
      ["<C-l>"] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
      }),
    })

    opts.window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    }
  end,
}
