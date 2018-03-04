def format_recipe($recipe): gsub("\n[•\\*][A-Za-z ]"; "&&&")
| split("&&&")
| (if (. | length) == 0 then
   {} 
   elif ((.[0] | contains(":")) and (.[-1] | contains("*"))) then
    {
      publication: (.[0] | sub(":"; "")),
      steps: (.[1:-2] + (.[-1] | split("\n")[:-1])),
      garnishes: (.[-1] | split("***")[-2])
    }
  elif (.[0] | contains(":")) then
    {
      publication: (.[0] | sub(":"; "")),
      steps: .[1:] | map(split("\n")) | flatten(1),
      garnishes: []
    }
  elif (.[-1] | contains("*")) then
    {
      publication: [],
      steps: (.[1:-2] + (.[-1] | split("\n")[:-1])),
      garnishes: (.[-1] | split("***")[-2])
    }
  else
    {}
  end)
;

.[]
| (.recipe_1  |= format_recipe(.))
| (.recipe_2  |= format_recipe(.))
| (.recipe_3  |= format_recipe(.))
| (.recipe_4  |= format_recipe(.))
| (.recipe_5  |= format_recipe(.))
| (.recipe_6  |= format_recipe(.))
| (.recipe_7  |= format_recipe(.))
| (.recipe_8  |= format_recipe(.))
| (.recipe_9  |= format_recipe(.))
| (.recipe_10 |= format_recipe(.))
| (.recipe_11 |= format_recipe(.))
| { 
    week,
    title,
    recipes: ([
      .recipe_1,
      .recipe_2,
      .recipe_3,
      .recipe_4,
      .recipe_5,
      .recipe_6,
      .recipe_7,
      .recipe_8,
      .recipe_9,
      .recipe_10,
      .recipe_11
    ] | map(select(length > 0)))
  }
