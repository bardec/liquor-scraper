.[] 
| select(
    .size == "1.75L" 
    or .size == "1.0 Liter" 
    or .size == "200ML" 
    or .size == "1L" 
    or .size == "50ML" 
    or .size == "5L" 
    or .size == "750ML" 
    or .size == "375ML"
  )
| {
  title,
  type,
  link,
  milliliters: (if .size == "1.75L" then
    1750
  elif .size == "200ML" then
    200
  elif .size == "1L" then
    1000
  elif .size == "50ML" then
    50
  elif .size == "5L" then
    5000
  elif .size == "750ML" then
    750
  elif .size == "375ML" then
    375
  else
    .size
  end)
}
