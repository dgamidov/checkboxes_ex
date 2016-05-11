defmodule CheckboxesEx.ColorTest do
  use CheckboxesEx.ModelCase

  alias CheckboxesEx.Color

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Color.changeset(%Color{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Color.changeset(%Color{}, @invalid_attrs)
    refute changeset.valid?
  end
end
