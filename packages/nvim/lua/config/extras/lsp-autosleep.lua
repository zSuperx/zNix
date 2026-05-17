local uv = vim.uv or vim.loop
local shutting_down = false

local stop_timer = nil
local start_timer = nil

local lsps_to_ignore = {}

local START_TIMEOUT_MS = 1000 * 3 -- 3 seconds
local STOP_TIMEOUT_MS = 1000 * 60 * 10 -- 10 minutes

local stopped = {}

local function clear_timer(timer)
	if timer then
		timer:stop()
		timer:close()
	end
end

-- After 4 seconds of inactivity, a STOP_TIMEOUT_MS timer will be started.
-- If that timer finishes, LSPs will be shut down
vim.api.nvim_create_autocmd("CursorHold", {
	callback = function()
    -- If we somehow were triggered twice, just back off
		if stop_timer then
			return
		end

    -- Create timer
		stop_timer = uv.new_timer()
		if not stop_timer then
			vim.notify("failed to create stop timer", vim.log.levels.ERROR)
			return
		end

		stop_timer:start(
			STOP_TIMEOUT_MS,
			0,
			vim.schedule_wrap(function()
				local active_lsps = vim.lsp.get_clients()

        -- Naive locking yay!!!
				shutting_down = true

        -- Iter through active LSP clients and slaughter them like animals
				for _, lsp in ipairs(active_lsps) do
					if vim.tbl_contains(lsps_to_ignore, lsp.name) == false then
						stopped[lsp.name] = true
						lsp:stop(true)
					end
				end

				shutting_down = false

				clear_timer(stop_timer)
				stop_timer = nil
			end)
		)
	end,
})

-- If "movement" is detected, the stop timer will be canceled if it exists
-- But if any LSPs were stopped by that timer, then this autocmd will restart
-- them
vim.api.nvim_create_autocmd({
	"CursorMoved",
	"InsertEnter",
	"BufEnter",
}, {
	callback = function()
    -- Naive locking: don't do anything if we're currently in the process of shutting down
		if shutting_down then
			return
		end

		-- Otherwise, activity detected: cancel the stop timer if it exists
		if stop_timer then
			clear_timer(stop_timer)
			stop_timer = nil
		end

		-- Nothing to restart, just leave
		if vim.tbl_isempty(stopped) then
			return
		end

		-- If the start_timer exists already, it means this autocmd was triggered
    -- already and we're waiting to start LSPs. If this is the case, back off
		if start_timer then
			return
		end

    -- Create timer
		start_timer = uv.new_timer()
		if not start_timer then
			vim.notify("failed to create start timer", vim.log.levels.ERROR)
			return
		end

		start_timer:start(
			START_TIMEOUT_MS,
			0,
			vim.schedule_wrap(function()
				local names = vim.tbl_keys(stopped)

				vim.print(
					("%dms are up! Starting the following LSPs: %s"):format(START_TIMEOUT_MS, table.concat(names, ", "))
				)

				vim.lsp.enable(names, true)

				stopped = {}

				clear_timer(start_timer)
				start_timer = nil
			end)
		)
	end,
})
