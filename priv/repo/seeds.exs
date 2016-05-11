# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     CheckboxesEx.Repo.insert!(%CheckboxesEx.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

import Ecto.Query, only: [from: 2]

alias CheckboxesEx.Repo
alias CheckboxesEx.{Color, Size, Product}

#
# Add default colors

for color <- ~w(white black blue green yellow) do
  Repo.get_by(Color, name: color) || Repo.insert!(%Color{name: color})
end

#
# Add default sizes

for size <- ["XS", "S", "M", "L", "XL", "One size"] do
  Repo.get_by(Size, name: size) || Repo.insert!(%Size{name: size})
end

#
# Add default products
for name <- ~w(first second third) do
  Repo.insert!(%Product{name: name, price: 1500})
end

#
# Add colors for products

product_ids = Repo.all from p in Product, select: p.id
color_ids = Repo.all(from c in Color, select: c.id) |> Enum.take_random(3)

for product_id <- product_ids do
  for color_id <- color_ids do
    Repo.insert_all "products_colors", [[product_id: product_id, parameter_id: color_id]]
  end
end

#
# Add sizes for products

size_ids = Repo.all(from s in Size, select: s.id) |> Enum.take_random(4)

for product_id <- product_ids do
  for size_id <- size_ids do
    Repo.insert_all "products_sizes", [[product_id: product_id, parameter_id: size_id]]
  end
end
