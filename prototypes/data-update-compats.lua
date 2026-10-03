local tech = data.raw.technology["calciner"]

if mods["pelagos"] then
	--data.raw["item"]["calciner"].default_import_location = "pelagos"
	--table.insert(data.raw["recipe"]["calciner"].ingredients, { type = "item", name = "coconut-sealant", amount = 20 })
	--data.raw["recipe"]["calciner"].surface_conditions = {
	--	{
	--		property = "pressure",
	--		min = 1809,
	--		max = 1809,
	--	},
	--}
	data:extend({
		{
			type = "recipe",
			categories = { "calcining" },
			name = "calciner-coconut-husk-carbonization",
			icons = {
				{
					icon = "__pelagos__/graphics/coconut-husk.png",
					icon_size = 64,
					tint = { r = 0.3, g = 0.3, b = 0.3, a = 1 },
				},
			},
			enabled = false,
			energy_required = 4.5,
			allow_productivity = true,
			ingredients = {
				{ type = "item", name = "coconut-husk", amount = 4 },
			},
			results = { { type = "item", name = "coal", amount = 1 } },
			auto_recycle = false,
		},
	})
	-- the coconut husk comes from coconut processing
	local coconut_tech = data.raw.technology["coconut-processing-technology"]
	if coconut_tech then
		coconut_tech.effects = coconut_tech.effects or {}
		table.insert(coconut_tech.effects, {
			type = "unlock-recipe",
			recipe = "calciner-coconut-husk-carbonization",
		})
	end
end

-- special glass recipes for compatibility with mods that add glass
if mods["space-age"] then
	local glass = data.raw.item["kr-glass"] or data.raw.item["glass"]
	if glass then
		data:extend({
			{
				type = "recipe",
				name = "calciner-mineral-glass",
				categories = { "calcining" },
				ingredients = {
					{ type = "item", name = "calcite", amount = 4 },
				},
				results = {
					{ type = "item", name = glass.name, amount = 1 },
				},
				icons = {
					{ icon = glass.icon, icon_size = 64 },
					{
						icon = "__space-age__/graphics/icons/calcite.png",
						icon_size = 64,
						scale = 0.3,
						shift = { 8, 8 },
					},
				},
				icon_size = glass.icon_size,
				allow_productivity = true,
				enabled = false,
				auto_recycle = false,
			},
		})
	end
	-- add mineral glass if glass exist
	if tech and data.raw.recipe["calciner-mineral-glass"] then
		table.insert(tech.effects, {
			type = "unlock-recipe",
			recipe = "calciner-mineral-glass",
		})
	end
end
if mods["Krastorio2"] then
	data.raw["recipe"]["calciner-advanced-steel-smelting"].ingredients = {
		{ type = "item", name = "iron-plate", amount = 5 },
		{ type = "item", name = "activated-carbon", amount = 2 },
	}

	data.raw["recipe"]["calciner-advanced-steel-smelting"].results = {
		{ type = "item", name = "steel-plate", amount = 3 },
	}
end

if tech and mods["space-age"] then
	table.insert(tech.effects, {
		type = "unlock-recipe",
		recipe = "calciner-coal-purification",
	})
	table.insert(tech.effects, {
		type = "unlock-recipe",
		recipe = "calciner-calcite-brick",
	})
	table.insert(tech.effects, {
		type = "unlock-recipe",
		recipe = "calciner-fish-calcining",
	})
end
